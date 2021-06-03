#!/bin/bash

# nvim shortcuts
alias vi="nvim" vim="nvim"

# sudo shortcuts
alias svi="sudo nvim" svim="sudo nvim"

# remove swap files
alias nvimRmCache='rm -fr ~/.local/share/nvim/swap/'

# $ nvim_convert_to_pdf FILE -- create a pdf from FILE
alias nvimConvertToPdf='f(){ nvim +"hardcopy > out.ps" $1 +qall && ps2pdf out.ps ${1/.*/.pdf} && rm out.ps;};f'
