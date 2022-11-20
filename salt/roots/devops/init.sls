devops_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['devops']['pkgs'] }}

devops_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['devops']['dotfiles'] }}
    - require:
      - pkg: devops_pkgs

devops_github_releases:
  sugbin.download_github_releases:
    - releases: {{ pillar['devops']['github_releases'] }}

devops_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['devops']['zsh_completions'] }}
    - require:
      - pkg: devops_pkgs
      - sugbin: devops_github_releases

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
