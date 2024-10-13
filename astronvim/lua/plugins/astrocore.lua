---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        list = true,
        listchars = {
          tab = '» ',
          lead = '.',
          trail = '.',
          eol = '↲',
          extends = '»',
          precedes = '«',
          nbsp = '.',
        },
      },
    },

    mappings = {
      x = {
        ["v"] = { "<esc>", desc = "back to normal mode" },
      },
      t = {
        ["jk"] = { "<c-\\><c-n>", desc = "escape" },
      },
      i = {
        ["<c-l>"] = { "<right>", desc = "→" },
        ['<c-g><c-u>'] = { '<esc>viw<s-u>ea', desc = "uppercase" },
      },
    },
  },
}
