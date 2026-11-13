# Persistent crash evidence

Ramoops reserves memory before Linux starts so kernel and console records may survive a warm reset. Pstore exposes retained records after boot; an archive service preserves them with integrity checks. External netconsole provides complementary evidence but can stop delivering when the network or CPU is stuck.

## Results and conclusion

Warm-reboot console retention was verified. A later T4/F10 SNAT TCP failure produced a persistent CPU soft-lockup and panic record involving netpoll, DSA, EDMA and qdisc processing. This is stronger evidence than an unexplained reset, but it does not identify the contended lock conclusively or explain the earlier resets.

The EDMA changes preserve transmit IRQ state and correct zero-budget NAPI handling. Image 14 passed a bounded 16-case replay. General watchdog retention, power-loss retention, complete capture of every hang and long-term stability remain unqualified.

The public site contains the conclusion and result scope. Raw crash records, register dumps, observer streams and per-case logs are not included. The upstream discussion is [OpenWrt issue 26660](https://github.com/openwrt/openwrt/issues/26660).
