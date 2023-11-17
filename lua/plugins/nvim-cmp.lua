return
{ -- cmp plugin setup
  "hrsh7th/nvim-cmp",
  dependencies =
  {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
  },

  config = function()
    local cmp = require 'cmp'
    cmp.setup
    {
      snippet =
      {
        expand = function(args)
          require 'snippy'.expand_snippet(args.body)
        end
      },

      -- formatting =
      -- {
      --   fields = { "kind", "abbr", "menu" },

      --   format = function(_, vim_item)
      --     vim_item.menu = vim_item.kind
      --     vim_item.kind = cmp_icons[vim_item.kind]
      --     return vim_item
      --   end,
      -- },

      mapping = cmp.mapping.preset.insert
          {
            ['<c-b>'] = cmp.mapping.scroll_docs(-4),
            ['<c-f>'] = cmp.mapping.scroll_docs(4),
            ['<c-space>'] = cmp.mapping.complete(),
            ['<c-e>'] = cmp.mapping.abort(),
            ['<cr>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = vim.schedule_wrap(function(fallback)
              if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end),
          },

      sources = cmp.config.sources(
        {
          { name = "copilot",                group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'snippy' },
        },
        {
          { name = 'buffer' },
        }),
    }

    cmp.setup.cmdline({ '/', '?' },
      {
        mapping = cmp.mapping.preset.cmdline(),
        sources =
        {
          { name = 'buffer' }
        }
      })
  end
}     --end of cmp setup

