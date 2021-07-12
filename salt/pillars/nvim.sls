{% set home = grains['sugar']['home'] %}

nvim:
  pkgs:
    - neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
    - prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more (ALE)
    - shellcheck # Shell script analysis tool (required by VScode extension)
    - shfmt # ALE fixer for bash
  dirs:
    - { path: {{ home }}/.local/share/nvim/site/autoload }
    - { path: {{ home }}/.local/share/nvim/plugged }
    - { path: {{ home }}/.config/nvim/plugins }
    - { path: {{ home }}/.config/nvim/debug }
  dotfiles:
    - {
        src:  /srv/salt/nvim/dotfiles/init.vim,
        dest: {{ home }}/.config/nvim/init.vim,
      }
    - {
        src: /srv/salt/nvim/dotfiles/autocmds.vim,
        dest: {{ home }}/.config/nvim/autocmds.vim,
      }
    - {
        src: /srv/salt/nvim/dotfiles/plugins/vimplug.vim,
        dest: {{ home }}/.config/nvim/plugins/vimplug.vim,
      }
    - {
        src: /srv/salt/nvim/dotfiles/plugins/ale.vim,
        dest: {{ home }}/.config/nvim/plugins/ale.vim,
      }
    - {
        src: /srv/salt/nvim/dotfiles/plugins/fzf.vim,
        dest: {{ home }}/.config/nvim/plugins/fzf.vim,
      }
    - {
        src: /srv/salt/nvim/dotfiles/root_init.vim,
        dest: /root/.config/nvim/init.vim,
        user: root,
        group: root,
      }
  vim_plug_url: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim_plug_dest: {{ home }}/.local/share/nvim/site/autoload/plug.vim
