# Lab, RAM boot & recovery

TFTP RAM boot let the team test a complete candidate without writing its firmware to eMMC each time. The bootloader loads a FIT image into memory; the image runs with an initramfs, while stock and later installed images remain separate. This reduces flash churn but does not make a boot risk-free or prove the installed image has the same behavior.

## Evidence before confidence

The lab captures the TFTP exchange and reconstructs the image from DATA blocks; checks its SHA-256 against the candidate; accounts for acknowledged blocks, retransmissions, fragmentation and capture drops; and verifies a fresh kernel netconsole marker after boot. A successful Linux TFTP read alone is insufficient because Linux can reassemble fragmented packets that U-Boot cannot. Netconsole is kernel evidence, not serial or bootloader coverage.

Early automatic boots sometimes produced no TFTP request. Delayed ARP did not establish a fix. Later, a specifically authorized saved U-Boot retry sequence was tested with fallback and successful transfers; the original intermittent failure was not reproduced, so long-term reliability remains unproven. Historical procedures and address maps must not be applied blindly to another unit.

## Storage and upgrades

The original stock layout, later GPT repair and secondary partition expansion, Image 10 installation and Image 12 sysupgrade are distinct operations. Their reports record the exact authorization, protected partitions, image hashes, boot selection and restore checks. Before any installation on another device, inspect its actual partition table, bootloader, image format, upgrade target and backups; do not infer a safe procedure from matching model names.

Image 12 was installed on the secondary kernel/rootfs pair with an ext4 overlay, while stock payload hashes were checked. Its upgrade used an explicitly verified configuration archive. This is a historical result, not an unattended installation guide.
