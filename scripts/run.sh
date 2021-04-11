#!/bin/bash

function usage() {
    echo >&2 "usage ${0}: (sandbox | prod) STATE"
    echo >&2 "Exiting."
    exit 1
}

function checkIsRoot() {
    if [ "${EUID}" -ne 0 ]; then
        echo >&2 "Please run with sudo/root privileges."
        exit 1
    fi
}

function installDeps() {
    echo "Installing pacman dependencies..."
    pkgs=(
        rsync
        salt
    )
    for p in "${pkgs[@]}"; do
        if [ ! -x "$(which ${p})" ]; then
            pacman -S --noconfirm "${p}"
        fi
    done
}

# Sync dynamic modules with the minions
# https://docs.saltproject.io/en/latest/ref/modules/all/salt.modules.saltutil.html#salt.modules.saltutil.sync_all
function syncDynamicModules() {
    echo "Syncing dynamic modules..."
    salt-call --local saltutil.sync_all >/dev/null 2>&1
}

function rsyncFiles() {
    echo "Copying files to /srv/salt and /srv/pillar..."
    mkdir -p /srv/salt
    mkdir -p /srv/pillar
    cp salt/minion /etc/salt/minion
    rsync -aq --no-owner --no-group --no-perms --chmod=ugo=rwX --copy-unsafe-links --delete \
        --exclude "*.slsc" "${PWD}/salt/roots/." /srv/salt
    rsync -aq --no-owner --no-group --no-perms --chmod=ugo=rwX --copy-unsafe-links --delete \
        --exclude "*.slsc" "${PWD}/salt/pillars/." /srv/pillar
}

###
### Run
###
checkIsRoot
if [ "$#" -eq 2 ]; then
    env="${1}"
    state="${2}"
else
    usage
fi

installDeps
[[ "${env}" == "prod" ]] && rsyncFiles

syncDynamicModules

if [ "${state}" == "highstate" ]; then
    # run a highstate
    salt-call --local state.apply
else
    salt-call --local state.apply "${state}"
fi
