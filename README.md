# RISC-V overlay

overlay for building nixos on and for risc-v.

It tries to build as many packages as possible on risc-v including its test suites. If that is not possible, it should cross-compile it from `x86_64-linux`.

Certain testsuites only work on native hardware or vms, not in user-mode emulation. For this, a system feature called `native-riscv` has been added to only run the build on native riscv machines. Make sure to add it to any native riscv builder you have.

## RISC-V caches:

| Cache Name | Cache Key | Contents |
|-|-|-|
| `https://attic.chir.rs/chir-rs` | `chir-rs:rzK1Czm3RqBbZLnXYrLM6JyOhfr6Z/8lhACIPO/LNFQ` | Anything built by https://hydra.chir.rs, persisted for 3 months |

If you want to help with building more store paths, or hosting additional caches, feel free to open an issue here.