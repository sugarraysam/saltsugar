nodejs_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['nodejs']['pkgs'] }}

nodejs_dirs:
  sugfile.directories:
    - dirs: {{ pillar['nodejs']['dirs'] }}

install_npm:
  cmd.run:
    - name: npm -g install npm
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - npm_config_prefix: {{ pillar['nodejs']['npm_config_prefix'] }}
    - require:
      - pkg: nodejs_pkgs
      - sugfile: nodejs_dirs
