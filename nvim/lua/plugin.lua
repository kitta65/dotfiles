-- bootstrapping
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PackerBootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- auto complile
local group = vim.api.nvim_create_augroup("packer", {})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  group = group,
  pattern = {'plugin.lua'},
  command = 'source <afile> | PackerCompile'
})

return require('packer').startup(function(use) -- `use` satisfies language server
  use 'wbthomason/packer.nvim'

  use {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme terafox")
    end
  }

  use {
    "hrsh7th/nvim-cmp",
    after = "nvim-lspconfig",
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          {name = 'buffer'}
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<cr>'] = cmp.mapping.confirm({ select = false }),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
          ['<c-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        })
      })

      local ls = require"luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local c = ls.choice_node
      ls.add_snippets("all", {
        s("today", c(1, {t(vim.fn.strftime('%Y%m%d')), t(vim.fn.strftime('%Y-%m-%d'))}))
      })

      vim.keymap.set(
        {"i", "s"},
        "<tab>",
        function() return
          ls.expand_or_jumpable()
          and "<plug>luasnip-expand-or-jump"
          or "<tab>"
        end,
        {expr = true}
      )
      vim.keymap.set({"i", "s"}, "<c-e>", "<plug>luasnip-next-choice")

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require'lspconfig'
      local servers = {
        "pyright",
        "tsserver",
        "sumneko_lua"
      }
      for _, server in ipairs(servers) do
        if server == "sumneko_lua" then
          lspconfig[server].setup {
            capabilities = capabilities,
            settings = {
              Lua = {diagnostics = {globals = {'vim'}}}
            }
          }
        else
          lspconfig[server].setup {capabilities = capabilities}
        end
      end
    end,
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'saadparwaiz1/cmp_luasnip'},
      {"L3MON4D3/LuaSnip"},
      {"hrsh7th/cmp-nvim-lsp"},
    },
  }

  use "williamboman/nvim-lsp-installer"
  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    config = function()
      require("nvim-lsp-installer").setup {}
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    end
  }
  if PackerBootstrap then
    require('packer').sync()
  end
end)
