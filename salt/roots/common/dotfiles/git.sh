#!/bin/bash

# list branches verbose
alias gba='git branch --list'

# commit without adding everything
alias gcm="git commit -m"

# commit history short /w signed commit
alias glg='git log --pretty="format:%h %G? %aN  %s"'

# commit history more details
alias glgLong="git log --stat"

# list all tracked files in repo
alias gitLsTracked="git ls-tree --full-tree -r --name-only HEAD"

# list untracked files in repo
alias gitLsUntracked="git ls-files . --exclude-standard --others"

# what commit added file?
alias gitWhatAdded="git log --follow --diff-filter=A"

# view last version of file
alias gitPreviousVersion='f(){ git show HEAD~1:$1};f'

# diff all files in directory, recursively, with master
function _gitDiffMaster() {
    out=$(mktemp)
    for f in $(find . -type f); do
        git diff master:${f} ${f} >>${out}
    done
    bat ${out}
}
alias gitDiffMaster=_gitDiffMaster

# delete old branch from local and remote repo
function _gitPurgeBranch() {
    branch="${1}"
    git branch -D ${branch}
    git push origin :${branch}
}
alias gitPurgeBranch=_gitPurgeBranch
