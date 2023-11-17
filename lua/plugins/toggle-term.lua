return
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
}

