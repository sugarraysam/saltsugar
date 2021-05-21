"""
""" General
"""
" ignore case when searching
set ignorecase

" Figure out the system Python for Neovim.
let g:python3_host_prog='/usr/bin/python3'

" prevent local .nvimrc or .exrc from executing dangerous commands
set secure

" show line numbers
set number

" Tabs and indentation
set tabstop=4
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4   "Indent by 4 spaces when pressing <TAB>
set expandtab       "Use softtabstop spaces instead of tab characters for indentation
set smartindent     "Automatically inserts indentation in some cases

" Buffers
set bufhidden=delete    " Automatically remove a buffer when not in a visible tab


"""
""" Mappings
"""
" set leader key
let mapleader = ","

" source $MYVIMRC
nnoremap ,<C-s> :so $MYVIMRC<CR>

" remap copy to Ctrl+C
vnoremap <C-c> "+y

" keep text highlighted after '>' or '<'
vnoremap < <gv
vnoremap > >gv


"""
""" Plugins
"""
" Source external plugins configuration
" Minpac always first entry
let plugins = [
            \    'vimplug',
            \    'ale',
            \    'fzf',
            \ ]
for f in plugins
    exe "source" . $HOME . "/.config/nvim/plugins/" . f . ".vim"
endfor


"""
""" Autocmds
"""
exec "source" . $HOME . "/.config/nvim/autocmds.vim"


"""
""" Colors
"""
" See here for how to overwrite colorscheme
" (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
let &colorcolumn=join(range(101,999),",")
augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=0
                \ | highlight Search ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
                \ | highlight ColorColumn ctermbg=235 guibg=#2c2d27
augroup END
colorscheme gruvbox
