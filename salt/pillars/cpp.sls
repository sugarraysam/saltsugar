{% set home = grains['sugar']['home'] %}

cpp:
  pkgs:
    - gdb # The GNU Debugger
    - clang # C language family frontend for LLVM
    - cmake # A cross-platform open-source make system
    - swig # Generate scripting interfaces to C/cpp code
