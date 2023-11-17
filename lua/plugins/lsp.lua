return
 {      -- lsp setup
      'neovim/nvim-lspconfig',
      config = function()
        local lspconfig = require 'lspconfig'
        local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
        lspconfig.clangd.setup
        {         -- run clangd lsp server
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
        {         -- run rust lsp serve
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
    }     -- end of lsp setup