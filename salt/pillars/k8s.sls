{% set home = grains['sugar']['home'] %}

k8s:
  pkgs:
    - eksctl # Command line tool for creating clusters on Amazon EKS
    - helm # The Kubernetes Package Manager
    - kubectl # Kubernetes.io client binary
    - kubeseal # A Kubernetes controller and tool for one-way encrypted Secrets
    - kustomize # Template-free customization of Kubernetes YAML manifests
    - k9s # TUI for managing Kubernetes clusters and pods
    - operator-sdk # SDK for building Kubernetes applications
  dotfiles:
    # Needs to be .yml, .yaml fails
    - {
        src: /srv/salt/k8s/dotfiles/k9s_skin.yml,
        dest: {{ home }}/.config/k9s/skin.yml,
      }
    - {
        src: /srv/salt/k8s/dotfiles/k8s.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/k8s.sh,
      }
  zsh_completions:
    - "eksctl completion zsh > /usr/share/zsh/site-functions/_eksctl"
    - "helm completion zsh > /usr/share/zsh/site-functions/_helm"
    - "kind completion zsh > /usr/share/zsh/site-functions/_kind"
    - "kubebuilder completion zsh > /usr/share/zsh/site-functions/_kubebuilder"
    - "kubectl completion zsh > /usr/share/zsh/site-functions/_kubectl"
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
    - { name: jetstack, url: "https://charts.jetstack.io" }
  github_releases:
    - {
        repo: "kubernetes-sigs/kind",
        urlfmt: "https://github.com/kubernetes-sigs/kind/releases/download/{tag}/kind-linux-amd64",
      }
    - {
        repo: "GoogleContainerTools/skaffold",
        urlfmt: "https://github.com/GoogleContainerTools/skaffold/releases/download/{tag}/skaffold-linux-amd64",
      }
    - {
        repo: "kubernetes-sigs/krew",
        urlfmt: "https://github.com/kubernetes-sigs/krew/releases/download/{tag}/krew-linux_amd64.tar.gz",
      }
    - {
        repo: "kubernetes-sigs/kubebuilder",
        urlfmt: "https://github.com/kubernetes-sigs/kubebuilder/releases/download/{tag}/kubebuilder_linux_amd64",
      }
  nf_conntrack_max: 393216
  krew_plugins:
    - default/tree
    - default/whoami
    - default/get-all
