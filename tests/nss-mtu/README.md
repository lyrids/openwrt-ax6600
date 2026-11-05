# Wi-Fi NSS and CPPE MTU regression tests

Integration base: 3b9d911f080d1d2412612e138de215beb3fe1be6 (Linux 6.18.60).
The NSS/EDMA prerequisites come from e62fbb3bf4 and 8c006513ac; the full
MTU correctness changes come from 18165fc0e8 and 3196df75e4. These historical
changes were based on OpenWrt a516fe3151. The newer upstream source, generic
MTU fix/selftest and ath11k HTT lifetime fix are retained. The generic extension
adds snapshot/admission guards after pending patch 709 without duplicating its
notifier or upper/lower dependency helper. Native diagnostic options are retained.

Run on the Linux build VM:

```sh
python3 tests/nss-mtu/run-host-tests.py --output /home/ly/projects/openwrt-dev/artifacts/nss-mtu-new-check
```

The runner extracts the production functions directly from their C sources,
compiles them against deterministic netdev, hash-table, RTNL and firmware-message
mocks, and runs 59 assertions with AddressSanitizer and UndefinedBehaviorSanitizer.
It tests directional route/device MTU selection, IP MTU limits and PPPoE payload headroom,
field overflow, IPv4/IPv6 minimums, upper/lower dependencies, selective invalidation,
MTU preparation veto on failed firmware deletion, admission serialization, aborted
MTU transactions, and retaining/retrying failed deletes after the kernel flow dies.
Mocks do not establish hardware behavior, firmware interoperability or concurrency
under real kernel scheduling.

## Hardware qualification still required

Preserve the current HE160 station profile and the separate overnight campaign.
Only run after obtaining the shared traffic lock and coordinating its lifecycle.
Use canonical ramboot.py and the final image metadata gate; do not write flash or
saved bootloader state. Verify actual endpoint leases and protected management
paths rather than copying historical addresses into new rules.

1. Verify native operation with NSS disabled, then NSS12.5 Wi-Fi with Ethernet NSS
   disabled. Verify ordinary services, wired management, fresh netconsole, radio
   association, DHCP/IP recovery, installed rules and per-direction packet deltas.
2. Repeat fresh-MTU admission with logical 1400 and physical 1500: IP lengths
   1399, 1400, 1401 and 1500. Cover route/single NAT/combined NAT, both directions,
   native/VLAN/bridge paths and modes 00/10/11. Keep direct CPPE and NSS ownership
   distinct. Ensure wrt's physical link has the extra VLAN tag headroom.
3. On established flows change 1500 -> 1400 -> 1500. Verify owning rules disappear,
   cached routes are rebuilt, unrelated flows remain, and the same connection
   obeys the new boundary without firewall reload or flowtable recreation.
4. Verify IPv4 DF and non-DF behavior, ICMP fragmentation-needed, IPv6 Packet Too
   Big, TCP retransmission/PMTU recovery, TTL and VLAN correctness. Keep hardware
   MTU exceptions distinguishable from socket loss and stale receiver accounting.
5. Compare eligible-path throughput and per-core CPU, then radio restart/rekey and
   bounded load. Historical resets and IP-recovery failures remain open.

Diagnostics: CPPE debugfs flow_mtu exposes each row's logical ifindex, routed IP
MTU, programmed egress IP MTU and Wi-Fi steering ownership. CPPE offload adds
mtu_invalidated/mtu_rejected; NSS flows adds mtu_events and retired_rules.
Ethernet-only NSS is explicitly unsupported in this port, and enabling its module
parameter is rejected. Reduced logical MTU NSS flows retain the conservative
Linux fallback until firmware enforcement is separately qualified.

The default candidate rejects reduced logical MTU hardware admission for CPPE as
well as NSS. The corrected CPPE enforcement path is available for qualification
with the boot-latched kernel option qca_ppe.logical_mtu_offload=1. It is read-only
at runtime; test this path separately and require correct MTU/ICMP/TTL handling
before changing the safe default. The normal-MTU and standard PPPoE paths remain
eligible. This option does not enable the Ethernet NSS backend.
