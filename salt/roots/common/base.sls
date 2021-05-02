{% set user = grains['sugar']['user'] %}

# Install pkgs
common_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['common']['pkgs'] }}

common_dirs:
  sugfile.directories:
    - dirs: {{ pillar['common']['dirs'] }}

# Create dotfiles
{% for f in pillar['common']['dotfiles'] %}
{{ f.dest }}:
  file.symlink:
    - target: {{ f.src }}
    - force: True
    - user: {% if f.user is defined %} {{ f.user }} {% else %} {{ user }} {% endif %}
    - group: {% if f.group is defined %} {{ f.group }} {% else %} {{ user }} {% endif %}
    - mode: {% if f.mode is defined %} {{ f.mode }} {% else %} 0755 {% endif %}
    - makedirs: True
{% endfor %}

## Delete files
{% for f in pillar['common']['files_to_remove'] %}
{{ f }}:
  file.absent
{% endfor %}

# zsh completions
{% for c in pillar['common']['zsh_completions'] %}
{{ c }}:
  cmd.run:
    - require:
        - pkg: common_pkgs
{% endfor %}
