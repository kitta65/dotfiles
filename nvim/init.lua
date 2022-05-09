local f = require('myfunc')

-- If you map `<leader>x` and `<localleader>x` differently,
-- most recently defined mapping will work.
vim.g.mapleader = f.key'<space>'
vim.g.maplocalleader = f.key'<space>'

vim.cmd([[
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'dr666m1/vim-bigquery'
Plug 'dr666m1/vim-clipboard'
Plug 'itchyny/lightline.vim'
Plug 'kassio/neoterm'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production'}
Plug 'tpope/vim-fugitive'
Plug 'yggdroot/indentLine'
" python
Plug 'Vimjas/vim-python-pep8-indent'
" js, ts
Plug 'neoclide/vim-jsx-improve'
call plug#end()
]])

vim.cmd([[
syntax on
filetype plugin indent on
]])

vim.cmd([[
for s:path in glob('~/.config/nvim/settings/*.vim', 0, 1)
  exe 'source ' . s:path
endfor
]])

for _, file in ipairs(vim.fn.glob('~/.config/nvim/lua/*.lua', 0, 1)) do
  local ok, _ = pcall(require, vim.fn.fnamemodify(file, ':t:r'))
  if not ok then
    print(string.format("Cannot execute %s", file))
  end
end
