"""
""" Global
"""
" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

"Define sign symbols
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'

" Show errors/warnings in Airline statusline
let g:airline#extensions#ale#enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Use global version of programs
let g:ale_use_global_executables = 1


"""
""" Fixers configuration
"""
let g:ale_fixers = {
            \   '*': [
            \       'remove_trailing_lines',
            \       'trim_whitespace',
            \],
            \   'bzl': [
            \       'buildifier',
            \],
            \   'cpp': [
            \       'clang-format',
            \],
            \   'go': [
            \       'gofmt',
            \       'goimports',
            \],
            \   'graphql': [
            \       'prettier',
            \],
            \   'hcl': [
            \       'terraform',
            \],
            \   'markdown': [
            \       'prettier',
            \       'textlint',
            \],
            \   'python': [
            \       'autopep8',
            \       'black',
            \       'isort',
            \],
            \   'ruby': [
            \       'rubocop',
            \],
            \   'rust': [
            \       'rustfmt',
            \],
            \   'sh': [
            \       'shfmt',
            \],
            \   'yaml': [
            \       'prettier',
            \],
            \}


"""
""" Linters configuration
"""
" TODO - Conflict between ft=salt for ALE and ft=sls for salt-vim syntax
" plugin
let g:ale_linters = {
            \   'python': [
            \       'flake8',
            \       'pylint',
            \],
            \   'ruby': [
            \       'rubocop',
            \],
            \   'salt': [
            \       'salt-lint',
            \],
            \}

let g:ale_python_flake8_options = '--max-line-length=100'


"""
""" Mappings
"""
" Navigate between errors quickly
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
