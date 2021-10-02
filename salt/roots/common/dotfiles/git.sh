#!/bin/bash

# git fetch --all
alias gfa='git fetch --all'

# git push --force-with-lease
alias gpfwl='git push --force-with-lease'

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

# diff single file with version in branch
function _gitDiffFile() {
    file="${1}"
    branch="${2}"

    if [[ -z "${file}" ]] || [[ -z "${branch}" ]]; then
        echo >&2 "usage: gitDiffFile file branch"
        echo >&2 "  - file:     file to diff"
        echo >&2 "  - branch:   compare file with version on this branch"
        return 1
    fi
    git diff ${branch}:${file} ${file}
}
alias gitDiffFile=_gitDiffFile

# delete old branch from local and remote repo
function _gitPurgeBranch() {
    branch="${1}"
    git branch -D ${branch}
    git push origin :${branch}
}
alias gitPurgeBranch=_gitPurgeBranch

# update upstream for fork project
function _updateUpstream() {
    if ! git remote | grep upstream >/dev/null 2>&1; then
        echo >&2 "No 'upstream' remote in repository. Exiting."
        return 1
    fi
    git fetch upstream

    for branch in master main; do
        if git rev-parse --quiet --verify "${branch}"; then
            git rebase upstream/"${branch}"
            break
        fi
    done
}
alias gitUpdateUpstream="_updateUpstream"
