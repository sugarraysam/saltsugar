{% set home = grains['sugar']['user_home'] %}

vbox:
  pkgs:
    - virtualbox # Powerful x86 virtualization for enterprise as well as home use
    - virtualbox-host-modules-arch # Virtualbox host kernel modules for Arch Kernel
  machine_folder_path: {{ home }}/vms
