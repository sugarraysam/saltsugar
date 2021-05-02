include:
  - .base

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


# TODO install binaries from GH
# TODO install kubebuilder
