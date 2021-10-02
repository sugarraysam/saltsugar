{% set home = grains['sugar']['home'] %}

tmux:
  pkgs:
    - tmux
  dirs:
    - { path: {{ home }}/.tmux/plugins }
    - { path: {{ home }}/.tmux/resurrect }
  dotfiles:
    - {
        src: /srv/salt/tmux/dotfiles/tmux.conf,
        dest: {{ home }}/.tmux.conf,
      }
  tpm_url: https://github.com/tmux-plugins/tpm
  tpm_dest: {{ home }}/.tmux/plugins/tpm
  sessions_dir: {{ home }}/.tmux/resurrect
  sessions_delete_after_days: 2
