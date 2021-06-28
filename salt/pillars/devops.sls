{% set home = grains['sugar']['user_home'] %}

devops:
  pkgs:
    - aws-cli # Universal Command Line Interface for Amazon Web Services
    - buildah # A tool which facilitates building OCI images
    - clang # C language family frontend for LLVM (provides 'clang-format' required by proto plugin)
    - code # The Open Source build of Visual Studio Code (vscode) editor
    - github-cli # The github CLI
    - openldap # Lightweight Directory Access Protocol (LDAP) client and server
    - packer # tool for creating identical machine images for multiple platforms from a single source configuration
    - podman # Tool and library for running OCI-based containers in pods
    - protobuf # Protocol Buffers - Google's data interchange format (required by proto plugin)
    - skopeo # A command line utility for various operations on container images and image repositories.
    - sshuttle # Transparent proxy server that forwards all TCP packets over ssh
    - vagrant # Build and distribute virtualized development environments
  dirs:
    - { path: {{ home }}/.local/share/nvim/site/autoload }
    - { path: {{ home }}/.local/share/nvim/plugged }
    - { path: {{ home }}/.config/nvim/plugins }
    - { path: {{ home }}/.config/nvim/debug }
  gh_binaries:
    - {
        repo: "operator-framework/operator-registry",
        urlfmt: "https://github.com/operator-framework/operator-registry/releases/download/{tag}/linux-amd64-opm",
      }
  dotfiles:
    - {
        src: /srv/salt/devops/dotfiles/vscode/settings.json,
        dest: "{{ home }}/.config/Code - OSS/User/settings.json",
      }
    - {
        src: /srv/salt/devops/dotfiles/vscode/keybindings.json,
        dest: "{{ home }}/.config/Code - OSS/User/keybindings.json",
      }
    - {
        src: /srv/salt/devops/dotfiles/devops.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/devops.sh,
      }
  zsh_completions:
    - "gh completion -s zsh > /usr/share/zsh/site-functions/_gh"
  aws_cli_v2_url: https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
