X_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['X']['pkgs'] }}

X_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['X']['dotfiles'] }}
