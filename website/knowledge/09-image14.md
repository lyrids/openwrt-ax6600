# Latest EDMA fixes & Image 14

**13 November 2026 update.** Image14 was subsequently installed on eMMC with its selected profile and crash collector preserved. Warm-reboot console archival passed. The RAM replay below describes the earlier test stage. Image15 and Image16 are offline-verified control and candidate builds; neither has been deployed.

## The code change

The candidate was built from source `21efb75b4c55fa119cbb34cecebdf0baaf5f3a41` with a working-tree patch to the built-in qca_edma driver. Source commit alone does not identify these candidate images.

| Area | Change | Why / limit |
| --- | --- | --- |
| TX locking | IRQ-save/restore in edma_ring_xmit and edma_tx_flush, including transmit exit paths | Preserve caller interrupt state under netpoll; the stack supports this mechanism but does not identify the precise lock conclusively |
| Zero-budget NAPI | Bounded TX completion cleanup; return before RX, refill/page-pool or NAPI completion work | Respect the zero-budget netpoll/NAPI contract; distinguish live poll from shutdown drain |
| SKB freeing / queues | Preserve original freeing budget and drain queue-wake intentions | Retain earlier upstream safety work |
| Image13 packaging | EDMA patch and capture-enabled candidate; first boot lacked WireGuard executable | Temporary executable restoration preserved custom handler; this was a candidate defect |
| Image14 packaging | Include WireGuard executable and retain customized handler / declared profile | Same patch; corrected RAM candidate |

Driver compilation, object inspection, exit-path audit and extracted-function harnesses passed. Mocked locking is not kernel concurrency proof. Increased interrupt-off time during TX/DMA setup may affect latency or throughput and still requires measurement.

## Hardware replay and limits

Image14 passed all 16 T4/F10 cases: route, SNAT, DNAT and combined NAT; TCP/UDP; both initiators. Six-second cases used unpaced TCP or 25 Mbps UDP. All eight UDP receivers reported zero loss; TCP receiver rates ranged 840.14–922.47 Mbps. Each case received fresh mid-load netconsole evidence and cleanup completed. The previously failing SNAT/F10 p43-to-wrt TCP case passed once. No T5 replay, extended endurance or general stability qualification was established.

The first Image14 boot attempt saw ARP but no TFTP request and fell back to installed Image12. The retry reconstructed the exact FIT with 20,714 acknowledged blocks and zero retransmissions/fragments/capture drops. Its 549 modules and 23 firmware files match Image12; EDMA changes are built into the new kernel. Ramoops, station association, normal services and fresh netconsole were verified. Earlier unexplained resets, intermittent no-RRQ and stale startup time remain follow-ups.

## Source lineage

The report traced the archived `openwrt/qca-edma` tip to an identical source-file blob in OpenWrt import `bdb0b722b7f0`. Identical file content is distinct from Git ancestry. Later upstream work added safe freeing budgets, drain wake suppression, multiqueue RX/TX and software ring indices. The five affected functions remained text-identical between the selected base `39e77cc05db9` and committed Image12 source; the candidate was built with a working-tree delta. Those changes are now committed as 60f1e57c37 (NAPI) and ab443fb6c3 (TX locking), and main incorporates them through merge 6f24f8a02b.

References: [archived EDMA repository](https://github.com/openwrt/qca-edma), [OpenWrt import](https://github.com/openwrt/openwrt/commit/bdb0b722b7f0b8cae43c50f2643cd74fe243cb8d), [multiqueue change](https://github.com/openwrt/openwrt/commit/207962a83a604e16220339e42b0388684384be32), [networking rework](https://github.com/openwrt/openwrt/pull/22381).

Image14 FIT SHA-256: `001dceca26f533d467db5f2c08b267ad60953b9d37846fd0b6d7da911e45afc6`. Embedded patch SHA-256: `7e566c1c81f71e8656b2d1f7dcd95d588287e44a97aa5c82cc447f44e70269ca`.



## Repository status

The canonical repository is [lyrids/openwrt-ax6600](https://github.com/lyrids/openwrt-ax6600). Main contains the tested development source and both EDMA fixes. Image 14 predates those commits; its embedded build provenance is retained rather than retroactively changed.
