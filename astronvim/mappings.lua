local keys = {
  i = {
    ["jk"] = { "<esc>", desc = "escape" },
    ["<c-j>"] = { "<down>", desc = "↓" },
    ["<c-k>"] = { "<up>", desc = "↑" },
    ["<c-l>"] = { "<right>", desc = "→" },
  },
  v = {
    ["v"] = { "<esc>", desc = "escape" }
  },
}

local quotes = {
  { "'" },
  { "'''" },
  { '"' },
  { '"""' },
  { '|' },
  { '_' },
  { '__' },
  { '*' },
  { '**' },
  { '`' },
  { '```' },
  { "[",  "]" },
  { "<",  ">" },
  { "{",  "}" },
  { "{{", "}}" },
  { "/*", "*/" },
}
for i = 1, #quotes do
  local l = quotes[i][1]
  local r = quotes[i][2]
  if not r then
    r = l
  end
  keys.i[l .. "<tab>"] = { r .. string.rep("<left>", #r) .. l }
  keys.v[l] = {
    ':<c-u>set paste<cr>'
    .. 'gvs' -- select again
    .. l .. '<c-r>"' .. r
    .. '<esc>:set nopaste<cr>'
  }
end

return keys
