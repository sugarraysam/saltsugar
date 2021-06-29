#!/bin/bash

export KUBE="${HOME}/.kube"
export KUBECONFIG="${KUBE}/config"

# shortcut for kubectl + fix completions
alias k="kubectl"
complete -F __start_kubectl k

# set default namespace
function _setns() {
    kubectl config set-context --current --namespace="${1}"
}
alias ksetns="_setns"

# print contexts
alias kst="kubectl config get-contexts"

# use another context
alias kuse="kubectl config use-context"

function _helmDiffValues() {
    if (($# != 4)); then
        echo >&2 "${0} usage: oldChart oldVersion newChart newVersion"
        return 1
    fi
    oldChart="${1}"
    oldVersion="${2}"
    newChart="${3}"
    newVersion="${4}"
    diff --color=always <(helm show chart --version ${oldVersion} ${oldChart}) <(helm show chart --version ${newVersion} ${newChart})
}

# diff helm chart values between versions
alias helmDiffValues="_helmDiffValues"

# kind create custom cluster /w two nodes
function _kindCreate() {
    name="${1}"
    if [ -z "${name}" ]; then
        echo >&2 "Please specify a name for your cluster."
        return 1
    fi
    cat <<EOF | kind create cluster --name="${name}" --config=-
---
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
EOF
}
alias kindCreate='_kindCreate'

# delete all kind clusters
function _kindDeleteAll() {
    for c in $(kind get clusters); do
        kind delete cluster --name "${c}"
    done
}
alias kindDeleteAll='_kindDeleteAll'

# validate k8s manifest
alias kvalidate='kubectl apply --dry-run=server --validate=true -f'
