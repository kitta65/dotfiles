local keys = {}

keys["i"] = {
  ["jk"] = { "<esc>", desc = "escape" },
  ["<c-j>"] = { "<down>", desc = "↓" },
  ["<c-k>"] = { "<up>", desc = "↑" },
  ["<c-l>"] = { "<right>", desc = "→" },
  ['<c-g><c-u>'] = { '<esc>viw<s-u>ea', desc = "uppercase" },
}

keys["v"] = {
  ["v"] = { "<esc>", desc = "escape" },
}

keys["x"] = {
  ["y"] = { "ygv<esc>", desc = "yank and do not move back" },
  ["<s-g>"] = { "<s-g>g_", desc = "go to end of file" },
  ["gg"] = { "gg0", desc = "go to start of file" },
}

keys["n"] = {
  ["]t"] = { ":tabn<cr>", desc = "next tab" },
  ["[t"] = { ":tabp<cr>", desc = "previous tab" },
  ["<s-g>"] = { "<s-g>$", desc = "go to end of file" },
  ["gg"] = keys["x"]["gg"],
}

keys["t"] = {
  ["jk"] = { "<c-\\><c-n>" },
  ["<C-h>"] = false,
}

local quotes = {
  -- {left, right, cr}
  { "'",   nil,  true },
  { "'''", nil,  true },
  { '"',   nil,  true }, -- confilicts with which-key.nvim
  { '"""', nil,  true },
  { '|',   nil,  false },
  { '_',   nil,  false },
  { '__',  nil,  false },
  { '*',   nil,  false },
  { '**',  nil,  false },
  { '`',   nil,  true },
  { '```', nil,  true },
  { "(",   ")",  true },
  { "((",  "))", true },
  { "[",   "]",  true },
  { "[[",  "]]", true },
  { "<",   ">",  true },
  { "{",   "}",  true },
  { "{{",  "}}", true },
  { "/*",  "*/", true },
}
for i = 1, #quotes do
  local l = quotes[i][1]
  local r = quotes[i][2]
  if not r then
    r = l
  end
  keys.i[l .. "<tab>"] = { r .. string.rep("<left>", #r) .. l }
  keys.x[l] = {
    function()
      return (
        vim.fn.mode() == "V"
        and l
        or ':<c-u>set paste<cr>'
        .. 'gvs' -- select again
        .. l .. '<c-r>"' .. r
        .. '<esc>:set nopaste<cr>gv<esc>'
      )
    end,
    expr = true,
  }
  if quotes[i][3] then
    keys.i[l .. "<cr>"] = { l .. r .. string.rep("<left>", #r) .. "<cr><esc><s-o>" }
  end
end

return keys
