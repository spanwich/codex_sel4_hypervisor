# codex_sel4_hypervisor

This repository contains helper scripts and notes for bootstrapping a simple
seL4 + CAmkES build on x86_64.

The goal is to provide a starting point for experimenting with RTOS workloads
on the seL4 microkernel.

## Getting Started

The `setup_camkes_x86.sh` script downloads the official `camkes-manifest` using
the `repo` tool and configures an x86_64 build directory. When run as root on a
Debian/Ubuntu system, it will install the few required tools (`repo`, `git`,
`cmake`, and `ninja-build`) if they are missing.

Run the following to fetch sources and build the example:

```bash
./setup_camkes_x86.sh
```

The script creates a `seL4-project/` folder containing the manifest checkout.
The resulting build artifacts are placed in `seL4-project/build/`.

## License

This project is released under the MIT License. See the [LICENSE](LICENSE) file
for details.
