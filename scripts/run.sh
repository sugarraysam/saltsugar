#!/bin/bash

function usage() {
    echo >&2 "usage ${0}: [STATE]"
    echo >&2 "    -> STATE:  highstate, <state>"
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
    cp "${PWD}/salt/minion" /etc/salt/minion
    rsync -aq --no-owner --no-group --no-perms --chmod=ugo=rwX --copy-unsafe-links --delete \
        --exclude "*.slsc" "${PWD}/salt/roots/." /srv/salt
    rsync -aq --no-owner --no-group --no-perms --chmod=ugo=rwX --copy-unsafe-links --delete \
        --exclude "*.slsc" "${PWD}/salt/pillars/." /srv/pillar
}

function applyState() {
    state="${1}"
    echo "Running state ${state}..."

    if [ "${state}" == "highstate" ]; then
        # run a highstate
        salt-call --local state.apply
    else
        salt-call --local state.apply "${state}"
    fi
}

###
### Run
###
checkIsRoot

if [ "$#" -eq 0 ]; then
    state="${STATE:-highstate}"
elif [ "$#" -eq 1 ]; then
    state="${1}"
else
    usage
fi

installDeps
rsyncFiles
syncDynamicModules
applyState "${state}"
