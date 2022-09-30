-- bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PackerBootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use) -- `use` satisfies language server
  use 'wbthomason/packer.nvim'

  use {
    'chentoast/marks.nvim',
    config = function()
      require 'marks'.setup {
        default_mappings = false,
        bookmark_0 = {
          sign = '*',
        },
        mappings = {
          set_bookmark0 = 'mm',
          delete_bookmark = 'md',
          next_bookmark0 = 'm]',
          prev_bookmark0 = 'm[',
        }
      }
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require 'telescope'.setup {
        defaults = { mappings = {} },
        pickers = {},
        extensions = {},
      }
      vim.cmd [[
      nnoremap <leader>f <cmd>Telescope find_files<cr>
      nnoremap <leader>/ <cmd>Telescope live_grep<cr>
      ]]
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'nvim-tree'.setup {
        actions = {
          open_file = {
            resize_window = true
          }
        }
      }
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
      local group = vim.api.nvim_create_augroup("nvim-tree", {})
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = group,
        pattern = { 'NvimTree' },
        command = [[setlocal splitright]]
      })
    end
  }

  use {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme terafox")
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'lualine'.setup {}
    end
  }

  use {
    "hrsh7th/nvim-cmp",
    after = "nvim-lspconfig",
    config = function()
      local cmp = require 'cmp'
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' }
        }, {
          { name = 'path' }
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<cr>'] = cmp.mapping.confirm({ select = false }),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
          ['<c-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        })
      })

      require 'myfunc'.exec_all("snip")

      vim.keymap.set(
        { "i", "s" },
        "<tab>",
        function() return require "luasnip".expand_or_jumpable()
              and "<plug>luasnip-expand-or-jump"
              or "<tab>"
        end,
        { expr = true }
      )
      vim.keymap.set({ "i", "s" }, "<c-e>", "<plug>luasnip-next-choice")

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require 'lspconfig'
      -- See :h lspconfig-adding-servers
      local configs = require 'lspconfig.configs'
      if not configs.bqls then
        configs.bqls = {
          default_config = {
            cmd = { 'bq-language-server', '--stdio' },
            filetypes = { 'bigquery' },
            root_dir = function(fname) return lspconfig.util.find_git_ancestor(fname)
                  or vim.fn.fnamemodify(fname, ':h')
            end,
            settings = { bqExtensionVSCode = {
              diagnostic = { forVSCode = false },
              formatting = { printKeywordsInUpperCase = false },
            } },
          },
        }
      end
      local servers = {
        "pyright",
        "tsserver",
        "eslint",
        "sumneko_lua",
        "bqls",
        "rust_analyzer",
        "gopls",
      }
      for _, server in ipairs(servers) do
        if server == "sumneko_lua" then
          lspconfig[server].setup {
            capabilities = capabilities,
            settings = {
              Lua = { diagnostics = { globals = { 'vim' } } }
            }
          }
        else
          lspconfig[server].setup { capabilities = capabilities }
        end
      end
    end,
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { 'hrsh7th/cmp-path' },
    },
  }

  use "williamboman/nvim-lsp-installer"

  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    config = function()
      require("nvim-lsp-installer").setup {}
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>b', ':Gitsigns toggle_current_line_blame<cr>')
      vim.cmd([[highlight link GitSignsCurrentLineBlame Comment]])
    end,
    disable = true,
  }

  use 'airblade/vim-gitgutter'

  use 'dr666m1/vim-clipboard'

  use 'dr666m1/vim-bigquery'

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_end_of_line = true,
      }
    end
  }

  use {
    "dr666m1/toggleterm.nvim", branch = 'fix/shade_color', config = function()
      require("toggleterm").setup {
        open_mapping = [[<c-\>]],
      }
      vim.api.nvim_create_user_command(
        "ToggleTermSendVisualSelectionNoTrim",
        "'<,'> lua require'toggleterm'.send_lines_to_terminal('visual_selection', false, <q-args>)<CR>",
        { range = true, nargs = "?" }
      )
      vim.keymap.set('n', '<leader>r', ':ToggleTermSendCurrentLine<cr><down>')
      vim.keymap.set('x', '<leader>r', ':ToggleTermSendVisualSelectionNoTrim<cr>')
    end,
    as = 'toggleterm.fork',
    after = 'nightfox.nvim',
  }
  use {
    "akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
      require("toggleterm").setup {
        open_mapping = [[<c-\>]],
      }
    end,
    disable = true,
    after = 'nightfox.nvim',
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "null-ls".setup({
        sources = {
          require "null-ls".builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
          }),
        },
      })
    end,
    requires = {
      { "nvim-lua/plenary.nvim" }
    }
  }

  use {
    'Vimjas/vim-python-pep8-indent',
    ft = { "python" }
  }

  use 'hashivim/vim-terraform'

  if PackerBootstrap then
    require('packer').sync()
  end
end)
