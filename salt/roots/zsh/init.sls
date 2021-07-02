zsh_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['zsh']['pkgs'] }}

zsh_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['zsh']['dotfiles'] }}

zsh_default_shell_user:
  file.line:
    - name: /etc/passwd
    - mode: replace
    - match: "^sugar.*$"
    - content: {{ pillar['zsh']['etc_passwd_line'] }}
    - require:
      - pkg: zsh_pkgs

{% for r in pillar['zsh']['git_repos'] %}
zsh_git_repos_{{ r.name }}:
  git.latest:
    - name: {{ r.url }}
    - target: {{ r.dest }}
    - user: {{ grains['sugar']['user'] }}
    - rev: master
    - depth: 1
    - force_checkout: True # discard unwritten changes
    - force_clone: True # overwrite existing dir
{% endfor %}

create_zshrcd_or_fix_perms:
  file.directory:
    - name: {{ grains['sugar']['zshrcd_path'] }}
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - mode: 0775

# TODO get rid of this and have each state manage their drop-ins zshrcd as a dotfile
# Symlink zshrc.d/* files
{% for src in salt['file.find'](pillar['zsh']['zshrcd_src'], type='f') %}
{% set fname = salt['file.basename'](src) %}
{% set dest = salt['file.join'](grains['sugar']['zshrcd_path'], fname) %}
zsh_symlink_{{ fname }}:
  file.symlink:
    - name: {{ dest }}
    - target: {{ src }}
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - mode: 0644
    - force: True
    - require:
      - file: create_zshrcd_or_fix_perms
{% endfor %}

# 15-06-2021 was still in AUR
install_direnv:
  cmd.run:
    - name: "curl -sfL {{ pillar['zsh']['direnv_url'] }} | bash"
    - env:
      - bin_path: {{ grains['sugar']['localbin_path'] }}
    - runas: {{ grains['sugar']['user'] }}
