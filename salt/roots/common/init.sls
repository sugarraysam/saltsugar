include:
  - .systemd
  - .pacman

common_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['common']['pkgs'] }}

common_dirs:
  sugfile.directories:
    - dirs: {{ pillar['common']['dirs'] }}

common_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['common']['dotfiles'] }}
    - require:
      - sugfile: common_dirs

common_remove_files:
  sugfile.remove_files:
    - files: {{ pillar['common']['files_to_remove'] }}

common_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['common']['zsh_completions'] }}
    - require:
      - pkg: common_pkgs

# Update tldr cache
"tldr -u":
  cmd.run:
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: common_pkgs

# Setup .gitconfig
{% for cfg in pillar['common']['git_configs'] %}
git_cfg_{{ cfg.name }}:
  git.config_set:
    - name: {{ cfg.name }}
    - value: {{ cfg.value }}
    - user: {{ grains['sugar']['user'] }}
    - global: True
    - require:
      - pkg: common_pkgs
{% endfor %}

add_user_to_groups:
  user.present:
    - name: {{ grains['sugar']['user'] }}
    - groups: {{ pillar['common']['groups'] }}
    - require:
      - pkg: common_pkgs

gnupg_keyring_permissions:
  file.directory:
    - name: {{ grains['sugar']['home'] }}/.gnupg
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - file_mode: 0600
    - dir_mode: 0700
    - recurse:
      - user
      - group
      - mode
    - require:
      - sugfile: common_symlink_dotfiles
