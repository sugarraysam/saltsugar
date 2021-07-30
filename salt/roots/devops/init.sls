devops_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['devops']['pkgs'] }}

devops_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['devops']['dotfiles'] }}
    - require:
      - pkg: devops_pkgs

devops_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['devops']['gh_binaries'] }}

devops_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['devops']['zsh_completions'] }}
    - require:
      - pkg: devops_pkgs
      - sugbin: devops_gh_binaries

# Remove once aws-cli package is upgraded to v2
install_aws_cli_v2:
  archive.extracted:
    - name: /tmp
    - source: {{ pillar['devops']['aws_cli_v2_url'] }}
    - skip_verify: True
    - force: True
    - overwrite: True
  cmd.run:
    - name: /bin/sh /tmp/aws/install --update
  file.absent:
    - name: /tmp/aws

install_vscode_settings_sync:
  cmd.run:
    - name: code --install-extension Shan.code-settings-sync
    - unless: code --list-extensions | grep Shan.code-settings.sync
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - sugfile: devops_symlink_dotfiles

podman_cleanup:
  cmd.run:
    - name: podman system prune --force --volumes
    - require:
      - pkg: devops_pkgs

# TODO - when oc is moved out of AUR ($ pacman -Ss origin-client)
# merge into regular zsh_completions
setup_oc_zsh_completion:
  cmd.run:
    - name: oc completion zsh > /usr/share/zsh/site-functions/_oc
    - unless: test ! -x /usr/bin/oc
