return {
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local cmp_actions = require('lsp-zero').cmp_action()
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = vim_item.kind:lower()
            return vim_item
          end
        },
        experimental = {
          ghost_text = true
        },
        window = {
          completion = require('cmp').config.window.bordered(),
          documentation = require('cmp').config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp_actions.luasnip_supertab({ behavior = 'select' }),
          ['<S-Tab>'] = cmp_actions.luasnip_shift_supertab({ behavior = 'select' }),
          ['<C-e>'] = cmp_actions.toggle_completion({ modes = { 'i' } })
        },
        sources = {
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, context)
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
          },
          {
            name = 'luasnip'
          }
        }
      })
    end
  },
  {
    'hrsh7th/cmp-cmdline',
    config = function()
      require('cmp').setup.cmdline({ ':' }, {
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = ''
            return vim_item
          end
        },
        mapping = require('cmp').mapping.preset.cmdline {
          ['<CR>'] = { c = require('cmp').mapping.confirm({ select = false }) },
          ['<Tab>'] = { c = require('cmp').mapping.select_next_item({ behavior = 'select' }) },
          ['<S-Tab>'] = { c = require('cmp').mapping.select_prev_item({ behavior = 'select' }) },
          ['<C-e>'] = require('lsp-zero').cmp_action().toggle_completion({ modes = { 'c' } })
        },
        sources = {
          { name = 'cmdline' }
        }
      })
    end
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
}
