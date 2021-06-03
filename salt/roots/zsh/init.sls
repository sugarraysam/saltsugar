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

create_zshrcd_dir:
  file.directory:
    - name: {{ pillar['zsh']['zshrcd_dest'] }}
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - mode: 0775

# Symlink zshrc.d/* files
{% for src in salt['file.find'](pillar['zsh']['zshrcd_src'], type='f') %}
{% set fname = salt['file.basename'](src) %}
{% set dest = salt['file.join'](pillar['zsh']['zshrcd_dest'], fname) %}
zsh_symlink_{{ fname }}:
  file.symlink:
    - name: {{ dest }}
    - target: {{ src }}
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - mode: 0644
    - force: True
    - require:
      - file: create_zshrcd_dir
{% endfor %}
