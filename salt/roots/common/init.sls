include:
  - .base
  - .systemd

# Update tldr cache
"tldr -u":
  cmd.run:
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - sls: common.base

# Setup .gitconfig
{% for cfg in pillar['common']['git_configs'] %}
git_cfg_{{ cfg.name }}:
  git.config_set:
    - name: {{ cfg.name }}
    - value: {{ cfg.value }}
    - user: {{ grains['sugar']['user'] }}
    - global: True
    - require:
      - sls: common.base
{% endfor %}
