{% set home = grains['sugar']['home'] %}
{% set npm_config_prefix = home + "/.node_modules" %}

nodejs:
  npm_config_prefix: {{ npm_config_prefix }}
  pkgs:
    - nodejs # Evented I/O for V8 javascript
  dirs:
    - { path: {{ npm_config_prefix }} }
  dotfiles:
    - {
        src: /srv/salt/nodejs/dotfiles/nodejs.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/nodejs.sh,
      }
  npm_pkgs:
    - npm # A package manager for javascript
