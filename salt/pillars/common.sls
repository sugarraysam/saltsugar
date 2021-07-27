{% set home = grains['sugar']['home'] %}

common:
  pkgs:
    - arch-install-scripts # Scripts to aid in installing Arch Linux (genfstab, pacstrap, arch-chroot)
    - asp # Arch Linux build source file management tool (retrieve PKGBUILD)
    - bat # Cat clone with syntax highlighting and git integration
    - calibre # Ebook management application (experimental python3 port)
    - cdrtools # Original cdrtools supporting CD, DVD and BluRay burning (provides mkisofs)
    - chromium # A web browser built for speed, simplicity, and security
    - cowsay # Configurable talking cow (and a few other creatures)
    - dkms # Dynamic Kernel Modules System
    - fd # Simple, fast and user-friendly alternative to find (written in Rust)
    - feh # Fast and light imlib2-based image viewer
    - firefox # Standalone web browser from mozilla.org
    - fwupd # Simple daemon to allow session software to update firmware
    - fzf # Command-line fuzzy finder
    - git # the fast distributed version control system
    - gnupg # Complete and free implementation of the OpenPGP
    - gopass # The slightly more awesome standard unix password manager for teams
    - htop # Interactive process viewer
    - httpie # cURL for humans
    - jq # Command-line JSON processor
    - keychain # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    - ldns # Fast DNS library supporting recent RFCs (provides 'drill')
    - libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
    - lsd # Modern ls with a lot of pretty colors and awesome icons (written in Rust)
    - lsof # Lists open files for running Unix processes
    - ltrace # Tracks runtime library calls in dynamically linked programs
    - namcap # A Pacman package analyzer
    - networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN
    - nmap # Utility for network discovery and security auditing
    - okular # Document Viewer (pdf)
    - openvpn # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
    - pandoc # Conversion between markup formats
    - parallel # A shell tool for executing jobs in parallel
    - pinentry # Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol
    - ripgrep # A search tool that combines the usability of ag with the raw speed of grep
    - squashfs-tools # Tools for squashfs, a highly compressed read-only filesystem for Linux
    - strace # A diagnostic, debugging and instructional userspace tracer
    - tigervnc # Suite of VNC servers and clients. Based on the VNC 4 branch of TightVNC.
    - tldr # Command line client for tldr, a collection of simplified and community-driven man pages
    - tldr # Command line client for tldr, a collection of simplified and community-driven man pages.
    - traceroute # Tracks the route taken by packets over an IP network
    - tree # A directory listing program displaying a depth indented list of files
    - unzip # For extracting and viewing files in .zip archives
    - usbutils # USB Device Utilities (provides 'lsusb')
    - util-linux # Miscellaneous system utilities for Linux (lsblk, rfkill, etc.)
    - vlc # Multi-platform MPEG, VCD/DVD, and DivX player
    - wireshark-cli # Network traffic and protocol analyzer/sniffer - CLI tools and data files
    - wireshark-qt # Network traffic and protocol analyzer/sniffer - Qt GUI
    - xournalpp # Handwriting notetaking software with PDF annotation support
    - yq # Command-line YAML/XML processor - jq wrapper for YAML/XML documents
    - zip # Compressor/archiver for creating and modifying zipfiles
  dirs:
    - { path: {{ home }}/opt }
    - { path: {{ home }}/dwl }
    - { path: {{ home }}/perso }
    - { path: {{ home }}/geek/test }
    - { path: {{ home }}/.backup/files }
    - { path: {{ home }}/.gnupg, mode: "0700" }
    - { path: {{ home }}/.cache }
    - { path: /etc/systemd/system/getty@tty1.service.d, user: root, group: root }
  dotfiles:
    - {
        src: /srv/salt/common/dotfiles/bible,
        dest: {{ home }}/geek/bible,
      }
    - {
        src: /srv/salt/common/dotfiles/gpg-agent.conf,
        dest: {{ home }}/.gnupg/gpg-agent.conf,
      }
    - {
        src: /srv/salt/common/dotfiles/gopass-config.yml,
        dest: {{ home }}/.config/gopass/config.yml,
      }
    - {
        src: /usr/bin/pinentry-curses,
        dest: /usr/bin/pinentry,
        user: root,
        group: root,
      }
    - {
        src: /srv/salt/common/dotfiles/catsay,
        dest: {{ grains['sugar']['localbin_path'] }}/catsay,
        mode: "0755",
      }
    - {
        src: /srv/salt/common/dotfiles/pacman.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/pacman.sh,
      }
    - {
        src: /srv/salt/common/dotfiles/general.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/general.sh,
      }
    - {
        src: /srv/salt/common/dotfiles/systemd.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/systemd.sh,
      }
    - {
        src: /srv/salt/common/dotfiles/gopass.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/gopass.sh,
      }
    - {
        src: /srv/salt/common/dotfiles/git.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/git.sh,
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
  groups:
    - uucp
    - wheel
    - wireshark
