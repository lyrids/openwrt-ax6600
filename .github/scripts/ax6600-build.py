#!/usr/bin/env python3
"""Prepare a public AX6600 build and verify its actual release payloads."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import stat
import subprocess
import tarfile
import tempfile

ROOT = Path(__file__).resolve().parents[2]
MODES = ("11.4", "12.5", "dual-11.4", "dual-12.5")
FIRMWARE = {
    "11.4": "3a0133598bdd7a53faffdcc68667e20b831d3e09cf12760966c016058e946f41",
    "12.5": "3c7708960681859a24d964895dff166f2336de8ccaae4ba9e7e39f272561ccee",
}
PREFIX = "openwrt-qualcommax-ipq60xx-jdcloud_re-cs-02"


def selection(mode):
    if mode not in MODES:
        raise ValueError("Unsupported firmware selection")
    default = mode.removeprefix("dual-")
    return default, set(FIRMWARE) if mode.startswith("dual-") else {default}


def run(*args):
    return subprocess.check_output(list(map(str, args)), cwd=ROOT)


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + "\n")


def seed(mode):
    default, versions = selection(mode)
    text = (ROOT / "configs/ax6600-public.config").read_text()
    for line in FIRMWARE:
        key = "CONFIG_NSS_FIRMWARE_VERSION_" + line.replace(".", "_")
        text += key + "=y\n" if line == default else "# " + key + " is not set\n"
    text += ("CONFIG_NSS_FIRMWARE_INCLUDE_ALL=y\n" if len(versions) == 2
             else "# CONFIG_NSS_FIRMWARE_INCLUDE_ALL is not set\n")
    return text


def runtime_config(mode):
    default, _ = selection(mode)
    text = (ROOT / "package/kernel/nss-wifi-drv/files/nss-wifi.config").read_text()
    text, count = re.subn(r"option firmware '[^']+'", "option firmware '" + default + "'", text)
    if count != 1:
        raise ValueError("Expected exactly one NSS firmware selector")
    return text.encode()


def prepare(mode):
    # CI must not inherit the ignored lab overlay from a developer checkout.
    files = ROOT / "files"
    if files.is_symlink() or (files.exists() and any(files.iterdir())):
        raise ValueError("Refusing an existing files/ overlay; use a clean checkout")
    os.umask(0o022)
    files.mkdir(exist_ok=True)
    files.chmod(0o755)
    for directory in ("etc", "etc/config"):
        (files / directory).mkdir(exist_ok=True)
        (files / directory).chmod(0o755)
    config = files / "etc/config/nss-wifi"
    config.write_bytes(runtime_config(mode))
    config.chmod(0o600)
    (ROOT / ".config").write_text(seed(mode))
    shutil.copyfile(ROOT / "configs/ax6600.feeds.conf", ROOT / "feeds.conf")
    out = ROOT / "ci-output"
    out.mkdir(exist_ok=True)
    (out / "config.seed").write_text(seed(mode))
    shutil.copyfile(ROOT / "feeds.conf", out / "feeds.conf")


def check_config(mode):
    config = (ROOT / ".config").read_text().splitlines()
    for line in seed(mode).splitlines():
        if line.startswith(("CONFIG_", "# CONFIG_")) and line not in config:
            raise ValueError("defconfig did not preserve " + line)
    devices = [line for line in config if re.fullmatch(r"CONFIG_TARGET_.*_DEVICE_.*=y", line)]
    if devices != ["CONFIG_TARGET_qualcommax_ipq60xx_DEVICE_jdcloud_re-cs-02=y"]:
        raise ValueError("Unexpected target devices: " + repr(devices))
    feeds = {}
    for line in (ROOT / "configs/ax6600.feeds.conf").read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        kind, name, url = line.split()
        if kind != "src-git":
            raise ValueError("Only pinned git feeds are supported")
        commit = url.rsplit("^", 1)[-1]
        if not re.fullmatch("[0-9a-f]{40}", commit):
            raise ValueError("Unpinned feed: " + name)
        actual = run("git", "-C", ROOT / "feeds" / name, "rev-parse", "HEAD").decode().strip()
        if actual != commit:
            raise ValueError("Feed pin mismatch: " + name)
        feeds[name] = commit
    overlay = ROOT / "files"
    if overlay.is_symlink():
        raise ValueError("Unexpected overlay symlink")
    paths = {str(p.relative_to(overlay)) for p in overlay.rglob("*")}
    if paths != {"etc", "etc/config", "etc/config/nss-wifi"}:
        raise ValueError("Only the public NSS selection may be overlaid")
    if (overlay / "etc/config/nss-wifi").read_bytes() != runtime_config(mode):
        raise ValueError("Incorrect public NSS default")
    out = ROOT / "ci-output"
    shutil.copyfile(ROOT / ".config", out / "config.full")
    save(out / "feed-pins.json", feeds)


def cpio(data):
    result = {}
    offset = 0
    while offset + 110 <= len(data):
        header = data[offset:offset + 110]
        if header[:6] not in (b"070701", b"070702"):
            raise ValueError("Invalid initramfs header")
        fields = [int(header[6 + n * 8:14 + n * 8], 16) for n in range(13)]
        start = offset + 110
        name = data[start:start + fields[11] - 1].decode()
        offset = (start + fields[11] + 3) & ~3
        payload = data[offset:offset + fields[6]]
        if len(payload) != fields[6]:
            raise ValueError("Truncated initramfs")
        offset = (offset + fields[6] + 3) & ~3
        if name == "TRAILER!!!":
            return result
        path = "/" + name.removeprefix("./").lstrip("/")
        if ".." in path.split("/") or path in result:
            raise ValueError("Unsafe or duplicate initramfs path")
        result[path] = (fields[1], fields[2], fields[3], payload)
    raise ValueError("Incomplete initramfs")


def fit_files(image, temporary):
    compressed = temporary / "kernel.gz"
    run("dumpimage", "-T", "flat_dt", "-p", "0", "-o", compressed, image)
    kernel = gzip.decompress(compressed.read_bytes())
    offset = 0
    while True:
        offset = kernel.find(bytes.fromhex("28b52ffd"), offset)
        if offset < 0:
            raise ValueError("No complete embedded zstd initramfs")
        process = subprocess.run(
            [str(ROOT / "staging_dir/host/bin/zstd"), "-dc"],
            input=kernel[offset:], capture_output=True, timeout=60)
        offset += 4
        if not process.stdout.startswith((b"070701", b"070702")):
            continue
        try:
            entries = cpio(process.stdout)
        except ValueError:
            continue
        if "/etc/config/nss-wifi" in entries:
            return entries


def verify_payload(mode, read, names):
    _, versions = selection(mode)
    actual = {v for v in FIRMWARE if "/lib/firmware/qca-nss0-retail-" + v + ".bin" in names}
    if actual != versions:
        raise ValueError("Wrong packaged NSS versions")
    for version in versions:
        payload = read("/lib/firmware/qca-nss0-retail-" + version + ".bin")
        if hashlib.sha256(payload).hexdigest() != FIRMWARE[version]:
            raise ValueError("Unexpected firmware digest: " + version)
    if read("/etc/config/nss-wifi") != runtime_config(mode):
        raise ValueError("Boot selector does not match requested default")


def collect(mode):
    check_config(mode)
    default, versions = selection(mode)
    target = ROOT / "bin/targets/qualcommax/ipq60xx"
    fit = target / (PREFIX + "-initramfs-uImage.itb")
    upgrade = target / (PREFIX + "-squashfs-sysupgrade.bin")
    if not fit.is_file() or not upgrade.is_file():
        raise ValueError("Both AX6600 output formats are required")
    with tempfile.TemporaryDirectory() as directory:
        temporary = Path(directory)
        ram = fit_files(fit, temporary)
        verify_payload(mode, lambda path: ram[path][3], ram)
        for path in ("/etc", "/lib", "/sbin", "/usr", "/etc/config"):
            permissions, uid, gid, _ = ram[path]
            if not stat.S_ISDIR(permissions) or stat.S_IMODE(permissions) != 0o755 or uid or gid:
                raise ValueError("Unexpected public image directory metadata: " + path)
        for path in ram:
            if path.startswith(("/root/.ssh/", "/etc/wireguard/")) or re.fullmatch(
                    r"/etc/dropbear/dropbear_.*_host_key", path):
                raise ValueError("Unexpected provisioned credentials: " + path)
        symlink = ram["/lib/firmware/qca-nss0-retail.bin"]
        if not stat.S_ISLNK(symlink[0]) or symlink[3].rstrip(b"\0").decode() != (
                "qca-nss0-retail-" + default + ".bin"):
            raise ValueError("Wrong default firmware symlink")
        with tarfile.open(upgrade) as archive:
            members = [m for m in archive.getmembers() if m.isfile() and m.name.endswith("/root")]
            if len(members) != 1:
                raise ValueError("Missing unique sysupgrade root payload")
            root = temporary / "root.squashfs"
            root.write_bytes(archive.extractfile(members[0]).read())
        unsquash = ROOT / "staging_dir/host/bin/unsquashfs4"
        listing = run(unsquash, "-lln", root).decode()
        names = {"/lib/firmware/" + name for name in re.findall(
            r"squashfs-root/lib/firmware/(qca-nss0-retail-[0-9.]+\.bin)", listing)}
        verify_payload(mode, lambda path: run(unsquash, "-cat", root, path.lstrip("/")), names)

    out = ROOT / "ci-output"
    release = out / "firmware"
    release.mkdir(exist_ok=False)
    for file in (fit, upgrade):
        shutil.copyfile(file, release / file.name)
    for name in ("config.buildinfo", "feeds.buildinfo", "version.buildinfo", "profiles.json"):
        shutil.copyfile(target / name, release / name)
    shutil.copyfile(target / (PREFIX + ".manifest"), release / (PREFIX + ".manifest"))
    for name in ("config.seed", "config.full", "feeds.conf", "feed-pins.json"):
        shutil.copyfile(out / name, release / name)
    provenance = {
        "source_commit": run("git", "rev-parse", "HEAD").decode().strip(),
        "device": "jdcloud,re-cs-02", "target": "qualcommax/ipq60xx",
        "nss_selection": mode, "default_firmware": default,
        "firmware_sha256": {v: FIRMWARE[v] for v in sorted(versions)},
        "feeds": json.loads((out / "feed-pins.json").read_text()),
        "source_date_epoch": run("git", "show", "-s", "--format=%ct", "HEAD").decode().strip(),
        "github_run": os.environ.get("GITHUB_RUN_ID"),
        "github_attempt": os.environ.get("GITHUB_RUN_ATTEMPT"),
        "verification": "Pinned payload hashes and default selector checked in final FIT and SquashFS",
        "qualification": "Public development build; no hardware or stability qualification",
    }
    save(out / "provenance.json", provenance)
    save(release / "provenance.json", provenance)
    compiler = next((ROOT / "staging_dir").glob("toolchain-*/bin/aarch64-openwrt-linux-musl-gcc"))
    (out / "toolchain.txt").write_bytes(run(compiler, "--version"))
    shutil.copyfile(out / "toolchain.txt", release / "toolchain.txt")
    notes = f"""# AX6600 public trial image

Device: **JDCloud RE-CS-02 / AX6600**, Qualcomm IPQ6010. This is not a generic
image for every product marketed as AX6600. Check the exact board model.

Source: `{provenance['source_commit']}`.
Packaged NSS: **{', '.join(sorted(versions))}**; boot default: **{default}**.
Wi-Fi NSS enabled; separate Ethernet-only NSS backend disabled.

Uses standard OpenWrt first-boot network, firewall and wireless defaults.
No personal passwords, SSH keys, VPN policy, lab addresses or WAN SSH exception
are provisioned. Connect through a LAN port and set an administrator password
before enabling wireless. Configuration retained by sysupgrade can override
these first-boot defaults; this release does not reset an existing device.

The `initramfs-uImage.itb` is for a compatible RAM/recovery boot procedure.
The `squashfs-sysupgrade.bin` is for an existing supported OpenWrt installation,
not an instruction to flash from stock firmware. Preserve calibration data and
use the board-specific recovery procedure. Do not force an incompatible upgrade.

Verify files using `sha256sum --check SHA256SUMS`. Configurations, feed pins,
package manifest, compiler identity and provenance are included for reproduction.
This is a development prerelease. The build checks firmware contents and selector
in both output formats; it does not prove successful boot or stability on your
device. Historical unexplained reset/recovery findings remain open.

For a dual-firmware image installed persistently, select the next boot with:
```sh
uci set nss-wifi.general.firmware='12.5'  # or '11.4'
uci commit nss-wifi
```
Reboot is required. A single-firmware image can select only its packaged version.
RAM-boot settings do not persist into a fresh RAM boot.
"""
    (release / "RELEASE-NOTES.md").write_text(notes)
    sums = "".join(hashlib.sha256(path.read_bytes()).hexdigest() + "  " + path.name + "\n"
                   for path in sorted(release.iterdir()))
    (release / "SHA256SUMS").write_text(sums)
    print(json.dumps(provenance, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=("prepare", "check-config", "collect"))
    parser.add_argument("mode", choices=MODES)
    args = parser.parse_args()
    {"prepare": prepare, "check-config": check_config, "collect": collect}[args.command](args.mode)
