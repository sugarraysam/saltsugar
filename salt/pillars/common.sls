{% set home = grains['sugar']['user_home'] %}

common:
  pkgs:
    - git # the fast distributed version control system
    - gnupg # Complete and free implementation of the OpenPGP
    - gopass # The slightly more awesome standard unix password manager for teams
    - keychain # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    - pinentry # Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol
    - shellcheck # Shell script analysis tool (required by VScode extension)
    - shfmt # Format shell programs (required by VScode extension)
    - tldr # Command line client for tldr, a collection of simplified and community-driven man pages.
  dirs:
    - { path: {{ home }}/opt }
    - { path: {{ home }}/dwl }
    - { path: {{ home }}/perso }
    - { path: {{ home }}/geek/test }
    - { path: {{ home }}/.local/bin }
    - { path: {{ home }}/.backup/files }
    - { path: {{ home }}/.gnupg, mode: 0700 }
    - { path: /etc/systemd/system/getty@tty1.service.d, user: root, group: root }
  dotfiles:
    - {
        src: /srv/salt/common/dotfiles/user/bible,
        dest: {{ home }}/geek/bible,
      }
    - {
        src: /srv/salt/common/dotfiles/user/gpg-agent.conf,
        dest: {{ home }}/.gnupg/gpg-agent.conf,
      }
    - {
        src: /srv/salt/common/dotfiles/user/gopass-config.yml,
        dest: {{ home }}/.config/gopass/config.yml,
      }
    - {
        src: /srv/salt/common/dotfiles/user/ssh_config,
        dest: {{ home }}/.ssh/config,
      }
    - {
        src: /usr/bin/pinentry-curses,
        dest: /usr/bin/pinentry,
        user: root,
        group: root,
      }
  files_to_remove:
    - {{ home }}/.bash_logout
    - {{ home }}/.bash_profile
    - {{ home }}/.bashrc
    - {{ home }}/Desktop
  zsh_completions:
    - "gopass completion zsh > /usr/share/zsh/site-functions/_gopass"
  systemd_cmd:
    - "timedatectl set-timezone {{ grains['sugar']['timezone'] }}"
    - "timedatectl set-ntp true"
    - "hostnamectl set-hostname {{ grains['sugar']['hostname'] }}"
    - "localectl set-keymap {{ grains['sugar']['keymap'] }}"
  git_configs:
    - { name: user.name, value: {{ grains['sugar']['git_username'] }} }
    - { name: user.email, value: {{ grains['sugar']['git_email'] }} }
    - { name: merge.conflictstyle, value: diff3 }
    - { name: branch.autosetuprebase, value: always }
    - { name: advice.addIgnoredFile, value: false }
    - { name: pull.rebase, value: false }
