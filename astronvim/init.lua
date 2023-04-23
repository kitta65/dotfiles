return {
  colorscheme = "terafox",
  plugins = {
    "EdenEast/nightfox.nvim",
    {
      "dr666m1/vim-clipboard",
      keys = {
        { "<leader>c", "<esc>:ClipboardYank<cr>", mode = "v",                   desc = "copy to clipboard" },
        { "<leader>v", ":ClipboardPut<cr>",       desc = "paste from clipboard" },
      }
    },
    -- https://astronvim.com/Recipes/snippets
    {
      "L3MON4D3/LuaSnip",
      config = function(plugin, opts)
        -- https://astronvim.com/Recipes/custom_plugins#extending-core-plugin-config-functions
        require "plugins.configs.luasnip" (plugin, opts)
        require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/dotfiles/astronvim/snippets" } })
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function(_, config)
        local null_ls = require "null-ls"
        config.sources = {
          null_ls.builtins.formatting.prettier.with { only_local = "node_modules/.bin" },
        }
        return config
      end,
    },
    { "rafamadriz/friendly-snippets", enabled = false },
    { "max397574/better-escape.nvim", enabled = false },
    { "windwp/nvim-autopairs",        enabled = false },
  },
  lsp = {
    servers = { "bqls" },
    -- https://astronvim.com/Recipes/advanced_lsp#disabling-formatting-for-a-filter-function
    formatting = {
      filter = function(client)
        if vim.bo.filetype == "typescript" then
          return client.name == "null-ls"
        end
        return true
      end
    }
  },
}
