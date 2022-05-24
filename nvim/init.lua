local f = require('myfunc')

-- If you map `<leader>x` and `<localleader>x` differently,
-- most recently defined mapping will work.
vim.g.mapleader = f.key'<space>'
vim.g.maplocalleader = f.key'<space>'
vim.g.do_filetype_lua = 1

vim.cmd([[
syntax on
filetype plugin indent on
]])

f.exec_all('init')
