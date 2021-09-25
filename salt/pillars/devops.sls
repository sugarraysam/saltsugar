{% set home = grains['sugar']['home'] %}

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
    - sqlite # A C library that implements an SQL database engine
    - sshuttle # Transparent proxy server that forwards all TCP packets over ssh
    - tekton-cli # CLI for interacting with the Tekton CI/CD pipeline
    - terraform # HashiCorp tool for building and updating infrastructure as code idempotently
    - vagrant # Build and distribute virtualized development environments
  dirs:
    - { path: {{ home }}/.local/share/nvim/site/autoload }
    - { path: {{ home }}/.local/share/nvim/plugged }
    - { path: {{ home }}/.config/nvim/plugins }
    - { path: {{ home }}/.config/nvim/debug }
  gh_binaries:
    - {
        repo: operator-framework/operator-registry,
        urlfmt: "https://github.com/operator-framework/operator-registry/releases/download/{tag}/linux-amd64-opm",
        dest: {{ grains['sugar']['localbin_path'] }}/opm,
      }
    - {
        repo: bazelbuild/buildtools,
        urlfmt: "https://github.com/bazelbuild/buildtools/releases/download/{tag}/buildifier-linux-amd64",
        dest: {{ grains['sugar']['localbin_path'] }}/buildifier,
      }
    - {
        repo: bazelbuild/buildtools,
        urlfmt: "https://github.com/bazelbuild/buildtools/releases/download/{tag}/buildozer-linux-amd64",
        dest: {{ grains['sugar']['localbin_path'] }}/buildozer,
      }
    # Use bazelisk as bazel, as it will pull and manage versions of bazel
    - {
        repo: bazelbuild/bazelisk,
        urlfmt: "https://github.com/bazelbuild/bazelisk/releases/download/{tag}/bazelisk-linux-amd64",
        dest: {{ grains['sugar']['localbin_path'] }}/bazel,
      }
    - {
        repo: profclems/glab,
        urlfmt: "https://github.com/profclems/glab/releases/download/{tag}/glab_{tag_no_v}_Linux_i386.tar.gz",
      }
    - {
        repo: slok/sloth,
        urlfmt: "https://github.com/slok/sloth/releases/download/{tag}/sloth-linux-amd64"
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
  zsh_completions:
    - "gh completion -s zsh > /usr/share/zsh/site-functions/_gh"
    - "glab completion -s zsh > /usr/share/zsh/site-functions/_glab"
    - "tkn completion zsh > /usr/share/zsh/site-functions/_tkn"
  aws_cli_v2_url: https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
