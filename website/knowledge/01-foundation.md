# Device & lineage

**Scope:** JDCloud RE-CS-02, commonly called AX6600; OpenWrt target `qualcommax/ipq60xx`. This is a device-specific case study, not a blanket recipe for all IPQ601x boards.

## Hardware we observed

The original inspection identified a Qualcomm IPQ60xx platform, an integrated 5 GHz radio, an integrated 2.4 GHz radio, and a PCIe QCN9074 5 GHz radio. The stock snapshot used the integrated 5 GHz radio at 80 MHz and the QCN9074 at 160 MHz. Board data, calibration, PCIe wiring, Ethernet topology, storage and boot configuration are board-specific; check them rather than copying this device tree to another board. The [OpenWrt device record](https://openwrt.org/toh/hwdata/jdcloud/jdcloud_re-cs-02) identifies the SoC as IPQ6010. Record exact silicon identity independently on a new target.

The device has eMMC and a Qualcomm boot chain. The original stock inspection found separate kernel and rootfs partitions and an F2FS overlay in the stock root partition. Later authorized work changed the secondary layout, so original partition sizes are historical. Slot names alone did not prove fallback or safe upgrade behavior.

## Where the software comes from

[OpenWrt](https://github.com/openwrt/openwrt) supplies the upstream target, Linux integration and build system. [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) describes itself as an OpenWrt fork with additional device support, packages and downstream changes. [LibWrt](https://github.com/LiBwrt/LibWrt) is another downstream integration; its maintainers describe combining OpenWrt/ImmortalWrt work with Qualcomm NSS support. These are related projects, not interchangeable source trees or a proven single straight-line history for every package.

The inspected stock image identified itself as LibWrt 25.12-SNAPSHOT, Linux 6.12.108, with NSS firmware 12.5. Ethernet interfaces were bound to `nss-dp`; ath11k and mac80211 referenced the NSS driver. Package and feed identifiers reveal integration lineage, but do not establish all exact source and feed commits in the original image. The exact stock LibWrt commit was not resolved in the initial audit.
