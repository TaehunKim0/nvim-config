return
{                        -- snippy plugin setup
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
  end
} -- end of snippy setup
