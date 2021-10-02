#!/usr/bin/env bash

# Install make so we can run `$ make bootstrap`
pacman -Sy --noconfirm
pacman -q -S --noconfirm --needed make

# Setup ssh server so packer can connect to VM
echo root:vagrant | chpasswd
systemctl --now enable sshd.service
