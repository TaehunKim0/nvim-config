vim.o.clipboard = 'unnamed'

-- enable mouse input
vim.o.mouse = 'a'

-- ui settings
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.number = true
vim.o.signcolumn = 'yes:1'
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.laststatus = 3
vim.o.splitkeep = 'screen'
vim.opt.fillchars:append {
    horiz     = '━',
    horizup   = '┻',
    horizdown = '┳',
    vert      = '┃',
    vertleft  = '┫',
    vertright = '┣',
    verthoriz = '╋',
    eob       = ' ',
}
vim.o.wrap = false

-- show trailing whitespace
vim.o.list = true
vim.o.listchars = 'trail:·,tab:  '

-- use 2 spaces for indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup( -- all vim plugin setup
    {
        {
            'nathom/filetype.nvim',
            config = function()
                require("filetype").setup({
                    overrides = {
                        extensions = {
                            -- Set the filetype of *.pn files to potion
                            pn = "potion",
                            rs = "rust"
                        },
                        literal = {
                            -- Set the filetype of files named "MyBackupFile" to lua
                            MyBackupFile = "lua",
                        },
                        complex = {
                            -- Set the filetype of any full filename matching the regex to gitconfig
                            [".*git/config"] = "gitconfig", -- Included in the plugin
                        },

                    },
                })
            end
        },


        { -- snippy plugin setup
            'dcampos/nvim-snippy', -- nvim snippy
            dependencies =
            {
                'dcampos/cmp-snippy',
            },

            config = function()
                require 'snippy'.setup
                {
                    mappings =
                    {
                        is =
                        {
                            ['<tab>'] = 'expand_or_advance',
                            ['<s-tab>'] = 'previous',
                        },
                    },
                }
            end,
        }, -- end of snippy setup

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
                        },

                    sources = cmp.config.sources(
                        {
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
            end,
        }, --end of cmp setup

        {  -- lsp setup
            'neovim/nvim-lspconfig',
            config = function()
                local lspconfig = require 'lspconfig'
                local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
                lspconfig.clangd.setup
                { -- run clangd lsp server
                    capabilities = capabilities,
                }
                lspconfig.rust_analyzer.setup
                { -- run rust lsp serve
                    capabilities = capabilities,
                }
            end,
        },-- end of lsp setup

        {-- color scheme setup
            'habamax/vim-saturnite',
            config = function()
                vim.cmd.colorscheme('saturnite')
            end,
        }, -- end of color scheme setup

        { -- neo - tree setup
            'nvim-neo-tree/neo-tree.nvim',
            keys =
            {
                { '<leader>t', ':Neotree toggle<cr>' },
            },
            dependencies =
            {
                'nvim-tree/nvim-web-devicons',
                'nvim-lua/plenary.nvim',
                'muniftanjim/nui.nvim',
            },

            config = function()
                require 'neo-tree'.setup
                {
                    close_if_last_window = true,
                    popup_border_style = 'solid',
                    enable_git_status = true,
                    enable_diagnostics = true,
                    default_component_configs =
                    {
                        indent =
                        {
                            indent_size = 2,
                            padding = 1, -- extra padding on left hand side
                            with_markers = true,
                            indent_marker = '│',
                            last_indent_marker = '└',
                            highlight = 'NeoTreeIndentMarker',
                        },
                        icon =
                        {
                            folder_closed = '',
                            folder_open = '',
                            folder_empty = "",
                            default = '',
                        },
                        name =
                        {
                            trailing_slash = false,
                            use_git_status_colors = true,
                        },
                        git_status =
                        {
                            highlight = 'NeoTreeDimText', -- if you remove this the status will be colorful
                            symbols = {
                                -- Change type
                                added     = "",
                                modified  = "",
                                deleted   = "",
                                renamed   = "",
                                -- Status type
                                untracked = "?",
                                ignored   = "󰔌",
                                unstaged  = "",
                                staged    = "",
                                conflict  = "",
                            },
                        },
                    },
                    filesystem =
                    {
                        filtered_items =
                        {
                            hide_dotfiles = false,
                            hide_gitignored = false,
                        }
                    },
                }
            end
        }, -- end of neo - tree setup
        {
          -- toggleterm
          'akinsho/toggleterm.nvim',
          cmd = { 'ToggleTerm', 'TermExec' },
          init = function()
            local function toggleTerm()
              if vim.api.nvim_win_get_config(0).relative ~= '' then
                return
              end
              if vim.bo.filetype == 'fzf' then
                return
              end
              vim.cmd 'ToggleTerm direction=horizontal'
            end

            vim.keymap.set('n', '<c-k>', toggleTerm, { remap = false, silent = true })
            vim.keymap.set('t', '<c-k>', toggleTerm, { remap = false, silent = true })
          end,
          config = function()
            local toggleterm = require 'toggleterm'
            toggleterm.setup 
            {
              shade_terminals = false,
              shell = 'nu',
            }
          end
        },
        {
          -- statusline
          'nvim-lualine/lualine.nvim',
          event = 'VeryLazy',
          config = function()
            require 'lualine'.setup 
            {
              options = 
              {
                globalstatus = true,
                component_separators = { left = '│', right = '│' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = 
                {
                  -- filetype
                },
              },
            }
          end
        }
    }, 
    {
      performance = 
      {
        rtp = 
        {
          reset = true,
          disabled_plugins = 
          {
            'matchparen',
          }
        }
      }
    })
