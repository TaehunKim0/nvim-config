return
{
  -- lsp setup
  'neovim/nvim-lspconfig',

  -- defpendencies
  dependencies = {
    'folke/neodev.nvim',
    "SmiteshP/nvim-navbuddy",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "mrded/nvim-lsp-notify",
  },

  config = function()
    require 'neodev'.setup {}
    local lspconfig = require 'lspconfig'
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    -- nvim lua config support

    local lsp_notify_loaded = false

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- lsp progress
        if not lsp_notify_loaded then
          require 'lsp-notify'.setup {
            notify = require 'notify'
          }
          lsp_notify_loaded = true
        end
      end,
    })

    lspconfig.clangd.setup
    { -- run clangd lsp server
      cmd =
      {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never',
      },
      capabilities = capabilities,
    }
    lspconfig.rust_analyzer.setup
    { -- run rust lsp serve
      capabilities = capabilities,
    }
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end
} -- end of lsp setup
