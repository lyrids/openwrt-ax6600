# Porting concepts & newer platforms

## Linux networking concepts

| Concept | Role | Porting question |
| --- | --- | --- |
| DSA | Models supported switch ports as Linux network devices managed through the switch framework. | Which driver actually owns each physical port? Stock on this DUT used nss-dp; the mere presence of DSA modules proves nothing about those ports. |
| Bridge and VLAN | A bridge forwards within a Layer 2 domain; VLANs separate tagged traffic. | Are tags, bridge membership, MTUs and hardware eligibility correct in both directions? |
| Routing and NAT | Routing selects a Layer 3 next hop; NAT changes addresses or ports when configured. | Does the actual packet tuple and return path match the intended policy? |
| Conntrack | Tracks connection state and NAT mappings through netfilter. | Is a connection tracked, eligible and correctly invalidated? Conntrack count is not a hardware rule count. |
| Flowtable | A netfilter fast path can bypass portions of the normal forwarding path for eligible established flows. | Does the driver admit the flow, and does it remove or update it on MTU, route or device changes? |
| RPS and CPU affinity | Receive Packet Steering distributes software receive processing; IRQ and queue placement also affect CPU load. | Measure per-core utilization, packet loss and receive errors with the same offered load before and after changes. |

References: [Linux DSA documentation](https://docs.kernel.org/networking/dsa/dsa.html), [netfilter flowtable documentation](https://docs.kernel.org/networking/nf_flowtable.html), [Linux network scaling](https://docs.kernel.org/networking/scaling.html).

## Performance tuning is an experiment

Establish a baseline and change one factor at a time. Measure sender offer, receiver delivery, retransmissions or UDP loss, endpoint socket buffers and receive errors, per-core CPU, radio conditions, and hardware counters. CPU affinity and RPS can shift a bottleneck; increasing a system socket ceiling alone does not enlarge an application's socket. Record protocol, direction, duration and topology. A throughput gain cannot by itself prove correct offload or MTU handling.

## Qualcomm generations

| Platform | Context | What carries over |
| --- | --- | --- |
| IPQ601x / this RE-CS-02 | Wi-Fi 6-era platform; this device also has PCIe QCN9074. | Our measured results are for this board and the recorded builds. |
| IPQ9574 / Networking Pro 1220 | Qualcomm describes a Wi-Fi 7, 12-stream platform with 320 MHz support and 10GbE-class interfaces. | The methodology carries over; drivers, firmware, board design and acceleration implementation must be revalidated. |

Qualcomm now groups Networking Pro 620/820/1220/1620 under its [Dragonwing NPro 7 platform](https://www.qualcomm.com/networking-infrastructure/products/npro-series/npro-7-platform). Its [1220 product brief](https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Networking-Pro-1220-product-brief_87-PW326-1.pdf) identifies IPQ9574. Vendor PHY rates are not application throughput, and this project has not tested those devices.
