"""
""" Grep config
"""
" Overload Rg command
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column -n --hidden -i -L --glob "!.git/*" --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Map Rg to <Leader>g
nnoremap <Leader>g :Rg<CR>

" Search only those files opened in vim
"nnoremap <Leader>* :Rg expand('<cword>') <CR>

" Search for current word
"nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search current selection
"nmap gs <plug>(GrepperOperator)
"xmap gs <plug>(GrepperOperator)

" Find all occurences of TODO and FIXME
"command! TODO :Grepper -tool rg -query '\(TODO\|FIXME\)'


"""
""" Other Mappings
"""
" Map FZF to Ctrl-P
nnoremap <C-p> :<C-u>Files<CR>

" Map :Buffers to <leader><b>
nnoremap <leader>b :<C-u>Buffers<CR>

" Show vim mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
