{% set home = grains['sugar']['user_home'] %}

cpp:
  pkgs:
    - bazel # Correct, reproducible, and fast builds for everyone
    - gdb # The GNU Debugger
    - clang # C language family frontend for LLVM
    - cmake # A cross-platform open-source make system
    - swig # Generate scripting interfaces to C/cpp code
  gh_binaries:
    - {
        dest: {{ home }}/.local/bin/buildifier,
        repo: "bazelbuild/buildtools",
        urlfmt: "https://github.com/bazelbuild/buildtools/releases/download/{tag}/buildifier-linux-amd64",
      }
