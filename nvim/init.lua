local F = require('myfunc')

-- If you map `<leader>x` and `<localleader>x` differently,
-- most recently defined mapping will work.
vim.g.mapleader = F.key'<space>'
vim.g.maplocalleader = F.key'<space>'
vim.g.do_filetype_lua = 1

vim.cmd([[
syntax on
filetype plugin indent on
]])

F.exec_all('init')
