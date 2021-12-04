#!/bin/bash

function usage() {
    echo >&2 "usage ${0}: [ACTION] [STATE]"
    echo >&2 "    -> ACTION:  deploy, <action>"
    echo >&2 "    -> STATE:   highstate, <state>"
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
    echo "Installing pipenv and pacman dependencies..."
    pipenv install
    pacman -S --noconfirm --needed rsync || true
}

# Sync dynamic modules with the minions
# https://docs.saltproject.io/en/latest/ref/modules/all/salt.modules.saltutil.html#salt.modules.saltutil.sync_all
function syncDynamicModules() {
    echo "Syncing dynamic modules..."
    pipenv run salt-call --local saltutil.sync_all >/dev/null 2>&1
}

function rsyncFiles() {
    echo "Copying files to /srv/salt and /srv/pillar..."
    mkdir -p /srv/salt
    mkdir -p /srv/pillar
    cp "${PWD}/salt/minion" /etc/salt/minion
    # -a == --archive == -rlptgoD
    # -r recurse
    # -l symlinks
    # -p perms
    # -t timestamps
    # -g groups
    # -o owner
    rsync -aq --delete --exclude "*.slsc" "${PWD}/salt/roots/." /srv/salt
    rsync -aq --delete --exclude "*.slsc" "${PWD}/salt/pillars/." /srv/pillar
}

function applyState() {
    state="${1}"
    echo "Running state ${state}..."

    if [ "${state}" == "highstate" ]; then
        # run a highstate
        pipenv run salt-call --local state.apply
    else
        pipenv run salt-call --local state.apply "${state}"
    fi
}

###
### Run
###
checkIsRoot
pip install --upgrade pipenv

if [ "$#" -eq 0 ]; then
    action="${ACTION:-deploy}"
    state="${STATE:-highstate}"
elif [ "$#" -eq 2 ]; then
    action="${1}"
    state="${2}"
else
    usage
fi

installDeps
rsyncFiles

if [ "${action}" == "deploy" ]; then
    syncDynamicModules
    applyState "${state}"
fi

# Need to clean pipenv cache and virtualenv cache because many files become
# owned by the root user after running this script
rm -fr ${HOME}/.cache/pipenv
rm -fr ${HOME}/.local/share/virtualenv
