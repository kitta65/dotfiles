call plug#begin('~/.vim/plugged')
" common
Plug 'airblade/vim-gitgutter'
Plug 'dr666m1/vim-bigquery'
Plug 'dr666m1/vim-clipboard'
Plug 'itchyny/lightline.vim'
Plug 'kassio/neoterm'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'yggdroot/indentLine'
" python
Plug 'Vimjas/vim-python-pep8-indent'
" js, ts
Plug 'neoclide/vim-jsx-improve'
call plug#end()

"===== common =====
syntax on
syntax sync minlines=10000
filetype plugin indent on
let g:python3_host_prog = '$HOME/.pyenv/shims/python'


"===== theme =====
colorscheme molokai
highlight Comment ctermfg=34

"===== prettier =====
function! MyPrettier()
    let current_line = line(".")
    "return "o\<esc>dd:%!npx prettier --stdin-filepath %" . current_line . "G"
    return ":%!npx prettier --stdin-filepath %\<cr>"
endfunction
"PrettierAsync may be better but cannot be used with vim-bookmarks
nnoremap <expr> <leader>f MyPrettier()



"===== move cursor =====
function! My0()
    let myzero_next_col = strchars(matchstr(getline("."), "^\\s*"))+1
    let myzero_current_col = col(".")
    if 1 < myzero_next_col && myzero_next_col < myzero_current_col
        return "^"
    else
        return "0"
        "!... ignore mapping
    endif
endfunction
nnoremap <expr>0 My0()
vnoremap <expr>0 My0()

for s:path in split(glob('~/.config/nvim/rc/*.vim'), "\n")
  exe 'source ' . s:path
endfor

