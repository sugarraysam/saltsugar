include:
  - .pulseaudio

i3_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['i3']['pkgs'] }}

i3_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['i3']['dotfiles'] }}
