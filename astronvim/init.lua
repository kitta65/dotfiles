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
    { "rafamadriz/friendly-snippets", enabled = false },
    { "max397574/better-escape.nvim", enabled = false },
    { "windwp/nvim-autopairs",        enabled = false },
  },
  lsp = {
    config = {
      bqls = {
        cmd = { 'bq-language-server', '--stdio' },
        filetypes = { 'sql' },
        root_dir = function() return vim.fn.getcwd() end,
        settings = { bqExtensionVSCode = {} },
      }
    },
    servers = { "bqls" },
  },
}
