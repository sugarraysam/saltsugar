nodejs_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['nodejs']['pkgs'] }}

nodejs_dirs:
  sugfile.directories:
    - dirs: {{ pillar['nodejs']['dirs'] }}

nodejs_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['nodejs']['dotfiles'] }}

nvm_use_system:
  cmd.run:
    - name: nvm use system; exit 0
    - runas: {{ grains['sugar']['user'] }}

install_npm_pkgs:
  cmd.run:
    - name: npm -g install {{ " ".join(pillar['nodejs']['npm_pkgs']) }}
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - npm_config_prefix: {{ pillar['nodejs']['npm_config_prefix'] }}
    - require:
      - cmd: nvm_use_system
      - pkg: nodejs_pkgs
      - sugfile: nodejs_dirs
