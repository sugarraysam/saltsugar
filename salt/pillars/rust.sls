{% set home = grains['sugar']['user_home'] %}

rust:
  pkgs:
    - rustup # The Rust toolchain installer
  dirs:
    - { path: {{ home }}/.cargo }
  rustup_components:
    - {
        name: rustfmt,
        toolchain: stable,
      }
    - {
        name: rls,
        toolchain: stable,
      }
    - {
        name: rust-src,
        toolchain: nightly,
      }
