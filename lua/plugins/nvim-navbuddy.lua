return {
  'smiteshp/nvim-navbuddy',
  dependencies = {
    'smiteshp/nvim-navic',
    'muniftanjim/nui.nvim'
  },
  config = function()
    local navbuddy = require 'nvim-navbuddy'
     navbuddy.setup {
      window = {
        border = 'solid',
        size = '80%'
      }}
  end
}
