nvim_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['nvim']['pkgs'] }}

nvim_dirs:
  sugfile.directories:
    - dirs: {{ pillar['nvim']['dirs'] }}

nvim_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['nvim']['dotfiles'] }}

install_vim_plug:
  file.managed:
    - name: {{ pillar['nvim']['vim_plug_dest'] }}
    - source: {{ pillar['nvim']['vim_plug_url'] }}
    - skip_verify: True
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - makedirs: True

manage_vim_plug_plugins:
  cmd.run:
    - name: |
        nvim --headless +PlugInstall! +qall
        nvim --headless +PlugUpdate! +qall
        nvim --headless +PlugClean! +qall
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - file: install_vim_plug
      - pkg: nvim_pkgs
      - sugfile: nvim_dirs
      - sugfile: nvim_symlink_dotfiles
