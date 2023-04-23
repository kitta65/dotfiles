return {
  colorscheme = "terafox",
  plugins = {
    "EdenEast/nightfox.nvim",
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
  }
}
