{% set home = grains['sugar']['home'] %}
{% set npm_config_prefix = home + "/.node_modules" %}

nodejs:
  npm_config_prefix: {{ npm_config_prefix }}
  pkgs:
    - nodejs # Evented I/O for V8 javascript
    - npm # A package manager for javascript
  dirs:
    - { path: {{ npm_config_prefix }} }
