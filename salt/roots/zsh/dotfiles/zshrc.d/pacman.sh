#!/bin/bash

###
### Functions
###
function _pacSearchPreviewInstall() {
    pacman -Slq |
        fzf --preview='pacman -Si {1}; echo -e \"\nInstalled version of package:\n\t\"; pacman -Q {1};' \
            --preview-window=right:70%:wrap |
        xargs -r sudo pacman -S --noconfirm
}

function _pacSearchPreviewRemove() {
    pacman -Qq |
        fzf --preview='pacman -Qi {1}' \
            --preview-window=right:70%:wrap |
        xargs -r sudo pacman -Rns --noconfirm
}

###
### Aliases
###
# Search remote pacman packages, preview description && install on ENTER
alias pacins='_pacSearchPreviewInstall'

# Search local pacman packages, preview description && remove on ENTER
alias pacrem='_pacSearchPreviewRemove'

# list local orphan pacman packages
alias pacLsOrphans='sudo pacman -Qdt'

# remove local orphan pacman packages
alias pacRmOrphans='sudo pacman -Rns $(pacman -Qtdq)'
