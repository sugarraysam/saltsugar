#!/bin/bash

export PIPENV_VENV_IN_PROJECT=1
export PYENV_SHELL=zsh

# Pipenv shell completion
eval "$(pipenv --completion)"

# pyenv config custom command
command pyenv rehash 2>/dev/null
pyenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
    rehash | shell)
        eval "$(pyenv "sh-$command" "$@")"
        ;;
    *)
        command pyenv "$command" "$@"
        ;;
    esac
}
