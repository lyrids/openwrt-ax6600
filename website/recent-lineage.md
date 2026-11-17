## Later images and diagnostics

The interactive graph below covers the earlier documented variants through Image 14. These later records are listed separately: build ancestry, installed images and RAM diagnostics are not a single linear chain.

| Image | Role and observed status | Qualification |
| --- | --- | --- |
| 15 | Matched NSS 12.5 control, offline verified | Not deployed |
| 16 | NSS 11.4, Linux 6.18.60; RAM tested | Does not establish stability |
| 17 | Dual NSS 11.4/12.5 image; installed on router A, startup selection 11.4 | Installation and payload checks passed; no general stability qualification |
| 18 | Public default dual-firmware build, offline verified | Not deployed or released |
| 19–20 | Unbooted intermediate variants | Image 20 had malformed firewall content and must not be booted |
| 21 | Router B configuration candidate, successfully RAM booted after an unsuccessful HTTP attempt | Inherited DNS configuration required repair; not a clean reusable source |
| 22 | Reserved candidate failed pre-build validation | No completed image |
| 23 | Clean router B image, based on Image 16 software; installed with a router-specific upgrade guard | Installed boot and clean/stock selection verified; RAM and installed outputs differ. No endurance or actual sysupgrade-cycle qualification |
| 23 capture variant | Watchdog pretimeout changed from 5 to 15 seconds; RAM booted and independently checked | RAM-only, not installed; initial controller configuration assertion retained. One campaign reset occurred while it was running; no new bark, stack, panic or retained pstore trace was captured. Cause remains unresolved; crash retention and stability are unqualified |

Router A Image 17 uses source `06e760f37b0e6aa5b0964fab9898c7dcbc920cd5`; router B Image 23 uses Image 16 software source `f10ed4c17a258e8b7df7fe4ec012b4a0763ce5ab`. Both use Linux 6.18.60. Image 23 is not a descendant of Image 17 merely because it has a later number. The earlier Image 14 candidate included EDMA IRQ-state and zero-budget NAPI fixes and ramoops; router A’s installed sequence was Image 12, then Image 14, then Image 17.
