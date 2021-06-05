#!/bin/bash

set -e

if pacman -Qtdq; then
    pacman -Rns --noconfirm $(pacman -Qtdq)
fi
