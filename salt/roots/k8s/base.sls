{% set user = grains['sugar']['user'] %}

# Install pkgs
k8s_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['k8s']['pkgs'] }}

# Create directories
{% for d in pillar['k8s']['dirs'] %}
{{ d.path }}:
  file.directory:
    - user: {% if d.user is defined %} {{ d.user }} {% else %} {{ user }} {% endif %}
    - group: {% if d.group is defined %} {{ d.group }} {% else %} {{ user }} {% endif %}
    - mode: {% if d.mode is defined %} {{ d.mode }} {% else %} 0755 {% endif %}
    - makedirs: True
{% endfor %}

# zsh completions
{% for c in pillar['k8s']['zsh_completions'] %}
{{ c }}:
  cmd.run:
    - require:
        - pkg: k8s_pkgs
{% endfor %}
