#!/bin/bash

set -x
set -e

###
### Functions
###
# We need to setup initramfs before bootloader to avoid potential mistakes
function setupInitramfs() {
    echo "Setting up initramfs..."
    if grep -i intel /proc/cpuinfo; then
        pacman -q -S --noconfirm --needed intel-ucode
        export CPU_MANUFACTURER=intel
    else
        pacman -q -S --noconfirm --needed amd-ucode
        export CPU_MANUFACTURER=amd
    fi
    hooks="base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck"
    sed -i "s/^HOOKS=.*/HOOKS=(${hooks})" /etc/mkinitcpio.conf
    mkinitcpio -P
}

###
### Run
###
setupInitramfs
#bootloader
