nodejs_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['nodejs']['pkgs'] }}

nodejs_dirs:
  sugfile.directories:
    - dirs: {{ pillar['nodejs']['dirs'] }}

# Run nodejs cmds
{% for c in pillar['nodejs']['cmds'] %}
nodejs_cmd_{{ c.id }}:
  cmd.run:
    - name: "{{ c.cmd }}"
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - npm_config_prefix: {{ pillar['nodejs']['npm_config_prefix'] }}
    - require:
      - pkg: nodejs_pkgs
      - sugfile: nodejs_dirs
{% endfor %}
