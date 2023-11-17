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

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

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
    import = 'plugins'
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
  }
)

vim.keymap.set('n', '<F2>', ':lua vim.lsp.buf.format()<CR>')
