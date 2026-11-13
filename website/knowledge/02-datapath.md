# The acceleration stack

The important distinction is who owns each part of the packet path. Linux networking and netfilter set up flows; the hardware and firmware paths then depend on device, topology, flow eligibility and active configuration.

## CPPE and Wi-Fi NSS

In the mainstream-derived lab images, CPPE handles eligible Ethernet hardware flow offload; the NSS firmware and ath11k integration accelerate eligible Wi-Fi paths. The selected configuration enables Wi-Fi NSS 12.5 and disables the separate Ethernet-only NSS backend. This does not mean an Ethernet leg of a mixed Wi-Fi flow cannot use NSS resources. Software flow offload, CPPE entries and NSS rules are separate observations.

Conceptually: `client → radio / ath11k → NSS when eligible → Linux or CPPE forwarding → Ethernet`. The reverse direction and bridge, VLAN, NAT and routed paths have different ownership and eligibility. This is a guide to investigation, not a claim that every packet follows one fixed path.

## Proving a flow

Capture the actual ingress and egress tuple, then compare installed CPPE rows and NSS rules with direction-specific packet counter deltas during that flow. Correlate with receiver results, retransmissions or loss, and comparable per-core CPU. An `HW_OFFLOAD` flag, a cumulative push counter, or an idle table snapshot alone does not prove that a particular flow traversed hardware.

The 2026-10-31 capacity probes reached 2,048 CPPE base slots in the measured IPv4 routed and SNAT cases. NSS 12.5 plateaued at 1,024 installed IPv4 UDP rules with turnover at higher offered counts. These are independent measured budgets, not universal chip limits. IPv6 CPPE rows consume two slots; distinguish rules from connection counts.
