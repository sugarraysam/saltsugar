#!/bin/bash

export KUBE="${HOME}/.kube"
export KUBECONFIG="${KUBE}/cov:${KUBE}/config"

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

# kind create custom cluster using ~/.kube/kind-config.yaml
function _kindCreate() {
    kind create cluster --name="${1}" --config="${HOME}/.kube/kind-config.yaml"
}
alias kindCreate='_kindCreate'
