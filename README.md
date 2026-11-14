# OpenWrt AX6600

Mainstream-derived OpenWrt development for the **JDCloud RE-CS-02 / AX6600**, based on Qualcomm IPQ6010 (`qualcommax/ipq60xx`). This repository brings together board support, the upstream EDMA/PPE networking stack, Wi-Fi NSS integration, and fixes for MTU handling and object lifetime.

**[Read the AX6600 Field Notes website →](https://lyrids.github.io/openwrt-ax6600/)**

The website includes hardware and datapath explanations, an interactive image-lineage diagram, anonymized topology diagrams, and experiment summaries with their conclusions and limits. It excludes private deployment configuration, detailed test reports, raw packet captures and per-case datasets. [Browse the website files](docs/) or [edit the curated source](website/).

## Project status

The development line uses Linux 6.18.60 on the recorded OpenWrt base `39e77cc05db95748aad847daf0d16a148a6c91a3`. The latest recorded DUT candidate, Image 14, was built from `21efb75b4c` plus EDMA changes subsequently committed as:

- `60f1e57c37` — handle zero-budget NAPI polls without entering RX/page-pool work.
- `ab443fb6c3` — preserve IRQ state around EDMA transmit locks.

Merge `6f24f8a02b` brought that tested development source into `main`. Website-only commits can follow it without changing the firmware source. [OpenWrt issue #26660](https://github.com/openwrt/openwrt/issues/26660) tracks upstream review; inclusion here does not imply upstream acceptance.

Image 14 passed **16/16 bounded T4/F10 quality cases** with software flow offload, receive steering and fresh mid-load netconsole markers. Eight UDP cases at 25 Mbps reported zero receiver loss; TCP receiver rates were **840.14–922.47 Mbps**. This short replay does not establish long-term stability or prove the cause of earlier resets.

Earlier Image 10 passed **708 selected UDP MTU cases and 114 TCP recovery checks**. Those results apply to that campaign and are not inherited by every later image. The website records the remaining reset, loss, endpoint and recovery limits alongside the results.

## Networking architecture

- **EDMA and DSA:** host packet I/O and Linux switch-port integration.
- **CPPE/PPE:** the switch packet engine and its host-driven flow-offload integration.
- **NSS:** a separate firmware-driven acceleration path, including the Wi-Fi integration.
- **ath11k/mac80211 and netfilter:** wireless ownership, packet lifetime, forwarding and MTU correctness across the stack.

The recorded NSS mode enables Wi-Fi NSS and disables the separate Ethernet-only NSS backend. Firewall software/hardware-offload settings are a separate choice. A hardware-offload flag alone does not prove which engine handled a flow.

## Build and use

Use the [public AX6600 GitHub build workflow](.github/AX6600_BUILD.md) to select NSS 11.4, 12.5, or both and publish default-configured trial images as a GitHub prerelease.

This is a source repository for development, not a universal flashing recipe. The published website contains no firmware images or private build overlays. Candidate images used pinned source/feed revisions and device-specific configuration; source commit alone does not describe every historical image.

Use the [OpenWrt build-system documentation](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem), select the JDCloud RE-CS-02 device under `qualcommax/ipq60xx`, and record the source, feeds, configuration and image digest for a reproducible build. Validate board revision, calibration data, partition layout and recovery independently before installing an image. See [the original OpenWrt README](README.openwrt.md) for upstream project resources.

## Website maintenance

The tracked `website/` directory contains the curated public content and its dependency-free builder. Generated static files live in `docs/` and are served by GitHub Pages from `main`.

```sh
python3 website/build.py
python3 website/check.py
```

Commit both the source and regenerated `docs/` when updating the site. Keep only summaries, conclusions, aggregate results and relevant source references. Retain detailed evidence privately. The build intentionally cleans `docs/`; do not put unrelated files there.

## Repository lineage and credits

`lyrids/openwrt-ax6600` was formerly named `lyrids/openwrt-ipq6010-ppe-nss`. It is an independent GitHub repository carrying OpenWrt-derived history and local AX6600 development. `main` is the canonical line for this project.

- [OpenWrt](https://github.com/openwrt/openwrt): upstream platform, build system and networking drivers.
- [JuliusBairaktaris/openwrt-ppe-nss](https://github.com/JuliusBairaktaris/openwrt-ppe-nss): PPE/NSS donor work and integration lineage.
- [lyrids/openwrt-ppe-nss](https://github.com/lyrids/openwrt-ppe-nss): separate donor-tracking fork; its default branch is not this project's current development line.

Existing source licenses and copyright notices remain authoritative. The original OpenWrt project documentation is preserved in `README.openwrt.md`.
