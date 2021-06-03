#!/bin/bash

###
### Functions
###
function _fzfSearchAliases() {
    # Thanks to https://stackoverflow.com/questions/1279953/how-to-execute-the-output-of-a-command-within-the-current-shell
    # for the "source /dev/stdin" trick :D
    grep --no-filename '^alias' ~/.aliases/* |
        fzf --preview='grep --no-filename --before-context=1 {} ~/.aliases/*' \
            --preview-window=down |
        cut -d= -f2 | source /dev/stdin
}

function _fzfSearchProcesses() {
    ps aux |
        sudo fzf --preview='lsof -p {2}' \
            --preview-window=bottom |
        awk '{print $2}' | xargs -r kill -9
}

_fzf_my_linux_bible() {
    grep '^#' ~/geek/bible |
        fzf --preview='grep {} -A1 ~/geek/bible | bat --color=always' \
            --preview-window=bottom
}

_fzf_tldr() {
    # TODO give some love
    cd $HOME/.local/share/tldr/pages && fd . --type file \
        --exclude 'sunos' --exclude 'osx' --exclude 'windows' | fzf --preview='bat {} --color=always'
}

_fzf_env() {
    # TODO unset var on enter
    env | fzf
}

_fzf_locate() {
    file="$1"
    if [ -z "${file}" ]; then
        _err_msg "_fzf_locate() requires a file argument"
    else
        sudo locate ${file} |
            fzf --preview="bat {} --color=always"
    fi
}

_fzf_ansible_modules() {
    ansible-doc -t module -l | cut -d" " -f1 |
        fzf --preview="ansible-doc -t module {1}"
}

_fzf_ansible_lookup_plugins() {
    ansible-doc -t lookup -l | cut -d" " -f1 |
        fzf --preview="ansible-doc -t lookup {1}"
}

_fzf_ansible_lint() {
    ansible-lint -L | grep "^[0-9]" |
        fzf --preview="ansible-lint -L | grep -A1 {1}"
}

###
### Aliases
###
# Search aliases, show description && execute on ENTER
alias fzfa=_fzfSearchAliases

# Search processes, list their open files with lsof && kill on ENTER
alias fzfps=_fzfSearchProcesses

# Search through my favorite linux commands && execute on ENTER
alias fzfbible=_fzf_my_linux_bible

# Search environment && unset var on ENTER
alias fzfenv=_fzf_env

# Search i3 bindings
alias fzfi3="rg ^bindsym ~/.config/i3/config | fzf"
# Search tldr local commands
alias fzftldr=_fzf_tldr
# Search tmux bindings
alias fzftmux="tmux list-keys | fzf"
# Locate "$1" /w preview
alias fzfloc=_fzf_locate
# Search ansible module plugins /w ansible-doc
alias fzfansmod=_fzf_ansible_modules
# Search ansible lookup plugins /w ansible-doc
alias fzfanslook=_fzf_ansible_lookup_plugins
# Search ansible lint rules
alias fzfanslint=_fzf_ansible_lint
# Search for godoc documentation in fzf, while viewing full source code in preview window
# TODO add command to search inside preview window, page down, page up
alias fzfgodoc="go list '...' | fzf --preview='go doc -all -src {} | bat -l go --color=always'"
# TODO review regex and preview command
alias fzfman="ls --color=never /usr/share/man/man{0..9} | \
    grep -o '^([[:alnum:]]+|[[:alnum:]]+\.[[:alpha:]]{1,3})' \
    |fzf --preview='apropos {..}'"
