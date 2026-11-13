# Test endpoints and measurement limits

The lab uses independent wired and wireless endpoints. Their hardware, kernel versions and receiver behavior can limit measured throughput even when the router forwards correctly.

## Conclusions

- Dedicated Ethernet management keeps test payload separate from recovery access.
- Raspberry Pi 4 and NanoPi-class endpoints have different wireless capabilities; do not compare their rates as if the radios were identical.
- Receive steering and endpoint socket buffers must be verified before high-rate tests. Receiver errors and offered load matter alongside router CPU use.
- Association, IP recovery, delivered traffic and sustained stability are separate outcomes.

Host addresses, machine identifiers, private network configuration and detailed inventories are omitted from this public edition.
