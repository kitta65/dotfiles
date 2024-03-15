return {
  plugins = {
    -- https://docs.astronvim.com/recipes/snippets/
    {
      "L3MON4D3/LuaSnip",
      config = function()
        -- require "plugins.configs.luasnip"(plugin, opts)
        require("luasnip.loaders.from_vscode").lazy_load {
          paths = { "~/dotfiles/astronvim/snippets" }
        }
      end,
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function() require("nvim-surround").setup({}) end
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = function(_, opts)
        opts.filesystem["window"] = { mappings = { ["<c-h>"] = "navigate_up" } }
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        local luasnip = require "luasnip"
        opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" })
        return opts
      end,
    },
  },
}
