local f = require('myfunc')

-- If you map `<leader>x` and `<localleader>x` differently,
-- most recently defined mapping will work.
vim.g.mapleader = f.key'<space>'
vim.g.maplocalleader = f.key'<space>'

vim.cmd([[
syntax on
filetype plugin indent on
]])

for _, file in ipairs(vim.fn.glob('~/.config/nvim/lua/*.lua', 0, 1)) do
  local ok, _ = pcall(require, vim.fn.fnamemodify(file, ':t:r'))
  if not ok then
    print(string.format("Cannot execute %s", file))
  end
end
