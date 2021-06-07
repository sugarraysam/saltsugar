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
  dotfiles:
    - {
        src: /srv/salt/k8s/dotfiles/kind-config.yaml,
        dest: {{ home }}/.kube/kind-config.yaml,
      }
  zsh_completions:
    - "eksctl completion zsh > /usr/share/zsh/site-functions/_eksctl"
    - "helm completion zsh > /usr/share/zsh/site-functions/_helm"
    - "kind completion zsh > /usr/share/zsh/site-functions/_kind"
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
  gh_binaries:
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
        urlfmt: "https://github.com/kubernetes-sigs/krew/releases/download/{tag}/krew.tar.gz",
      }
    - {
        repo: "kubernetes-sigs/kubebuilder",
        urlfmt: "https://github.com/kubernetes-sigs/kubebuilder/releases/download/{tag}/kubebuilder_linux_amd64",
      }
