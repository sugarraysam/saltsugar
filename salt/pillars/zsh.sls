# vi: set ft=sls :
{% set home = grains['sugar']['user_home'] %}

zsh:
  pkgs:
    - fzf # Command-line fuzzy finder
    - powerline-fonts # patched fonts for powerline (required for ohmyzsh themes)
    - zsh # A very advanced and programmable command interpreter (shell) for UNIX
  dotfiles:
    - {
        src: /srv/salt/zsh/dotfiles/zshrc,
        dest: {{ home }}/.zshrc,
      }
    - {
        src: /srv/salt/zsh/dotfiles/zprofile,
        dest: {{ home }}/.zprofile,
      }
  git_repos:
    - {
        name: oh-my-zsh,
        url: "https://github.com/robbyrussell/oh-my-zsh.git",
        dest: {{ home }}/.oh-my-zsh,
      }
    - {
        name: zsh-autosuggestions,
        url: "https://github.com/zsh-users/zsh-autosuggestions",
        dest: {{ home }}/.oh-my-zsh/custom/plugins/zsh-autosuggestions,
      }
  etc_passwd_line: "{{ grains['sugar']['user'] }}:x:1000:1000::{{ home }}:/usr/bin/zsh"
  zshrcd_src: /srv/salt/zsh/dotfiles/zshrc.d
  direnv_url: https://direnv.net/install.sh
