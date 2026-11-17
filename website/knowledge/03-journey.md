# From stock to mainstream

The goal was to retain a mainstream OpenWrt base while bringing back the acceleration required for this board. “Minimum necessary” is a design objective: a patch-by-patch proof of minimality across all configurations is still an audit task, not a measured result.

## Milestones

**Stock and native baselines · October 2026.** Read-only stock inspection established the LibWrt/NSS stack. A native upstream RAM image provided a control with NSS absent and vanilla ath11k/mac80211. Native operation did not eliminate all stress resets, so the evidence does not attribute every reset to NSS.

**First integration · 1 November.** Image 2 compiled NSS but failed startup when newer EDMA rejected shared DMA/reset assumptions. Image 3 restored shared-reset and active-ring guards and CPU-only queue mapping; Wi-Fi NSS started. Its MTU regression still failed: 296 of 3,258 qualified boundary points failed. Image 4 improved enforcement but retained in-range loss. Those failures remain part of the record.

**Isolation and updated source · 2–5 November.** A matched native-mode control helped investigate receive loss. Subsequent work reconciled NSS/EDMA prerequisites and MTU corrections with a newer mainstream base. Image 9 booted and completed bounded station tests, but high-rate loss and recovery limitations remained.

**Review and qualification · 5–6 November.** Image 10 added fixes involving object lifetime, DMA ownership, teardown and IPv6 MTU behavior. In its selected rerun, 708/708 UDP MTU cases and 114/114 TCP recovery checks passed. All 39 station-load cases completed without an observed DUT reset, while high-rate loss and endpoint/CPU limits remained. This was bounded campaign evidence, not a stability guarantee.

**Persistent installation · 7 November.** After explicit backup and partition work, Image 10 was installed in the secondary eMMC pair. Image 12, source `21efb75b4c55fa119cbb34cecebdf0baaf5f3a41`, Linux 6.18.60, subsequently replaced it via a settings-preserving sysupgrade. Its build includes additional network modules; its provisional artifact label “11” is recorded separately from registry number 12. Installation and readiness were verified; the Image 10 full MTU and load campaign was not repeated on Image 12.

## Capture-enabled candidates · 12 November

Image13 brought the local EDMA netpoll/NAPI patch into a RAM candidate but lacked the WireGuard executable. Image14 restored that tool, retained the customized handler and active ramoops, and passed16 selected T4/F10 cases. The candidate used a working-tree patch on Image12 source; that source change is now committed in this repository; the precise fault cause and long-term stability remain unproven. Image12 was installed at that report time; router A later moved to Image17 on eMMC.

## Patch categories to audit

Separate device support and NSS/ath11k/EDMA integration prerequisites from MTU correctness, lifetime and teardown fixes, performance tuning, diagnostics, extra packages, and private site configuration. Source commit alone may omit local build deltas. Compare the pinned base, commits, feeds, configuration, overlay and actual image before calling a change essential or upstreamable.
