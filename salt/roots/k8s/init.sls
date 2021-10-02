k8s_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['k8s']['pkgs'] }}

k8s_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['k8s']['dotfiles'] }}

k8s_github_releases:
  sugbin.download_github_releases:
    - releases: {{ pillar['k8s']['github_releases'] }}

k8s_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['k8s']['zsh_completions'] }}
    - require:
      - pkg: k8s_pkgs
      - sugbin: k8s_github_releases

# Install helm repos
{% for r in pillar['k8s']['helm_repositories'] %}
helm_repo_{{ r.name }}:
  cmd.run:
    - name: "helm repo add {{ r.name }} {{ r.url }}"
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: k8s_pkgs
{% endfor %}

update_helm_repos:
  cmd.run:
    - name: "helm repo update"
    - runas: {{ grains['sugar']['user'] }}

kind_sysctl_kube_proxy:
  sysctl.present:
    - name: net.nf_conntrack_max
    - value: {{ pillar['k8s']['nf_conntrack_max'] }}

k8s_krew_mgmt:
  cmd.run:
    - name: |
        krew update
        krew upgrade
        krew install {{ ' '.join(pillar['k8s']['krew_plugins']) }}
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - PATH: "{{ salt['environ.get']('PATH') }}:{{ grains['sugar']['extra_path'] }}"
    - require:
      - pkg: k8s_pkgs
      - sugbin: k8s_github_releases
