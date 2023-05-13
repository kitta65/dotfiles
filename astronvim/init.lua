return {
  plugins = {
    {
      "dr666m1/vim-clipboard",
      keys = {
        { "<leader>c", "<esc>:ClipboardYank<cr>", mode = "v",                   desc = "copy to clipboard" },
        { "<leader>v", ":ClipboardPut<cr>",       desc = "paste from clipboard" },
      }
    },
    {
      "MattesGroeger/vim-bookmarks",
      init = function()
        vim.g.bookmark_no_default_key_mappings = 1
        vim.g.bookmark_auto_save = 0
      end,
      keys = {
        { "mm", ":silent BookmarkToggle<cr>" },
        { "]m", ":silent BookmarkNext<cr>" },
        { "[m", ":silent BookmarkPrev<cr>" },
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
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        local luasnip = require "luasnip"
        opts.sources = cmp.config.sources {
          {
            name = "nvim_lsp",
            priority = 1000,
            entry_filter = function(entry)
              return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippets
            end -- https://neovim.discourse.group/t/how-to-disable-lsp-snippets/922/4
          },
          { name = "luasnip", priority = 750 },
          { name = "buffer",  priority = 500 },
          { name = "path",    priority = 250 },
        }
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
    { "rafamadriz/friendly-snippets", enabled = false },
    { "max397574/better-escape.nvim", enabled = false },
    { "windwp/nvim-autopairs",        enabled = false },
    { "folke/which-key.nvim",         enabled = false },
  },
  lsp = {
    servers = { "bqls" },
    -- https://astronvim.com/Recipes/advanced_lsp#disabling-formatting-for-a-filter-function
    formatting = {
      filter = function(client)
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
          return client.name == "null-ls"
        end
        return true
      end,
      format_on_save = false,
    },
    setup_handlers = {
      -- suppress file is a commonjs suggestion
      tsserver = function()
        require('lspconfig').tsserver.setup({
          init_options = { preferences = { disableSuggestions = true, }, },
        })
      end
    },
  },
}
