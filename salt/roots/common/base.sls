common_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['common']['pkgs'] }}

common_dirs:
  sugfile.directories:
    - dirs: {{ pillar['common']['dirs'] }}

common_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['common']['dotfiles'] }}

common_remove_files:
  sugfile.remove_files:
    - files: {{ pillar['common']['files_to_remove'] }}

common_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['common']['zsh_completions'] }}
    - require:
      - pkg: common_pkgs
