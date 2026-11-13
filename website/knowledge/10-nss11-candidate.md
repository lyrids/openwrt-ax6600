# NSS 11.4 candidate and matched control

13 November 2026. Image16 is an offline-verified NSS 11.4 release6 candidate. Image15 is a matched NSS12.5 control. Both were built from commit `f10ed4c17a258e8b7df7fe4ec012b4a0763ce5ab`, retaining the current EDMA, lifetime and MTU fixes. Installed Image14 remains active; neither new image has been deployed.

The NSS binary, its selected filename and symlink, the runtime firmware selector, provenance and generated package records differ between the two images. Their persistent kernel FITs are identical. All549 module hashes,22 other firmware files,seven required utility binaries and the custom WireGuard handler match Image14. Both images retain the verified crash-capture reservation and current configuration profile.

The final initramfs and SquashFS contents passed complete metadata checks. All2204 common paths match between formats; ten standard root/bootstrap path differences are declared. Startup access for the unprivileged service UID and firmware payload hashes also passed offline checks.

NSS11.4 is the mesh-capable firmware selection. This does not establish stable mesh forwarding: earlier probes covered allocation without peer traffic, and the current candidate has no hardware qualification. Boot verification and a separately authorized mesh-peer test remain necessary. Historical reset and recovery findings remain open.
