local function key(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- tab
vim.keymap.set('n', '<c-n>', ':tabn<cr>')
vim.keymap.set('n', '<c-p>', ':tabp<cr>')

-- yank, put
vim.keymap.set('x', 'y', 'ygv<esc>')
vim.keymap.set('x', '<leader>y', '<esc>:ClipboardYank<cr>')
vim.keymap.set('n', '<leader>p', ':ClipboardPut<cr>')

-- other
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')
vim.keymap.set('x', 'v', '<esc>')
vim.keymap.set('i', '<c-g><c-u>', '<esc>viw<s-u>ea')

-- move
vim.keymap.set(
  {'i', 'c', 't'},
  '<c-j>',
  function() return vim.fn.pumvisible() == 1 and "<c-e><down>" or "<down>" end,
  {expr = true}
)
vim.keymap.set(
  {'i', 'c', 't'},
  '<c-k>',
  function() return vim.fn.pumvisible() == 1 and "<c-e><up>" or "<up>" end,
  {expr = true}
)
vim.keymap.set({'i', 'c', 't'}, '<c-l>', '<right>')
vim.keymap.set('n', '<s-g>', '<s-g>$')
vim.keymap.set('x', '<s-g>', '<s-g>g_')
vim.keymap.set({'n', 'x'}, 'gg', 'gg0')
vim.keymap.set('x', '$', function() return vim.fn.mode() == key"<c-v>" and "$" or "g_" end, {expr = true})
vim.keymap.set(
  {'n', 'x'},
  '0',
  function() return
    vim.fn.matchend(vim.fn.getline("."), [[\v\s*]]) + 1 <  vim.fn.col(".")
    and "^"
    or "0"
  end,
  {expr = true}
)

-- quote
vim.keymap.set({'i', 't'}, '(', ')<left>(')
vim.keymap.set({'i', 't'}, '{', '}<left>{')
vim.keymap.set({'i', 't'}, '[', ']<left>[')
vim.keymap.set({'i', 't'}, '<', '><left><')
vim.keymap.set({'i', 't'}, '< ', '< ')
vim.keymap.set({'i', 't'}, '<=', '<=')
vim.keymap.set({'i', 't'}, '"', '"<left>"')
vim.keymap.set({'i', 't'}, "'", "'<left>'")
vim.keymap.set({'i', 't'}, "`", '`<left>`')
vim.keymap.set('i', '(<cr>', '()<left><cr><esc><s-o>')
vim.keymap.set('i', '{<cr>', '{}<left><cr><esc><s-o>')
vim.keymap.set('i', '[<cr>', '[]<left><cr><esc><s-o>')
vim.cmd([[
function! s:Quote(left, ...)
  let right = get(a:000, 0, a:left)
  execute "normal! `>"
  execute "normal! a" . right
  execute "normal! `<"
  execute "normal! i" . a:left
endfunction
vnoremap "  :<c-u>call <SID>Quote('"')<cr>
vnoremap '  :<c-u>call <SID>Quote("'")<cr>
vnoremap `  :<c-u>call <SID>Quote("`")<cr>
vnoremap {  :<c-u>call <SID>Quote("{",     "}")<cr>
vnoremap (  :<c-u>call <SID>Quote("(",     ")")<cr>
vnoremap [  :<c-u>call <SID>Quote("[",     "]")<cr>
vnoremap <  :<c-u>call <SID>Quote("<",     ">")<cr>
vnoremap /* :<c-u>call <SID>Quote("/* ",   " */")<cr>
vnoremap <! :<c-u>call <SID>Quote("<!-- ", " -->")<cr>
]])
