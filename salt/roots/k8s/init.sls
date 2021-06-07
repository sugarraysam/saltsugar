k8s_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['k8s']['pkgs'] }}

k8s_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['k8s']['dotfiles'] }}

k8s_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['k8s']['zsh_completions'] }}
    - require:
      - pkg: k8s_pkgs

k8s_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['k8s']['gh_binaries'] }}

# Install helm repos
{% for r in pillar['k8s']['helm_repositories'] %}
helm_repo_{{ r.name }}:
  cmd.run:
    - name: "helm repo add {{ r.name }} {{ r.url }}"
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: k8s_pkgs
    - onchanges_in:
      - cmd: update_helm_repos
{% endfor %}

update_helm_repos:
  cmd.run:
    - name: "helm repo update"
    - runas: {{ grains['sugar']['user'] }}
