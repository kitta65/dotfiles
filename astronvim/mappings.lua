local keys = {}

keys["i"] = {
  ["jk"] = { "<esc>", desc = "escape" },
  ["<c-l>"] = { "<right>", desc = "→" },
  ['<c-g><c-u>'] = { '<esc>viw<s-u>ea', desc = "uppercase" },
}

keys["t"] = {
  ["jk"] = { "<c-\\><c-n>", desc = "escape" },
  ["<C-h>"] = false,
}

return keys
