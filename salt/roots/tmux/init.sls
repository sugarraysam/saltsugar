tmux_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['tmux']['pkgs'] }}

tmux_dirs:
  sugfile.directories:
    - dirs: {{ pillar['tmux']['dirs'] }}

tmux_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['tmux']['dotfiles'] }}

clone_tpm:
  git.latest:
    - name: {{ pillar['tmux']['tpm_url'] }}
    - target: {{ pillar['tmux']['tpm_dest'] }}
    - user: {{ grains['sugar']['user'] }}
    - rev: master
    - depth: 1
    - force_checkout: True # discard unwritten changes
    - force_clone: True # overwrite existing dir

create_tmux_session:
  cmd.run:
    - name: tmux new-session -d -s main
    - unless: tmux has-session -t main
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: tmux_pkgs
      - sugfile: tmux_dirs
      - sugfile: tmux_symlink_dotfiles
      - git: clone_tpm

# If session already exists, make sure it is synced with latest tmux config
source_tmux_conf:
  cmd.run:
    - name: tmux source {{ grains['sugar']['home'] }}/.tmux.conf
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: create_tmux_session

manage_tpm_plugins:
  cmd.run:
    - name: |
        {{ pillar['tmux']['tpm_dest'] }}/bin/install_plugins
        {{ pillar['tmux']['tpm_dest'] }}/bin/update_plugins all
        {{ pillar['tmux']['tpm_dest'] }}/bin/clean_plugins
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: source_tmux_conf

remove_old_resurrect_sessions:
  cmd.run:
    - name: find {{ pillar['tmux']['sessions_dir'] }} -type f -mtime +{{ pillar['tmux']['sessions_delete_after_days'] }} -delete
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: manage_tpm_plugins
