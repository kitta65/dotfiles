local keys = {
  i = {
    ["jk"] = { "<esc>", desc = "escape" },
    ["<c-j>"] = { "<down>", desc = "↓" },
    ["<c-k>"] = { "<up>", desc = "↑" },
    ["<c-l>"] = { "<right>", desc = "→" },
    ['<c-g><c-u>'] = { '<esc>viw<s-u>ea', desc = "uppercase" }
  },
  v = {
    ["v"] = { "<esc>", desc = "escape" }
  },
  x = {}
}

local quotes = {
  -- {left, right, cr}
  { "'",   nil,  true },
  { "'''", nil,  true },
  { '"',   nil,  true },
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
    ':<c-u>set paste<cr>'
    .. 'gvs' -- select again
    .. l .. '<c-r>"' .. r
    .. '<esc>:set nopaste<cr>'
  }
  if quotes[i][3] then
    keys.i[l .. "<cr>"] = { l .. r .. string.rep("<left>", #r) .. "<cr><esc><s-o>" }
  end
end

return keys
