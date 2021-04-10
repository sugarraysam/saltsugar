common:
  pkgs:
    - git # the fast distributed version control system
    - gnupg # Complete and free implementation of the OpenPGP
    - gopass # The slightly more awesome standard unix password manager for teams
    - keychain # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    - pinentry # Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol
    - shellcheck # Shell script analysis tool (required by VScode extension)
    - shfmt # Format shell programs (required by VScode extension)
  dirs_to_create_user:
    - {{ grains['defaults']['user_home'] }}/opt
    - {{ grains['defaults']['user_home'] }}/dwl
    - {{ grains['defaults']['user_home'] }}/perso
    - {{ grains['defaults']['user_home'] }}/geek/test
    - {{ grains['defaults']['user_home'] }}/.local/bin
    - {{ grains['defaults']['user_home'] }}/.backup/files
    - {{ grains['defaults']['user_home'] }}/.gnupg
  dirs_to_create_root:
    - /etc/systemd/system/getty@tty1.service.d
  dotfiles_user:
    - {
        src: "salt://common/dotfiles/user/bible",
        dest: {{ grains['defaults']['user_home'] }}/geek/bible,
      }
    - {
        src: "salt://common/dotfiles/user/gpg-agent.conf",
        dest: {{ grains['defaults']['user_home'] }}/.gnupg/gpg-agent.conf,
      }
    - {
        src: "salt://common/dotfiles/user/gopass-config.yml",
        dest: {{ grains['defaults']['user_home'] }}/.config/gopass/config.yml,
      }
    - {
        src: "salt://common/dotfiles/user/ssh_config",
        dest: {{ grains['defaults']['user_home'] }}/.ssh/config,
      }
  # TODO, just a symlink..not a dotfile
  dotfiles_root:
    - {
        src: /usr/bin/pinentry-curses,
        dest: /usr/bin/pinentry
      }
  files_to_remove:
    - {{ grains['defaults']['user_home'] }}/.bash_logout
    - {{ grains['defaults']['user_home'] }}/.bash_profile
    - {{ grains['defaults']['user_home'] }}/.bashrc
    - {{ grains['defaults']['user_home'] }}/Desktop
  zsh_completions:
    - {
        cmd: "gopass completion zsh",
        dest: "_gopass"
      }
