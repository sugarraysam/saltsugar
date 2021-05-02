{% set home = grains['sugar']['user_home'] %}

k8s:
  pkgs:
    - eksctl # Command line tool for creating clusters on Amazon EKS
    - helm # The Kubernetes Package Manager
    - kubectl # Kubernetes.io client binary
    - kubeseal # A Kubernetes controller and tool for one-way encrypted Secrets
    - kustomize # Template-free customization of Kubernetes YAML manifests
    - k9s # TUI for managing Kubernetes clusters and pods
    - operator-sdk # SDK for building Kubernetes applications
  # Defaults:
  # - user: pillar['sugar']['user']
  # - group: pillar['sugar']['user']
  # - mode: 0755
  dirs:
    - { path: {{ home }}/.kube }
  zsh_completions:
    - "helm completion zsh > /usr/share/zsh/site-functions/_helm"
    - "kubectl completion zsh > /usr/share/zsh/site-functions/_kubectl"
    - "eksctl completion zsh > /usr/share/zsh/site-functions/_eksctl"
  helm_repositories:
    - { name: stable, url: "https://charts.helm.sh/stable" }
    - { name: bitnami, url: "https://charts.bitnami.com/bitnami" }
    - { name: k8s-at-home, url: "https://k8s-at-home.com/charts/" }
    - { name: hashicorp, url: "https://helm.releases.hashicorp.com" }
    - { name: sealed-secrets, url: "https://bitnami-labs.github.io/sealed-secrets" }
    - { name: grafana, url: "https://grafana.github.io/helm-charts" }
    - { name: influxdata, url: "https://helm.influxdata.com/" }
    - { name: ingress-nginx, url: "https://kubernetes.github.io/ingress-nginx" }
    - { name: prometheus-community, url: "https://prometheus-community.github.io/helm-charts" }
