{% set home = grains['sugar']['home'] %}

rust:
  pkgs:
    - rustup # The Rust toolchain installer
    - rust-analyzer # Rust compiler front-end for IDEs
  dirs:
    - { path: {{ home }}/.cargo }
  rustup_toolchains:
    - stable
    - nightly
  rustup_default_toolchain: nightly
  rustup_components:
    - clippy
    - rls
    - rustfmt
    - rust-analysis
    - rust-src
