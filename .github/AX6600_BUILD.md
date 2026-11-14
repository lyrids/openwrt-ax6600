# Public AX6600 GitHub builds

The **Build AX6600** workflow produces public trial firmware for the
**JDCloud RE-CS-02 / AX6600 (IPQ6010)**. Other devices sold under the AX6600
speed class are not supported by this board image.

## Run a build

Once this workflow is on the repository's default branch, open **Actions →
Build AX6600 → Run workflow**, select the source branch and NSS mode, and run it.

| Selection | Included firmware | First-boot default |
|---|---|---|
| `11.4` | 11.4.0.5 release 6 | 11.4 |
| `12.5` | 12.5 release 210 | 12.5 |
| `dual-11.4` | Both | 11.4 |
| `dual-12.5` | Both | 12.5 |

The checked-out workflow branch supplies the source. Feed commits are pinned in
[ax6600.feeds.conf](../configs/ax6600.feeds.conf); the public seed is
[ax6600-public.config](../configs/ax6600-public.config). Update pins deliberately
and revalidate them when advancing the source base.

The build uses a GitHub-hosted Ubuntu runner, with no deployment credentials or
lab restore archive. It generates only a public NSS selection overlay and refuses
an existing developer overlay. Standard OpenWrt network, DHCP, firewall, wireless
and first-login defaults are retained; NSS Wi-Fi offload is enabled and the
Ethernet-only NSS backend remains disabled. LuCI and basic diagnostic tools are
included. No WAN SSH exception, personal password, VPN policy, lab addressing or
preinstalled host keys are added.

## Download the trial images

A successful build publishes a **GitHub prerelease** under **Releases** with the
NSS choice and source commit in its title. No release is published after a failed
build or verification. Firmware is also retained as Actions artifacts for14 days;
release assets remain available until the release is removed.

Download the appropriate image and `SHA256SUMS` from that release. The included
package manifest, complete build configuration, seed, feed pins, compiler version
and provenance identify that particular build. Checksum verification is easiest
after downloading all assets:

```sh
sha256sum --check SHA256SUMS
```

- `*-initramfs-uImage.itb`: compatible RAM/recovery boot.
- `*-squashfs-sysupgrade.bin`: upgrade an existing supported OpenWrt installation.

This workflow does not implement a stock-firmware installation procedure. Confirm
the exact board and recovery method, preserve calibration data and do not force
an incompatible upgrade. Sysupgrade can retain an existing configuration, which
overrides first-boot defaults; the workflow does not reset an installed device.

These are development prereleases. Final FIT and SquashFS checks verify the
selected firmware hashes and startup selector; they do not qualify boot,
throughput or stability on another device. Existing reset findings remain open.
GitHub-hosted build duration and storage limits can prevent a build from finishing;
logs are uploaded on failure where the runner remains available.

## Select a firmware on a dual-firmware installed image

```sh
version=12.5  # or 11.4
test -s "/lib/firmware/qca-nss0-retail-${version}.bin" &&
    uci set nss-wifi.general.firmware="$version" &&
    uci commit nss-wifi
```

The next reboot into that installed image uses the selection. Confirm afterward:

```sh
dmesg | grep 'loaded qca-nss0-retail-'
```

A fresh TFTP RAM boot uses its embedded default. A single-firmware build cannot
select an absent payload. Changing this setting does not reload running firmware.

## Local reproduction

Use a clean Linux checkout of the release source commit, not a private lab build
tree. Install OpenWrt build prerequisites and `u-boot-tools`, then:

```sh
umask 022
python3 .github/scripts/ax6600-build.py prepare dual-11.4
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
python3 .github/scripts/ax6600-build.py check-config dual-11.4
make -j8 download
make -j"$(nproc)" V=s
python3 .github/scripts/ax6600-build.py collect dual-11.4
```

Verified release files appear under `ci-output/firmware/`. Builds are pinned to
source/feed revisions, but the hosted runner and distribution package versions
can change; this does not promise byte-for-byte reproducibility across runners.
