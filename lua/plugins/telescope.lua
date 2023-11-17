return
{  -- telecope
  'nvim-telescope/telescope.nvim',
  keys =
  {
    { '<leader>p', '<cmd>Telescope find_files<cr>' },
  },
  opts =
  {
    pickers = {
      find_files = {
        --theme = "dropdown",
      }
    },
    defaults =
    {
      vimgrep_arguments =
      {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config =
      {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical =
        {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
    },
  },
}     -- telescope end

