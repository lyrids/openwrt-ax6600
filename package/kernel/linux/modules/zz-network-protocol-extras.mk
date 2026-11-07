# SPDX-License-Identifier: GPL-2.0-only

# Supplemental modules are intentionally available for explicit loading.

define KernelPackage/protocol-extra-act-ct
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module act_ct
  DEPENDS:=+kmod-nf-conntrack +kmod-nf-flow +kmod-nf-nat
  FILES:=$(LINUX_DIR)/net/sched/act_ct.ko
endef

$(eval $(call KernelPackage,protocol-extra-act-ct))

define KernelPackage/protocol-extra-act-ife
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module act_ife
  DEPENDS:=+kmod-protocol-extra-ife
  FILES:=$(LINUX_DIR)/net/sched/act_ife.ko
endef

$(eval $(call KernelPackage,protocol-extra-act-ife))

define KernelPackage/protocol-extra-act-mpls
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module act_mpls
  FILES:=$(LINUX_DIR)/net/sched/act_mpls.ko
endef

$(eval $(call KernelPackage,protocol-extra-act-mpls))

define KernelPackage/protocol-extra-act-nat
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module act_nat
  FILES:=$(LINUX_DIR)/net/sched/act_nat.ko
endef

$(eval $(call KernelPackage,protocol-extra-act-nat))

define KernelPackage/protocol-extra-act-tunnel-key
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module act_tunnel_key
  FILES:=$(LINUX_DIR)/net/sched/act_tunnel_key.ko
endef

$(eval $(call KernelPackage,protocol-extra-act-tunnel-key))

define KernelPackage/protocol-extra-adiantum
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module adiantum
  DEPENDS:=+kmod-crypto-lib-poly1305
  FILES:=$(LINUX_DIR)/crypto/adiantum.ko
endef

$(eval $(call KernelPackage,protocol-extra-adiantum))

define KernelPackage/protocol-extra-aegis128
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aegis128
  FILES:=$(LINUX_DIR)/crypto/aegis128.ko
endef

$(eval $(call KernelPackage,protocol-extra-aegis128))

define KernelPackage/protocol-extra-aes-arm64
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-arm64
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-arm64.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-arm64))

define KernelPackage/protocol-extra-aes-ce-blk
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-ce-blk
  DEPENDS:=+kmod-protocol-extra-aes-ce-cipher
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-ce-blk.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-ce-blk))

define KernelPackage/protocol-extra-aes-ce-ccm
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-ce-ccm
  DEPENDS:=+kmod-protocol-extra-aes-ce-blk +kmod-protocol-extra-aes-ce-cipher
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-ce-ccm.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-ce-ccm))

define KernelPackage/protocol-extra-aes-ce-cipher
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-ce-cipher
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-ce-cipher.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-ce-cipher))

define KernelPackage/protocol-extra-aes-neon-blk
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-neon-blk
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-neon-blk.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-neon-blk))

define KernelPackage/protocol-extra-aes-neon-bs
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes-neon-bs
  DEPENDS:=+kmod-protocol-extra-aes-neon-blk
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/aes-neon-bs.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-neon-bs))

define KernelPackage/protocol-extra-aes-ti
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aes_ti
  FILES:=$(LINUX_DIR)/crypto/aes_ti.ko
endef

$(eval $(call KernelPackage,protocol-extra-aes-ti))

define KernelPackage/protocol-extra-amlogic-gxl-crypto
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module amlogic-gxl-crypto
  DEPENDS:=+kmod-protocol-extra-crypto-engine
  FILES:=$(LINUX_DIR)/drivers/crypto/amlogic/amlogic-gxl-crypto.ko
endef

$(eval $(call KernelPackage,protocol-extra-amlogic-gxl-crypto))

define KernelPackage/protocol-extra-amt
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module amt
  DEPENDS:=+kmod-udptunnel4
  FILES:=$(LINUX_DIR)/drivers/net/amt.ko
endef

$(eval $(call KernelPackage,protocol-extra-amt))

define KernelPackage/protocol-extra-ansi-cprng
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ansi_cprng
  FILES:=$(LINUX_DIR)/crypto/ansi_cprng.ko
endef

$(eval $(call KernelPackage,protocol-extra-ansi-cprng))

define KernelPackage/protocol-extra-arcnet
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module arcnet
  FILES:=$(LINUX_DIR)/drivers/net/arcnet/arcnet.ko
endef

$(eval $(call KernelPackage,protocol-extra-arcnet))

define KernelPackage/protocol-extra-aria-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module aria_generic
  FILES:=$(LINUX_DIR)/crypto/aria_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-aria-generic))

define KernelPackage/protocol-extra-bareudp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module bareudp
  DEPENDS:=+kmod-udptunnel4 +kmod-udptunnel6
  FILES:=$(LINUX_DIR)/drivers/net/bareudp.ko
endef

$(eval $(call KernelPackage,protocol-extra-bareudp))

define KernelPackage/protocol-extra-batman-adv
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module batman-adv
  FILES:=$(LINUX_DIR)/net/batman-adv/batman-adv.ko
endef

$(eval $(call KernelPackage,protocol-extra-batman-adv))

define KernelPackage/protocol-extra-blowfish-common
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module blowfish_common
  FILES:=$(LINUX_DIR)/crypto/blowfish_common.ko
endef

$(eval $(call KernelPackage,protocol-extra-blowfish-common))

define KernelPackage/protocol-extra-blowfish-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module blowfish_generic
  DEPENDS:=+kmod-protocol-extra-blowfish-common
  FILES:=$(LINUX_DIR)/crypto/blowfish_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-blowfish-generic))

define KernelPackage/protocol-extra-bsd-comp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module bsd_comp
  DEPENDS:=+kmod-ppp
  FILES:=$(LINUX_DIR)/drivers/net/ppp/bsd_comp.ko
endef

$(eval $(call KernelPackage,protocol-extra-bsd-comp))

define KernelPackage/protocol-extra-caif
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module caif
  DEPENDS:=+kmod-lib-crc-ccitt
  FILES:=$(LINUX_DIR)/net/caif/caif.ko
endef

$(eval $(call KernelPackage,protocol-extra-caif))

define KernelPackage/protocol-extra-caif-socket
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module caif_socket
  DEPENDS:=+kmod-protocol-extra-caif
  FILES:=$(LINUX_DIR)/net/caif/caif_socket.ko
endef

$(eval $(call KernelPackage,protocol-extra-caif-socket))

define KernelPackage/protocol-extra-camellia-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module camellia_generic
  FILES:=$(LINUX_DIR)/crypto/camellia_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-camellia-generic))

define KernelPackage/protocol-extra-cast5-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module cast5_generic
  DEPENDS:=+kmod-protocol-extra-cast-common
  FILES:=$(LINUX_DIR)/crypto/cast5_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-cast5-generic))

define KernelPackage/protocol-extra-cast6-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module cast6_generic
  DEPENDS:=+kmod-protocol-extra-cast-common
  FILES:=$(LINUX_DIR)/crypto/cast6_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-cast6-generic))

define KernelPackage/protocol-extra-cast-common
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module cast_common
  FILES:=$(LINUX_DIR)/crypto/cast_common.ko
endef

$(eval $(call KernelPackage,protocol-extra-cast-common))

define KernelPackage/protocol-extra-ccree
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ccree
  DEPENDS:=+kmod-crypto-des
  FILES:=$(LINUX_DIR)/drivers/crypto/ccree/ccree.ko
endef

$(eval $(call KernelPackage,protocol-extra-ccree))

define KernelPackage/protocol-extra-ceph
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ceph
  DEPENDS:=+kmod-fs-netfs +kmod-protocol-extra-libceph
  FILES:=$(LINUX_DIR)/fs/ceph/ceph.ko
endef

$(eval $(call KernelPackage,protocol-extra-ceph))

define KernelPackage/protocol-extra-chnl-net
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module chnl_net
  DEPENDS:=+kmod-protocol-extra-caif
  FILES:=$(LINUX_DIR)/net/caif/chnl_net.ko
endef

$(eval $(call KernelPackage,protocol-extra-chnl-net))

define KernelPackage/protocol-extra-cls-cgroup
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module cls_cgroup
  FILES:=$(LINUX_DIR)/net/sched/cls_cgroup.ko
endef

$(eval $(call KernelPackage,protocol-extra-cls-cgroup))

define KernelPackage/protocol-extra-coda
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module coda
  FILES:=$(LINUX_DIR)/fs/coda/coda.ko
endef

$(eval $(call KernelPackage,protocol-extra-coda))

define KernelPackage/protocol-extra-crc-t10dif
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module crc-t10dif
  FILES:=$(LINUX_DIR)/lib/crc/crc-t10dif.ko
endef

$(eval $(call KernelPackage,protocol-extra-crc-t10dif))

define KernelPackage/protocol-extra-crc4
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module crc4
  FILES:=$(LINUX_DIR)/lib/crc/crc4.ko
endef

$(eval $(call KernelPackage,protocol-extra-crc4))

define KernelPackage/protocol-extra-crc64
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module crc64
  FILES:=$(LINUX_DIR)/lib/crc/crc64.ko
endef

$(eval $(call KernelPackage,protocol-extra-crc64))

define KernelPackage/protocol-extra-cryptd
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module cryptd
  FILES:=$(LINUX_DIR)/crypto/cryptd.ko
endef

$(eval $(call KernelPackage,protocol-extra-cryptd))

define KernelPackage/protocol-extra-crypto-engine
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module crypto_engine
  FILES:=$(LINUX_DIR)/crypto/crypto_engine.ko
endef

$(eval $(call KernelPackage,protocol-extra-crypto-engine))

define KernelPackage/protocol-extra-crypto-safexcel
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module crypto_safexcel
  DEPENDS:=+kmod-crypto-des +kmod-crypto-md5 +kmod-crypto-sha512
  FILES:=$(LINUX_DIR)/drivers/crypto/inside-secure/crypto_safexcel.ko
endef

$(eval $(call KernelPackage,protocol-extra-crypto-safexcel))

define KernelPackage/protocol-extra-dh-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module dh_generic
  DEPENDS:=+kmod-protocol-extra-mpi
  FILES:=$(LINUX_DIR)/crypto/dh_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-dh-generic))

define KernelPackage/protocol-extra-dibs
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module dibs
  FILES:=$(LINUX_DIR)/drivers/dibs/dibs.ko
endef

$(eval $(call KernelPackage,protocol-extra-dibs))

define KernelPackage/protocol-extra-ecdsa-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ecdsa_generic
  DEPENDS:=+kmod-asn1-decoder +kmod-crypto-ecdh
  FILES:=$(LINUX_DIR)/crypto/ecdsa_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-ecdsa-generic))

define KernelPackage/protocol-extra-ecrdsa-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ecrdsa_generic
  DEPENDS:=+kmod-asn1-decoder +kmod-crypto-ecdh +kmod-oid-registry
  FILES:=$(LINUX_DIR)/crypto/ecrdsa_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-ecrdsa-generic))

define KernelPackage/protocol-extra-eql
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module eql
  FILES:=$(LINUX_DIR)/drivers/net/eql.ko
endef

$(eval $(call KernelPackage,protocol-extra-eql))

define KernelPackage/protocol-extra-failover
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module failover
  FILES:=$(LINUX_DIR)/net/core/failover.ko
endef

$(eval $(call KernelPackage,protocol-extra-failover))

define KernelPackage/protocol-extra-fou6
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module fou6
  DEPENDS:=+kmod-fou +kmod-ip6-tunnel
  FILES:=$(LINUX_DIR)/net/ipv6/fou6.ko
endef

$(eval $(call KernelPackage,protocol-extra-fou6))

define KernelPackage/protocol-extra-ghash-ce
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ghash-ce
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/ghash-ce.ko
endef

$(eval $(call KernelPackage,protocol-extra-ghash-ce))

define KernelPackage/protocol-extra-gtp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module gtp
  DEPENDS:=+kmod-udptunnel4 +kmod-udptunnel6
  FILES:=$(LINUX_DIR)/drivers/net/gtp.ko
endef

$(eval $(call KernelPackage,protocol-extra-gtp))

define KernelPackage/protocol-extra-hctr2
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module hctr2
  FILES:=$(LINUX_DIR)/crypto/hctr2.ko
endef

$(eval $(call KernelPackage,protocol-extra-hctr2))

define KernelPackage/protocol-extra-hisi-sec
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module hisi_sec
  DEPENDS:=+kmod-crypto-des
  FILES:=$(LINUX_DIR)/drivers/crypto/hisilicon/sec/hisi_sec.ko
endef

$(eval $(call KernelPackage,protocol-extra-hisi-sec))

define KernelPackage/protocol-extra-hsr
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module hsr
  FILES:=$(LINUX_DIR)/net/hsr/hsr.ko
endef

$(eval $(call KernelPackage,protocol-extra-hsr))

define KernelPackage/protocol-extra-ife
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ife
  FILES:=$(LINUX_DIR)/net/ife/ife.ko
endef

$(eval $(call KernelPackage,protocol-extra-ife))

define KernelPackage/protocol-extra-ila
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ila
  FILES:=$(LINUX_DIR)/net/ipv6/ila/ila.ko
endef

$(eval $(call KernelPackage,protocol-extra-ila))

define KernelPackage/protocol-extra-intel-qat
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module intel_qat
  DEPENDS:=+kmod-crypto-sha512 +kmod-protocol-extra-dh-generic +kmod-protocol-extra-rsa-generic
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_common/intel_qat.ko
endef

$(eval $(call KernelPackage,protocol-extra-intel-qat))

define KernelPackage/protocol-extra-kcm
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module kcm
  FILES:=$(LINUX_DIR)/net/kcm/kcm.ko
endef

$(eval $(call KernelPackage,protocol-extra-kcm))

define KernelPackage/protocol-extra-lapb
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module lapb
  FILES:=$(LINUX_DIR)/net/lapb/lapb.ko
endef

$(eval $(call KernelPackage,protocol-extra-lapb))

define KernelPackage/protocol-extra-libceph
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module libceph
  FILES:=$(LINUX_DIR)/net/ceph/libceph.ko
endef

$(eval $(call KernelPackage,protocol-extra-libceph))

define KernelPackage/protocol-extra-libsm3
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module libsm3
  FILES:=$(LINUX_DIR)/lib/crypto/libsm3.ko
endef

$(eval $(call KernelPackage,protocol-extra-libsm3))

define KernelPackage/protocol-extra-llc2
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module llc2
  FILES:=$(LINUX_DIR)/net/llc/llc2.ko
endef

$(eval $(call KernelPackage,protocol-extra-llc2))

define KernelPackage/protocol-extra-lrw
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module lrw
  FILES:=$(LINUX_DIR)/crypto/lrw.ko
endef

$(eval $(call KernelPackage,protocol-extra-lrw))

define KernelPackage/protocol-extra-mip6
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module mip6
  FILES:=$(LINUX_DIR)/net/ipv6/mip6.ko
endef

$(eval $(call KernelPackage,protocol-extra-mip6))

define KernelPackage/protocol-extra-mpi
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module mpi
  FILES:=$(LINUX_DIR)/lib/crypto/mpi/mpi.ko
endef

$(eval $(call KernelPackage,protocol-extra-mpi))

define KernelPackage/protocol-extra-mpls-gso
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module mpls_gso
  FILES:=$(LINUX_DIR)/net/mpls/mpls_gso.ko
endef

$(eval $(call KernelPackage,protocol-extra-mpls-gso))

define KernelPackage/protocol-extra-mptcp-diag
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module mptcp_diag
  DEPENDS:=+kmod-inet-diag
  FILES:=$(LINUX_DIR)/net/mptcp/mptcp_diag.ko
endef

$(eval $(call KernelPackage,protocol-extra-mptcp-diag))

define KernelPackage/protocol-extra-n5pf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module n5pf
  FILES:=$(LINUX_DIR)/drivers/crypto/cavium/nitrox/n5pf.ko
endef

$(eval $(call KernelPackage,protocol-extra-n5pf))

define KernelPackage/protocol-extra-net-failover
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module net_failover
  DEPENDS:=+kmod-protocol-extra-failover
  FILES:=$(LINUX_DIR)/drivers/net/net_failover.ko
endef

$(eval $(call KernelPackage,protocol-extra-net-failover))

define KernelPackage/protocol-extra-nf-synproxy-core
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nf_synproxy_core
  DEPENDS:=+kmod-nf-conntrack
  FILES:=$(LINUX_DIR)/net/netfilter/nf_synproxy_core.ko
endef

$(eval $(call KernelPackage,protocol-extra-nf-synproxy-core))

define KernelPackage/protocol-extra-nfc
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfc
  DEPENDS:=+kmod-rfkill
  FILES:=$(LINUX_DIR)/net/nfc/nfc.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfc))

define KernelPackage/protocol-extra-nfnetlink-acct
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfnetlink_acct
  DEPENDS:=+kmod-nfnetlink
  FILES:=$(LINUX_DIR)/net/netfilter/nfnetlink_acct.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfnetlink-acct))

define KernelPackage/protocol-extra-nfnetlink-hook
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfnetlink_hook
  DEPENDS:=+kmod-nfnetlink
  FILES:=$(LINUX_DIR)/net/netfilter/nfnetlink_hook.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfnetlink-hook))

define KernelPackage/protocol-extra-nfnetlink-osf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfnetlink_osf
  DEPENDS:=+kmod-nfnetlink
  FILES:=$(LINUX_DIR)/net/netfilter/nfnetlink_osf.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfnetlink-osf))

define KernelPackage/protocol-extra-nfs-layout-flexfiles
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfs_layout_flexfiles
  DEPENDS:=+kmod-fs-nfs +kmod-fs-nfs-common +kmod-protocol-extra-nfsv4
  FILES:=$(LINUX_DIR)/fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfs-layout-flexfiles))

define KernelPackage/protocol-extra-nfs-layout-nfsv41-files
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfs_layout_nfsv41_files
  DEPENDS:=+kmod-fs-nfs +kmod-fs-nfs-common +kmod-protocol-extra-nfsv4
  FILES:=$(LINUX_DIR)/fs/nfs/filelayout/nfs_layout_nfsv41_files.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfs-layout-nfsv41-files))

define KernelPackage/protocol-extra-nfsv3
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfsv3
  DEPENDS:=+kmod-fs-nfs +kmod-fs-nfs-common
  FILES:=$(LINUX_DIR)/fs/nfs/nfsv3.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfsv3))

define KernelPackage/protocol-extra-nfsv4
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nfsv4
  DEPENDS:=+kmod-dnsresolver +kmod-fs-nfs +kmod-fs-nfs-common
  FILES:=$(LINUX_DIR)/fs/nfs/nfsv4.ko
endef

$(eval $(call KernelPackage,protocol-extra-nfsv4))

define KernelPackage/protocol-extra-nft-fib-netdev
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nft_fib_netdev
  DEPENDS:=+kmod-nft-core +kmod-nft-fib
  FILES:=$(LINUX_DIR)/net/netfilter/nft_fib_netdev.ko
endef

$(eval $(call KernelPackage,protocol-extra-nft-fib-netdev))

define KernelPackage/protocol-extra-nft-osf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nft_osf
  DEPENDS:=+kmod-nft-core +kmod-protocol-extra-nfnetlink-osf
  FILES:=$(LINUX_DIR)/net/netfilter/nft_osf.ko
endef

$(eval $(call KernelPackage,protocol-extra-nft-osf))

define KernelPackage/protocol-extra-nft-reject-netdev
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nft_reject_netdev
  DEPENDS:=+kmod-nf-reject +kmod-nf-reject6 +kmod-nft-core
  FILES:=$(LINUX_DIR)/net/netfilter/nft_reject_netdev.ko
endef

$(eval $(call KernelPackage,protocol-extra-nft-reject-netdev))

define KernelPackage/protocol-extra-nft-synproxy
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nft_synproxy
  DEPENDS:=+kmod-nf-conntrack +kmod-nft-core +kmod-protocol-extra-nf-synproxy-core
  FILES:=$(LINUX_DIR)/net/netfilter/nft_synproxy.ko
endef

$(eval $(call KernelPackage,protocol-extra-nft-synproxy))

define KernelPackage/protocol-extra-nft-tunnel
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nft_tunnel
  DEPENDS:=+kmod-nft-core
  FILES:=$(LINUX_DIR)/net/netfilter/nft_tunnel.ko
endef

$(eval $(call KernelPackage,protocol-extra-nft-tunnel))

define KernelPackage/protocol-extra-nhpoly1305
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nhpoly1305
  DEPENDS:=+kmod-crypto-lib-poly1305
  FILES:=$(LINUX_DIR)/crypto/nhpoly1305.ko
endef

$(eval $(call KernelPackage,protocol-extra-nhpoly1305))

define KernelPackage/protocol-extra-nhpoly1305-neon
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module nhpoly1305-neon
  DEPENDS:=+kmod-protocol-extra-nhpoly1305
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/nhpoly1305-neon.ko
endef

$(eval $(call KernelPackage,protocol-extra-nhpoly1305-neon))

define KernelPackage/protocol-extra-openvswitch
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module openvswitch
  DEPENDS:=+kmod-nf-conncount +kmod-nf-conntrack +kmod-nf-nat +kmod-nsh +kmod-sched-act-sample
  FILES:=$(LINUX_DIR)/net/openvswitch/openvswitch.ko
endef

$(eval $(call KernelPackage,protocol-extra-openvswitch))

define KernelPackage/protocol-extra-ovpn
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ovpn
  DEPENDS:=+kmod-udptunnel4 +kmod-udptunnel6
  # Linux 6.18 provides the native OpenVPN 2.7 DCO interface.
  PROVIDES:=kmod-ovpn kmod-ovpn-backports
  FILES:=$(LINUX_DIR)/drivers/net/ovpn/ovpn.ko
endef

$(eval $(call KernelPackage,protocol-extra-ovpn))

define KernelPackage/protocol-extra-pcrypt
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module pcrypt
  FILES:=$(LINUX_DIR)/crypto/pcrypt.ko
endef

$(eval $(call KernelPackage,protocol-extra-pcrypt))

define KernelPackage/protocol-extra-pfcp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module pfcp
  DEPENDS:=+kmod-udptunnel4
  FILES:=$(LINUX_DIR)/drivers/net/pfcp.ko
endef

$(eval $(call KernelPackage,protocol-extra-pfcp))

define KernelPackage/protocol-extra-phonet
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module phonet
  FILES:=$(LINUX_DIR)/net/phonet/phonet.ko
endef

$(eval $(call KernelPackage,protocol-extra-phonet))

define KernelPackage/protocol-extra-pn-pep
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module pn_pep
  DEPENDS:=+kmod-protocol-extra-phonet
  FILES:=$(LINUX_DIR)/net/phonet/pn_pep.ko
endef

$(eval $(call KernelPackage,protocol-extra-pn-pep))

define KernelPackage/protocol-extra-polyval-ce
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module polyval-ce
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/polyval-ce.ko
endef

$(eval $(call KernelPackage,protocol-extra-polyval-ce))

define KernelPackage/protocol-extra-polyval-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module polyval-generic
  FILES:=$(LINUX_DIR)/crypto/polyval-generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-polyval-generic))

define KernelPackage/protocol-extra-ppp-deflate
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module ppp_deflate
  DEPENDS:=+kmod-ppp
  FILES:=$(LINUX_DIR)/drivers/net/ppp/ppp_deflate.ko
endef

$(eval $(call KernelPackage,protocol-extra-ppp-deflate))

define KernelPackage/protocol-extra-prime-numbers
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module prime_numbers
  FILES:=$(LINUX_DIR)/lib/math/prime_numbers.ko
endef

$(eval $(call KernelPackage,protocol-extra-prime-numbers))

define KernelPackage/protocol-extra-qat-420xx
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_420xx
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_420xx/qat_420xx.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-420xx))

define KernelPackage/protocol-extra-qat-4xxx
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_4xxx
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_4xxx/qat_4xxx.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-4xxx))

define KernelPackage/protocol-extra-qat-c3xxx
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_c3xxx
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_c3xxx/qat_c3xxx.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-c3xxx))

define KernelPackage/protocol-extra-qat-c3xxxvf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_c3xxxvf
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_c3xxxvf/qat_c3xxxvf.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-c3xxxvf))

define KernelPackage/protocol-extra-qat-c62x
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_c62x
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_c62x/qat_c62x.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-c62x))

define KernelPackage/protocol-extra-qat-c62xvf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_c62xvf
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_c62xvf/qat_c62xvf.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-c62xvf))

define KernelPackage/protocol-extra-qat-dh895xcc
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_dh895xcc
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_dh895xcc/qat_dh895xcc.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-dh895xcc))

define KernelPackage/protocol-extra-qat-dh895xccvf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qat_dh895xccvf
  DEPENDS:=+kmod-protocol-extra-intel-qat
  FILES:=$(LINUX_DIR)/drivers/crypto/intel/qat/qat_dh895xccvf/qat_dh895xccvf.ko
endef

$(eval $(call KernelPackage,protocol-extra-qat-dh895xccvf))

define KernelPackage/protocol-extra-qca-ppe
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qca_ppe
  DEPENDS:=+kmod-dsa +kmod-nf-flow
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/qualcomm/qca_ppe.ko
endef

$(eval $(call KernelPackage,protocol-extra-qca-ppe))

define KernelPackage/protocol-extra-qcrypto
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module qcrypto
  FILES:=$(LINUX_DIR)/drivers/crypto/qce/qcrypto.ko
endef

$(eval $(call KernelPackage,protocol-extra-qcrypto))

define KernelPackage/protocol-extra-rds
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module rds
  FILES:=$(LINUX_DIR)/net/rds/rds.ko
endef

$(eval $(call KernelPackage,protocol-extra-rds))

define KernelPackage/protocol-extra-rsa-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module rsa_generic
  DEPENDS:=+kmod-asn1-decoder +kmod-protocol-extra-mpi
  FILES:=$(LINUX_DIR)/crypto/rsa_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-rsa-generic))

define KernelPackage/protocol-extra-sch-choke
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sch_choke
  FILES:=$(LINUX_DIR)/net/sched/sch_choke.ko
endef

$(eval $(call KernelPackage,protocol-extra-sch-choke))

define KernelPackage/protocol-extra-sch-hhf
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sch_hhf
  FILES:=$(LINUX_DIR)/net/sched/sch_hhf.ko
endef

$(eval $(call KernelPackage,protocol-extra-sch-hhf))

define KernelPackage/protocol-extra-sch-plug
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sch_plug
  FILES:=$(LINUX_DIR)/net/sched/sch_plug.ko
endef

$(eval $(call KernelPackage,protocol-extra-sch-plug))

define KernelPackage/protocol-extra-sch-qfq
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sch_qfq
  FILES:=$(LINUX_DIR)/net/sched/sch_qfq.ko
endef

$(eval $(call KernelPackage,protocol-extra-sch-qfq))

define KernelPackage/protocol-extra-sch-sfb
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sch_sfb
  FILES:=$(LINUX_DIR)/net/sched/sch_sfb.ko
endef

$(eval $(call KernelPackage,protocol-extra-sch-sfb))

define KernelPackage/protocol-extra-sctp-diag
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sctp_diag
  DEPENDS:=+kmod-inet-diag +kmod-sctp
  FILES:=$(LINUX_DIR)/net/sctp/sctp_diag.ko
endef

$(eval $(call KernelPackage,protocol-extra-sctp-diag))

define KernelPackage/protocol-extra-serpent-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module serpent_generic
  FILES:=$(LINUX_DIR)/crypto/serpent_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-serpent-generic))

define KernelPackage/protocol-extra-sha3-ce
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sha3-ce
  DEPENDS:=+kmod-crypto-sha3
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sha3-ce.ko
endef

$(eval $(call KernelPackage,protocol-extra-sha3-ce))

define KernelPackage/protocol-extra-sm3-ce
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm3-ce
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm3-ce.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm3-ce))

define KernelPackage/protocol-extra-sm3-neon
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm3-neon
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm3-neon.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm3-neon))

define KernelPackage/protocol-extra-sm3-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm3_generic
  DEPENDS:=+kmod-protocol-extra-libsm3
  FILES:=$(LINUX_DIR)/crypto/sm3_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm3-generic))

define KernelPackage/protocol-extra-sm4
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4
  FILES:=$(LINUX_DIR)/crypto/sm4.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4))

define KernelPackage/protocol-extra-sm4-ce
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4-ce
  DEPENDS:=+kmod-protocol-extra-sm4
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm4-ce.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-ce))

define KernelPackage/protocol-extra-sm4-ce-ccm
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4-ce-ccm
  DEPENDS:=+kmod-protocol-extra-sm4 +kmod-protocol-extra-sm4-ce
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm4-ce-ccm.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-ce-ccm))

define KernelPackage/protocol-extra-sm4-ce-cipher
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4-ce-cipher
  DEPENDS:=+kmod-protocol-extra-sm4
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm4-ce-cipher.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-ce-cipher))

define KernelPackage/protocol-extra-sm4-ce-gcm
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4-ce-gcm
  DEPENDS:=+kmod-protocol-extra-sm4 +kmod-protocol-extra-sm4-ce
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm4-ce-gcm.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-ce-gcm))

define KernelPackage/protocol-extra-sm4-neon
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4-neon
  DEPENDS:=+kmod-protocol-extra-sm4
  FILES:=$(LINUX_DIR)/arch/arm64/crypto/sm4-neon.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-neon))

define KernelPackage/protocol-extra-sm4-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module sm4_generic
  DEPENDS:=+kmod-protocol-extra-sm4
  FILES:=$(LINUX_DIR)/crypto/sm4_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-sm4-generic))

define KernelPackage/protocol-extra-streebog-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module streebog_generic
  FILES:=$(LINUX_DIR)/crypto/streebog_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-streebog-generic))

define KernelPackage/protocol-extra-tag-ar9331
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_ar9331
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_ar9331.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-ar9331))

define KernelPackage/protocol-extra-tag-gswip
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_gswip
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_gswip.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-gswip))

define KernelPackage/protocol-extra-tag-hellcreek
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_hellcreek
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_hellcreek.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-hellcreek))

define KernelPackage/protocol-extra-tag-ksz
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_ksz
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_ksz.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-ksz))

define KernelPackage/protocol-extra-tag-lan9303
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_lan9303
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_lan9303.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-lan9303))

define KernelPackage/protocol-extra-tag-mtk
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_mtk
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_mtk.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-mtk))

define KernelPackage/protocol-extra-tag-ocelot
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_ocelot
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_ocelot.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-ocelot))

define KernelPackage/protocol-extra-tag-ocelot-8021q
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_ocelot_8021q
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_ocelot_8021q.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-ocelot-8021q))

define KernelPackage/protocol-extra-tag-qca
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_qca
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_qca.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-qca))

define KernelPackage/protocol-extra-tag-rzn1-a5psw
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_rzn1_a5psw
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_rzn1_a5psw.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-rzn1-a5psw))

define KernelPackage/protocol-extra-tag-sja1105
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_sja1105
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_sja1105.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-sja1105))

define KernelPackage/protocol-extra-tag-xrs700x
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_xrs700x
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_xrs700x.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-xrs700x))

define KernelPackage/protocol-extra-tag-yt921x
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_yt921x
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_yt921x.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-yt921x))

define KernelPackage/protocol-extra-tag-yt922x
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tag_yt922x
  DEPENDS:=+kmod-dsa
  FILES:=$(LINUX_DIR)/net/dsa/tag_yt922x.ko
endef

$(eval $(call KernelPackage,protocol-extra-tag-yt922x))

define KernelPackage/protocol-extra-tcp-bic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_bic
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_bic.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-bic))

define KernelPackage/protocol-extra-tcp-cdg
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_cdg
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_cdg.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-cdg))

define KernelPackage/protocol-extra-tcp-dctcp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_dctcp
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_dctcp.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-dctcp))

define KernelPackage/protocol-extra-tcp-highspeed
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_highspeed
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_highspeed.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-highspeed))

define KernelPackage/protocol-extra-tcp-htcp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_htcp
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_htcp.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-htcp))

define KernelPackage/protocol-extra-tcp-illinois
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_illinois
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_illinois.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-illinois))

define KernelPackage/protocol-extra-tcp-lp
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_lp
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_lp.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-lp))

define KernelPackage/protocol-extra-tcp-nv
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_nv
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_nv.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-nv))

define KernelPackage/protocol-extra-tcp-vegas
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_vegas
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_vegas.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-vegas))

define KernelPackage/protocol-extra-tcp-veno
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_veno
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_veno.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-veno))

define KernelPackage/protocol-extra-tcp-westwood
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_westwood
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_westwood.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-westwood))

define KernelPackage/protocol-extra-tcp-yeah
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tcp_yeah
  DEPENDS:=+kmod-protocol-extra-tcp-vegas
  FILES:=$(LINUX_DIR)/net/ipv4/tcp_yeah.ko
endef

$(eval $(call KernelPackage,protocol-extra-tcp-yeah))

define KernelPackage/protocol-extra-tipc
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tipc
  DEPENDS:=+kmod-udptunnel4 +kmod-udptunnel6
  FILES:=$(LINUX_DIR)/net/tipc/tipc.ko
endef

$(eval $(call KernelPackage,protocol-extra-tipc))

define KernelPackage/protocol-extra-tipc-diag
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module tipc_diag
  DEPENDS:=+kmod-protocol-extra-tipc
  FILES:=$(LINUX_DIR)/net/tipc/tipc_diag.ko
endef

$(eval $(call KernelPackage,protocol-extra-tipc-diag))

define KernelPackage/protocol-extra-twofish-common
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module twofish_common
  FILES:=$(LINUX_DIR)/crypto/twofish_common.ko
endef

$(eval $(call KernelPackage,protocol-extra-twofish-common))

define KernelPackage/protocol-extra-twofish-generic
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module twofish_generic
  DEPENDS:=+kmod-protocol-extra-twofish-common
  FILES:=$(LINUX_DIR)/crypto/twofish_generic.ko
endef

$(eval $(call KernelPackage,protocol-extra-twofish-generic))

define KernelPackage/protocol-extra-virtio-crypto
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module virtio_crypto
  DEPENDS:=+kmod-protocol-extra-crypto-engine +kmod-protocol-extra-mpi +kmod-protocol-extra-rsa-generic
  FILES:=$(LINUX_DIR)/drivers/crypto/virtio/virtio_crypto.ko
endef

$(eval $(call KernelPackage,protocol-extra-virtio-crypto))

define KernelPackage/protocol-extra-virtio-net
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module virtio_net
  DEPENDS:=+kmod-protocol-extra-net-failover
  FILES:=$(LINUX_DIR)/drivers/net/virtio_net.ko
endef

$(eval $(call KernelPackage,protocol-extra-virtio-net))

define KernelPackage/protocol-extra-vport-geneve
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module vport-geneve
  DEPENDS:=+kmod-geneve +kmod-protocol-extra-openvswitch
  FILES:=$(LINUX_DIR)/net/openvswitch/vport-geneve.ko
endef

$(eval $(call KernelPackage,protocol-extra-vport-geneve))

define KernelPackage/protocol-extra-vport-gre
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module vport-gre
  DEPENDS:=+kmod-gre +kmod-protocol-extra-openvswitch
  FILES:=$(LINUX_DIR)/net/openvswitch/vport-gre.ko
endef

$(eval $(call KernelPackage,protocol-extra-vport-gre))

define KernelPackage/protocol-extra-vport-vxlan
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module vport-vxlan
  DEPENDS:=+kmod-protocol-extra-openvswitch +kmod-vxlan
  FILES:=$(LINUX_DIR)/net/openvswitch/vport-vxlan.ko
endef

$(eval $(call KernelPackage,protocol-extra-vport-vxlan))

define KernelPackage/protocol-extra-wp512
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module wp512
  FILES:=$(LINUX_DIR)/crypto/wp512.ko
endef

$(eval $(call KernelPackage,protocol-extra-wp512))

define KernelPackage/protocol-extra-x25
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module x25
  FILES:=$(LINUX_DIR)/net/x25/x25.ko
endef

$(eval $(call KernelPackage,protocol-extra-x25))

define KernelPackage/protocol-extra-xctr
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded protocol module xctr
  FILES:=$(LINUX_DIR)/crypto/xctr.ko
endef

$(eval $(call KernelPackage,protocol-extra-xctr))

define KernelPackage/network-protocol-extras
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=Expanded network protocol module profile
  DEPENDS:=+kmod-6lowpan +kmod-9pnet +kmod-appletalk +kmod-asn1-decoder +kmod-atm +kmod-bluetooth +kmod-bonding +kmod-br-netfilter +kmod-can +kmod-crypto-blake2b +kmod-crypto-chacha20poly1305 +kmod-crypto-cmac +kmod-crypto-crc32 +kmod-crypto-crc32c +kmod-crypto-cts +kmod-crypto-des +kmod-crypto-ecdh +kmod-crypto-echainiv +kmod-crypto-essiv +kmod-crypto-fcrypt +kmod-crypto-geniv +kmod-crypto-hmac +kmod-crypto-hw-atmel +kmod-crypto-krb5 +kmod-crypto-lib-chacha20 +kmod-crypto-lib-chacha20poly1305 +kmod-crypto-lib-curve25519 +kmod-crypto-lib-poly1305 +kmod-crypto-md4 +kmod-crypto-md5 +kmod-crypto-michael-mic +kmod-crypto-pcbc +kmod-crypto-rmd160 +kmod-crypto-rng +kmod-crypto-seqiv +kmod-crypto-sha3 +kmod-crypto-sha512 +kmod-crypto-test +kmod-crypto-user +kmod-crypto-xcbc +kmod-crypto-xxhash +kmod-dnsresolver +kmod-dsa +kmod-dsa-b53 +kmod-dsa-mv88e6060 +kmod-dsa-mv88e6xxx +kmod-dsa-mxl862xx +kmod-dsa-notag +kmod-dsa-realtek +kmod-dsa-rtl8365mb +kmod-dsa-rtl8366rb +kmod-dsa-vsc73xx +kmod-dummy +kmod-fou +kmod-fs-afs +kmod-fs-cifs +kmod-fs-ext4 +kmod-fs-ksmbd +kmod-fs-netfs +kmod-fs-nfs +kmod-fs-nfs-common +kmod-fs-nfs-common-rpcsec +kmod-fs-nfsd +kmod-fs-smbfs-common +kmod-geneve +kmod-gre +kmod-hid +kmod-ieee802154 +kmod-ifb +kmod-inet-diag +kmod-input-core +kmod-ip-vti +kmod-ip6-tunnel +kmod-ip6-vti +kmod-ipip +kmod-ipsec +kmod-ipsec4 +kmod-ipsec6 +kmod-ipt-conntrack +kmod-ipt-core +kmod-ipt-ipset +kmod-iptunnel +kmod-iptunnel4 +kmod-iptunnel6 +kmod-ipvlan +kmod-l2tp +kmod-leds-gpio +kmod-lib-842 +kmod-lib-cordic +kmod-lib-crc-ccitt +kmod-lib-crc7 +kmod-lib-lz4 +kmod-lib-lz4-decompress +kmod-lib-lz4hc +kmod-lib-textsearch +kmod-macsec +kmod-macvlan +kmod-mhi-bus +kmod-mhi-net +kmod-mppe +kmod-netconsole +kmod-netem +kmod-netlink-diag +kmod-nf-conncount +kmod-nf-conntrack +kmod-nf-conntrack-netlink +kmod-nf-dup-inet +kmod-nf-flow +kmod-nf-ipt +kmod-nf-ipt6 +kmod-nf-ipvs +kmod-nf-log +kmod-nf-nat +kmod-nf-nathelper +kmod-nf-nathelper-amanda +kmod-nf-nathelper-broadcast +kmod-nf-nathelper-h323 +kmod-nf-nathelper-irc +kmod-nf-nathelper-netbios +kmod-nf-nathelper-pptp +kmod-nf-nathelper-sane +kmod-nf-nathelper-sip +kmod-nf-nathelper-snmp +kmod-nf-nathelper-tftp +kmod-nf-reject +kmod-nf-reject6 +kmod-nf-socket +kmod-nf-tproxy +kmod-nfnetlink +kmod-nfnetlink-cttimeout +kmod-nfnetlink-log +kmod-nfnetlink-queue +kmod-nft-bridge +kmod-nft-connlimit +kmod-nft-core +kmod-nft-dup-inet +kmod-nft-fib +kmod-nft-nat +kmod-nft-netdev +kmod-nft-offload +kmod-nft-socket +kmod-nft-tproxy +kmod-nlmon +kmod-nls-ucs2-utils +kmod-nls-utf8 +kmod-nsh +kmod-oid-registry +kmod-packet-diag +kmod-phy-marvell +kmod-phy-maxlinear +kmod-phy-realtek +kmod-phy-vitesse +kmod-pktgen +kmod-polynomial +kmod-ppp +kmod-ppp-synctty +kmod-pppoe +kmod-pppox +kmod-pps +kmod-protocol-extra-act-ct +kmod-protocol-extra-act-ife +kmod-protocol-extra-act-mpls +kmod-protocol-extra-act-nat +kmod-protocol-extra-act-tunnel-key +kmod-protocol-extra-adiantum +kmod-protocol-extra-aegis128 +kmod-protocol-extra-aes-arm64 +kmod-protocol-extra-aes-ce-blk +kmod-protocol-extra-aes-ce-ccm +kmod-protocol-extra-aes-ce-cipher +kmod-protocol-extra-aes-neon-blk +kmod-protocol-extra-aes-neon-bs +kmod-protocol-extra-aes-ti +kmod-protocol-extra-amlogic-gxl-crypto +kmod-protocol-extra-amt +kmod-protocol-extra-ansi-cprng +kmod-protocol-extra-arcnet +kmod-protocol-extra-aria-generic +kmod-protocol-extra-bareudp +kmod-protocol-extra-batman-adv +kmod-protocol-extra-blowfish-common +kmod-protocol-extra-blowfish-generic +kmod-protocol-extra-bsd-comp +kmod-protocol-extra-caif +kmod-protocol-extra-caif-socket +kmod-protocol-extra-camellia-generic +kmod-protocol-extra-cast-common +kmod-protocol-extra-cast5-generic +kmod-protocol-extra-cast6-generic +kmod-protocol-extra-ccree +kmod-protocol-extra-ceph +kmod-protocol-extra-chnl-net +kmod-protocol-extra-cls-cgroup +kmod-protocol-extra-coda +kmod-protocol-extra-crc-t10dif +kmod-protocol-extra-crc4 +kmod-protocol-extra-crc64 +kmod-protocol-extra-cryptd +kmod-protocol-extra-crypto-engine +kmod-protocol-extra-crypto-safexcel +kmod-protocol-extra-dh-generic +kmod-protocol-extra-dibs +kmod-protocol-extra-ecdsa-generic +kmod-protocol-extra-ecrdsa-generic +kmod-protocol-extra-eql +kmod-protocol-extra-failover +kmod-protocol-extra-fou6 +kmod-protocol-extra-ghash-ce +kmod-protocol-extra-gtp +kmod-protocol-extra-hctr2 +kmod-protocol-extra-hisi-sec +kmod-protocol-extra-hsr +kmod-protocol-extra-ife +kmod-protocol-extra-ila +kmod-protocol-extra-intel-qat +kmod-protocol-extra-kcm +kmod-protocol-extra-lapb +kmod-protocol-extra-libceph +kmod-protocol-extra-libsm3 +kmod-protocol-extra-llc2 +kmod-protocol-extra-lrw +kmod-protocol-extra-mip6 +kmod-protocol-extra-mpi +kmod-protocol-extra-mpls-gso +kmod-protocol-extra-mptcp-diag +kmod-protocol-extra-n5pf +kmod-protocol-extra-net-failover +kmod-protocol-extra-nf-synproxy-core +kmod-protocol-extra-nfc +kmod-protocol-extra-nfnetlink-acct +kmod-protocol-extra-nfnetlink-hook +kmod-protocol-extra-nfnetlink-osf +kmod-protocol-extra-nfs-layout-flexfiles +kmod-protocol-extra-nfs-layout-nfsv41-files +kmod-protocol-extra-nfsv3 +kmod-protocol-extra-nfsv4 +kmod-protocol-extra-nft-fib-netdev +kmod-protocol-extra-nft-osf +kmod-protocol-extra-nft-reject-netdev +kmod-protocol-extra-nft-synproxy +kmod-protocol-extra-nft-tunnel +kmod-protocol-extra-nhpoly1305 +kmod-protocol-extra-nhpoly1305-neon +kmod-protocol-extra-openvswitch +kmod-protocol-extra-ovpn +kmod-protocol-extra-pcrypt +kmod-protocol-extra-pfcp +kmod-protocol-extra-phonet +kmod-protocol-extra-pn-pep +kmod-protocol-extra-polyval-ce +kmod-protocol-extra-polyval-generic +kmod-protocol-extra-ppp-deflate +kmod-protocol-extra-prime-numbers +kmod-protocol-extra-qat-420xx +kmod-protocol-extra-qat-4xxx +kmod-protocol-extra-qat-c3xxx +kmod-protocol-extra-qat-c3xxxvf +kmod-protocol-extra-qat-c62x +kmod-protocol-extra-qat-c62xvf +kmod-protocol-extra-qat-dh895xcc +kmod-protocol-extra-qat-dh895xccvf +kmod-protocol-extra-qca-ppe +kmod-protocol-extra-qcrypto +kmod-protocol-extra-rds +kmod-protocol-extra-rsa-generic +kmod-protocol-extra-sch-choke +kmod-protocol-extra-sch-hhf +kmod-protocol-extra-sch-plug +kmod-protocol-extra-sch-qfq +kmod-protocol-extra-sch-sfb +kmod-protocol-extra-sctp-diag +kmod-protocol-extra-serpent-generic +kmod-protocol-extra-sha3-ce +kmod-protocol-extra-sm3-ce +kmod-protocol-extra-sm3-generic +kmod-protocol-extra-sm3-neon +kmod-protocol-extra-sm4 +kmod-protocol-extra-sm4-ce +kmod-protocol-extra-sm4-ce-ccm +kmod-protocol-extra-sm4-ce-cipher +kmod-protocol-extra-sm4-ce-gcm +kmod-protocol-extra-sm4-generic +kmod-protocol-extra-sm4-neon +kmod-protocol-extra-streebog-generic +kmod-protocol-extra-tag-ar9331 +kmod-protocol-extra-tag-gswip +kmod-protocol-extra-tag-hellcreek +kmod-protocol-extra-tag-ksz +kmod-protocol-extra-tag-lan9303 +kmod-protocol-extra-tag-mtk +kmod-protocol-extra-tag-ocelot +kmod-protocol-extra-tag-ocelot-8021q +kmod-protocol-extra-tag-qca +kmod-protocol-extra-tag-rzn1-a5psw +kmod-protocol-extra-tag-sja1105 +kmod-protocol-extra-tag-xrs700x +kmod-protocol-extra-tag-yt921x +kmod-protocol-extra-tag-yt922x +kmod-protocol-extra-tcp-bic +kmod-protocol-extra-tcp-cdg +kmod-protocol-extra-tcp-dctcp +kmod-protocol-extra-tcp-highspeed +kmod-protocol-extra-tcp-htcp +kmod-protocol-extra-tcp-illinois +kmod-protocol-extra-tcp-lp +kmod-protocol-extra-tcp-nv +kmod-protocol-extra-tcp-vegas +kmod-protocol-extra-tcp-veno +kmod-protocol-extra-tcp-westwood +kmod-protocol-extra-tcp-yeah +kmod-protocol-extra-tipc +kmod-protocol-extra-tipc-diag +kmod-protocol-extra-twofish-common +kmod-protocol-extra-twofish-generic +kmod-protocol-extra-virtio-crypto +kmod-protocol-extra-virtio-net +kmod-protocol-extra-vport-geneve +kmod-protocol-extra-vport-gre +kmod-protocol-extra-vport-vxlan +kmod-protocol-extra-wp512 +kmod-protocol-extra-x25 +kmod-protocol-extra-xctr +kmod-pstore +kmod-ptp +kmod-qrtr +kmod-qrtr-mhi +kmod-qrtr-smd +kmod-qrtr-tun +kmod-ramoops +kmod-reed-solomon +kmod-rfkill +kmod-rxrpc +kmod-sched +kmod-sched-act-gate +kmod-sched-act-pedit +kmod-sched-act-police +kmod-sched-act-sample +kmod-sched-act-vlan +kmod-sched-bpf +kmod-sched-cake +kmod-sched-cbs +kmod-sched-connmark +kmod-sched-core +kmod-sched-ctinfo +kmod-sched-drr +kmod-sched-dualpi2 +kmod-sched-etf +kmod-sched-ets +kmod-sched-flower +kmod-sched-gred +kmod-sched-mqprio +kmod-sched-mqprio-common +kmod-sched-pie +kmod-sched-prio +kmod-sched-red +kmod-sched-skbprio +kmod-sched-taprio +kmod-sctp +kmod-sit +kmod-slhc +kmod-slip +kmod-tcp-bbr +kmod-tcp-hybla +kmod-tcp-scalable +kmod-team +kmod-tls +kmod-tun +kmod-udptunnel4 +kmod-udptunnel6 +kmod-unix-diag +kmod-usb-dwc3 +kmod-usb-dwc3-qcom +kmod-usb-roles +kmod-usb-xhci-hcd +kmod-usb3 +kmod-veth +kmod-vrf +kmod-vsock +kmod-vxlan +kmod-wireguard
  KCONFIG:= \
	CONFIG_6LOWPAN \
	CONFIG_AFS_FS \
	CONFIG_AF_KCM \
	CONFIG_AF_RXRPC \
	CONFIG_AMT \
	CONFIG_ARCNET \
	CONFIG_ATALK \
	CONFIG_ATM \
	CONFIG_BAREUDP \
	CONFIG_BATMAN_ADV \
	CONFIG_BONDING \
	CONFIG_BRIDGE_NETFILTER \
	CONFIG_BT \
	CONFIG_CAIF \
	CONFIG_CAN \
	CONFIG_CEPH_FS \
	CONFIG_CEPH_LIB \
	CONFIG_CIFS \
	CONFIG_CODA_FS \
	CONFIG_CORDIC \
	CONFIG_CRC4 \
	CONFIG_CRC64 \
	CONFIG_CRC7 \
	CONFIG_CRC_T10DIF \
	CONFIG_CRYPTO_842 \
	CONFIG_CRYPTO_ADIANTUM \
	CONFIG_CRYPTO_AEGIS128 \
	CONFIG_CRYPTO_AES_ARM64 \
	CONFIG_CRYPTO_AES_ARM64_BS \
	CONFIG_CRYPTO_AES_ARM64_CE \
	CONFIG_CRYPTO_AES_ARM64_CE_BLK \
	CONFIG_CRYPTO_AES_ARM64_CE_CCM \
	CONFIG_CRYPTO_AES_ARM64_NEON_BLK \
	CONFIG_CRYPTO_AES_TI \
	CONFIG_CRYPTO_ANSI_CPRNG \
	CONFIG_CRYPTO_ARIA \
	CONFIG_CRYPTO_BENCHMARK \
	CONFIG_CRYPTO_BLAKE2B \
	CONFIG_CRYPTO_BLOWFISH \
	CONFIG_CRYPTO_CAMELLIA \
	CONFIG_CRYPTO_CAST5 \
	CONFIG_CRYPTO_CAST6 \
	CONFIG_CRYPTO_CHACHA20 \
	CONFIG_CRYPTO_CHACHA20POLY1305 \
	CONFIG_CRYPTO_CRC32 \
	CONFIG_CRYPTO_CRYPTD \
	CONFIG_CRYPTO_CTS \
	CONFIG_CRYPTO_DES \
	CONFIG_CRYPTO_DEV_AMLOGIC_GXL \
	CONFIG_CRYPTO_DEV_ATMEL_ECC \
	CONFIG_CRYPTO_DEV_ATMEL_SHA204A \
	CONFIG_CRYPTO_DEV_CCREE \
	CONFIG_CRYPTO_DEV_HISI_SEC \
	CONFIG_CRYPTO_DEV_NITROX_CNN55XX \
	CONFIG_CRYPTO_DEV_QAT_420XX \
	CONFIG_CRYPTO_DEV_QAT_4XXX \
	CONFIG_CRYPTO_DEV_QAT_C3XXX \
	CONFIG_CRYPTO_DEV_QAT_C3XXXVF \
	CONFIG_CRYPTO_DEV_QAT_C62X \
	CONFIG_CRYPTO_DEV_QAT_C62XVF \
	CONFIG_CRYPTO_DEV_QAT_DH895xCC \
	CONFIG_CRYPTO_DEV_QAT_DH895xCCVF \
	CONFIG_CRYPTO_DEV_QCE \
	CONFIG_CRYPTO_DEV_SAFEXCEL \
	CONFIG_CRYPTO_DEV_VIRTIO \
	CONFIG_CRYPTO_DH \
	CONFIG_CRYPTO_ECDH \
	CONFIG_CRYPTO_ECDSA \
	CONFIG_CRYPTO_ECHAINIV \
	CONFIG_CRYPTO_ECRDSA \
	CONFIG_CRYPTO_ESSIV \
	CONFIG_CRYPTO_FCRYPT \
	CONFIG_CRYPTO_GHASH_ARM64_CE \
	CONFIG_CRYPTO_HCTR2 \
	CONFIG_CRYPTO_KRB5 \
	CONFIG_CRYPTO_KRB5ENC \
	CONFIG_CRYPTO_LRW \
	CONFIG_CRYPTO_LZ4 \
	CONFIG_CRYPTO_LZ4HC \
	CONFIG_CRYPTO_MD4 \
	CONFIG_CRYPTO_MD5 \
	CONFIG_CRYPTO_NHPOLY1305_NEON \
	CONFIG_CRYPTO_PCBC \
	CONFIG_CRYPTO_PCRYPT \
	CONFIG_CRYPTO_POLYVAL_ARM64_CE \
	CONFIG_CRYPTO_RMD160 \
	CONFIG_CRYPTO_RSA \
	CONFIG_CRYPTO_SERPENT \
	CONFIG_CRYPTO_SHA3_ARM64 \
	CONFIG_CRYPTO_SM3_ARM64_CE \
	CONFIG_CRYPTO_SM3_GENERIC \
	CONFIG_CRYPTO_SM3_NEON \
	CONFIG_CRYPTO_SM4_ARM64_CE \
	CONFIG_CRYPTO_SM4_ARM64_CE_BLK \
	CONFIG_CRYPTO_SM4_ARM64_CE_CCM \
	CONFIG_CRYPTO_SM4_ARM64_CE_GCM \
	CONFIG_CRYPTO_SM4_ARM64_NEON_BLK \
	CONFIG_CRYPTO_SM4_GENERIC \
	CONFIG_CRYPTO_STREEBOG \
	CONFIG_CRYPTO_TWOFISH \
	CONFIG_CRYPTO_USER \
	CONFIG_CRYPTO_USER_API_AEAD \
	CONFIG_CRYPTO_USER_API_HASH \
	CONFIG_CRYPTO_USER_API_RNG \
	CONFIG_CRYPTO_USER_API_SKCIPHER \
	CONFIG_CRYPTO_WP512 \
	CONFIG_CRYPTO_XCBC \
	CONFIG_CRYPTO_XXHASH \
	CONFIG_DIBS \
	CONFIG_DNS_RESOLVER \
	CONFIG_DUMMY \
	CONFIG_EQUALIZER \
	CONFIG_FAILOVER \
	CONFIG_GENEVE \
	CONFIG_GTP \
	CONFIG_HSR \
	CONFIG_IEEE802154 \
	CONFIG_IFB \
	CONFIG_INET6_AH \
	CONFIG_INET6_ESP \
	CONFIG_INET6_IPCOMP \
	CONFIG_INET_AH \
	CONFIG_INET_DIAG \
	CONFIG_INET_ESP \
	CONFIG_INET_IPCOMP \
	CONFIG_IP6_NF_IPTABLES \
	CONFIG_IPV6_ILA \
	CONFIG_IPV6_MIP6 \
	CONFIG_IPV6_SIT \
	CONFIG_IPV6_TUNNEL \
	CONFIG_IPV6_VTI \
	CONFIG_IPVLAN \
	CONFIG_IP_NF_IPTABLES \
	CONFIG_IP_SCTP \
	CONFIG_IP_SET \
	CONFIG_IP_VS \
	CONFIG_L2TP \
	CONFIG_LAPB \
	CONFIG_LLC2 \
	CONFIG_MACSEC \
	CONFIG_MACVLAN \
	CONFIG_MHI_NET \
	CONFIG_NETFILTER_NETLINK_ACCT \
	CONFIG_NETFILTER_NETLINK_HOOK \
	CONFIG_NETFILTER_NETLINK_LOG \
	CONFIG_NETFILTER_NETLINK_OSF \
	CONFIG_NETFILTER_NETLINK_QUEUE \
	CONFIG_NETFILTER_XTABLES \
	CONFIG_NETLINK_DIAG \
	CONFIG_NET_9P \
	CONFIG_NET_ACT_BPF \
	CONFIG_NET_ACT_CONNMARK \
	CONFIG_NET_ACT_CT \
	CONFIG_NET_ACT_CTINFO \
	CONFIG_NET_ACT_GATE \
	CONFIG_NET_ACT_IFE \
	CONFIG_NET_ACT_MPLS \
	CONFIG_NET_ACT_NAT \
	CONFIG_NET_ACT_SAMPLE \
	CONFIG_NET_ACT_TUNNEL_KEY \
	CONFIG_NET_ACT_VLAN \
	CONFIG_NET_CLS_BPF \
	CONFIG_NET_CLS_CGROUP \
	CONFIG_NET_DSA_TAG_AR9331 \
	CONFIG_NET_DSA_TAG_BRCM \
	CONFIG_NET_DSA_TAG_BRCM_LEGACY \
	CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS \
	CONFIG_NET_DSA_TAG_BRCM_PREPEND \
	CONFIG_NET_DSA_TAG_DSA \
	CONFIG_NET_DSA_TAG_EDSA \
	CONFIG_NET_DSA_TAG_GSWIP \
	CONFIG_NET_DSA_TAG_HELLCREEK \
	CONFIG_NET_DSA_TAG_KSZ \
	CONFIG_NET_DSA_TAG_LAN9303 \
	CONFIG_NET_DSA_TAG_MTK \
	CONFIG_NET_DSA_TAG_MXL_862XX \
	CONFIG_NET_DSA_TAG_MXL_862XX_8021Q \
	CONFIG_NET_DSA_TAG_NONE \
	CONFIG_NET_DSA_TAG_OCELOT \
	CONFIG_NET_DSA_TAG_OCELOT_8021Q \
	CONFIG_NET_DSA_TAG_RTL4_A \
	CONFIG_NET_DSA_TAG_RTL8_4 \
	CONFIG_NET_DSA_TAG_RZN1_A5PSW \
	CONFIG_NET_DSA_TAG_SJA1105 \
	CONFIG_NET_DSA_TAG_TRAILER \
	CONFIG_NET_DSA_TAG_VSC73XX_8021Q \
	CONFIG_NET_DSA_TAG_XRS700X \
	CONFIG_NET_DSA_TAG_YT921X \
	CONFIG_NET_DSA_TAG_YT922X \
	CONFIG_NET_FOU \
	CONFIG_NET_IFE \
	CONFIG_NET_IPGRE_DEMUX \
	CONFIG_NET_IPIP \
	CONFIG_NET_IPVTI \
	CONFIG_NET_KEY \
	CONFIG_NET_NSH \
	CONFIG_NET_PKTGEN \
	CONFIG_NET_SCH_CBS \
	CONFIG_NET_SCH_CHOKE \
	CONFIG_NET_SCH_DRR \
	CONFIG_NET_SCH_DUALPI2 \
	CONFIG_NET_SCH_ETF \
	CONFIG_NET_SCH_HHF \
	CONFIG_NET_SCH_NETEM \
	CONFIG_NET_SCH_PIE \
	CONFIG_NET_SCH_PLUG \
	CONFIG_NET_SCH_QFQ \
	CONFIG_NET_SCH_SFB \
	CONFIG_NET_SCH_SKBPRIO \
	CONFIG_NET_SCH_TAPRIO \
	CONFIG_NET_TEAM \
	CONFIG_NET_UDP_TUNNEL \
	CONFIG_NET_VRF \
	CONFIG_NFC \
	CONFIG_NFSD \
	CONFIG_NFS_FS \
	CONFIG_NFT_CONNLIMIT \
	CONFIG_NFT_DUP_IPV4 \
	CONFIG_NFT_DUP_IPV6 \
	CONFIG_NFT_DUP_NETDEV \
	CONFIG_NFT_FIB_NETDEV \
	CONFIG_NFT_FWD_NETDEV \
	CONFIG_NFT_OSF \
	CONFIG_NFT_REJECT_NETDEV \
	CONFIG_NFT_SOCKET \
	CONFIG_NFT_SYNPROXY \
	CONFIG_NFT_TPROXY \
	CONFIG_NFT_TUNNEL \
	CONFIG_NF_CONNTRACK_AMANDA \
	CONFIG_NF_CONNTRACK_FTP \
	CONFIG_NF_CONNTRACK_H323 \
	CONFIG_NF_CONNTRACK_IRC \
	CONFIG_NF_CONNTRACK_NETBIOS_NS \
	CONFIG_NF_CONNTRACK_PPTP \
	CONFIG_NF_CONNTRACK_SANE \
	CONFIG_NF_CONNTRACK_SIP \
	CONFIG_NF_CONNTRACK_SNMP \
	CONFIG_NF_CONNTRACK_TFTP \
	CONFIG_NF_CT_NETLINK_TIMEOUT \
	CONFIG_NF_DUP_IPV4 \
	CONFIG_NF_DUP_IPV6 \
	CONFIG_NF_DUP_NETDEV \
	CONFIG_NF_LOG_ARP \
	CONFIG_NF_LOG_IPV4 \
	CONFIG_NF_LOG_IPV6 \
	CONFIG_NF_SOCKET_IPV4 \
	CONFIG_NF_SOCKET_IPV6 \
	CONFIG_NF_TPROXY_IPV4 \
	CONFIG_NF_TPROXY_IPV6 \
	CONFIG_NLMON \
	CONFIG_OPENVSWITCH \
	CONFIG_OVPN \
	CONFIG_PACKET_DIAG \
	CONFIG_PFCP \
	CONFIG_PHONET \
	CONFIG_PPP_BSDCOMP \
	CONFIG_PPP_DEFLATE \
	CONFIG_PPP_MPPE \
	CONFIG_PPP_SYNC_TTY \
	CONFIG_PRIME_NUMBERS \
	CONFIG_PSAMPLE \
	CONFIG_QRTR_TUN \
	CONFIG_RDS \
	CONFIG_RFKILL_FULL \
	CONFIG_SLIP \
	CONFIG_SMB_SERVER \
	CONFIG_TCP_CONG_BBR \
	CONFIG_TCP_CONG_BIC \
	CONFIG_TCP_CONG_CDG \
	CONFIG_TCP_CONG_DCTCP \
	CONFIG_TCP_CONG_HSTCP \
	CONFIG_TCP_CONG_HTCP \
	CONFIG_TCP_CONG_HYBLA \
	CONFIG_TCP_CONG_ILLINOIS \
	CONFIG_TCP_CONG_LP \
	CONFIG_TCP_CONG_NV \
	CONFIG_TCP_CONG_SCALABLE \
	CONFIG_TCP_CONG_VEGAS \
	CONFIG_TCP_CONG_VENO \
	CONFIG_TCP_CONG_WESTWOOD \
	CONFIG_TCP_CONG_YEAH \
	CONFIG_TIPC \
	CONFIG_TLS \
	CONFIG_TUN \
	CONFIG_UNIX_DIAG \
	CONFIG_VETH \
	CONFIG_VIRTIO_NET \
	CONFIG_VSOCKETS \
	CONFIG_VXLAN \
	CONFIG_WIREGUARD \
	CONFIG_X25 \
	CONFIG_XFRM_USER
endef

define KernelPackage/network-protocol-extras/description
 Complete module-capable network protocol and crypto profile.
 Native wireless remains supplied by the existing backports packages.
 Supplemental modules are not automatically loaded.
endef

$(eval $(call KernelPackage,network-protocol-extras))
