" Make sure you use single quotes
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" asynchronous lint engine && LSP client
Plug 'dense-analysis/ale'

" fzf
Plug 'junegunn/fzf.vim'

" More colorscheme options
"Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

" handy vim shortcuts & linux commands
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'

" easy commenting
Plug 'scrooloose/nerdcommenter'

" status line
Plug 'vim-airline/vim-airline'

" switch pane seemlessly /w Tmux
Plug 'christoomey/vim-tmux-navigator'

"align stuff nicely
Plug 'godlygeek/tabular'

" toml syntax support
Plug 'cespare/vim-toml'

" hcl HashiCorp Configuration Language
Plug 'jvirtanen/vim-hcl'

" saltstack edit .sls files
Plug 'saltstack/salt-vim'

" Initialize plugin system
call plug#end()
