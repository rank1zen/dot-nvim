return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-cmdline',

    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  },
  config = function()
    local cmp = require('cmp')
    local utils = require('core.plugins.cmp.utils')

    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      experimental = {
        ghost_text = true
      },
      mapping = cmp.mapping.preset.insert {
        ['<CR>'] = { i = cmp.mapping.confirm { select = false }  },
        ['<Tab>'] = { i = utils.tab_next },
        ['<S-Tab>'] = { i = utils.tab_prev },
        ['<C-Space>'] = { i = cmp.mapping.complete() }
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }
    }

    cmp.setup.cmdline({ ':' }, {
      mapping = cmp.mapping.preset.cmdline {
        ['<CR>'] = { c = cmp.mapping.confirm { select = false } },
        ['<Tab>'] = { c = utils.tab_next },
        ['<S-Tab>'] = { c = utils.tab_prev }
      },
      sources = {
        { name = 'cmdline' },
      }
    })
  end
}
