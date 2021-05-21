""" Template for autocmds, avoid defining autocmds twice:
"""
"""   augroup <unique_group_name>
"""     autocmd!
"""     " define autocmds here
"""   augroup END

augroup vimrc
    " remove all existing vimrc autocmds
    autocmd!

    " --- all files ---
    " Convert tabs to spaces on write
    autocmd BufWrite * :retab

    " Set indentation 2 spaces for specific filetypes
    autocmd FileType yaml,html,hcl setlocal ts=2 sts=2 sw=2 expandtab

    " --- gopass files ---"
    "  https://github.com/gopasspw/gopass/blob/master/docs/setup.md#optional-post-installation-steps
    au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

    " --- assembly ---
    "  Set correct filetype
    autocmd BufNewFile,BufRead *.asm set filetype=nasm

    " --- go ---
    " use real tabs in .go files, not spaces
    autocmd FileType go setlocal noexpandtab

    " --- json ---
    "  Comment highlighting for coc.nvim config
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " TODO == ALE expecting ft=salt, but salt-vim is expecting ft=sls
    " --- salt ---
    autocmd FileType jinja,jinja2 set filetype=sls

augroup END
