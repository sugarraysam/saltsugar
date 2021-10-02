" General
set ignorecase

" Change colorscheme
colorscheme desert

" Highlight column past 80 characters
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Displaying text
set number              "show line numbers
set relativenumber      "show current line number and relative
set lazyredraw

" Tabs and indenting
set tabstop=4
set shiftwidth=4
"set softtabstop=2
set expandtab
set smartindent

" Mapping key to commands
" lire tuto: http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_%28Part_1%29
