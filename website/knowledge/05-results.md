# Results, limits & next work

## What is established

- The original stock image used LibWrt with an NSS-based Ethernet driver and NSS firmware 12.5.
- A mainstream-derived Image 12 was installed and passed boot, module, firmware, configuration and service checks. Wi-Fi NSS was enabled; the separate Ethernet-only NSS backend was disabled. Private deployment routing and DNS policy are outside this public summary.
- Image 10 passed the specified 708 UDP MTU and 114 TCP recovery checks in its selected campaign. Those counts do not establish the same coverage for Image 12 or every topology.
- TFTP capture and image reconstruction, packet-level accounting and fresh netconsole provided stronger evidence than a simple successful boot.

## What remains open

Earlier native and NSS experiments recorded uncommanded resets under specific loads without a captured fault establishing the cause. High-rate UDP loss, endpoint limits and some radio/IP recovery failures were observed in other campaigns. The Image 10 rerun did not establish long-term stability; Image 12 has not inherited its test qualification. PPPoE, VPN, jumbo MTUs and additional offload configurations have separate coverage limits. A later capture-enabled investigation produced a T4/F10 soft-lockup panic record. Image14 passed the bounded16-case T4/F10 replay; precise root cause and long-term stability remain unproven. See the latest EDMA and crash-capture articles.

For a new IPQ601x port, validate board data, Ethernet and radio wiring, bootloader limits, flash layout, firmware ABI and recovery first. Establish a native control, then add acceleration incrementally; compare packet-level behavior, CPU and installed rules. Preserve failed attempts and record which evidence would disprove a hypothesis.
