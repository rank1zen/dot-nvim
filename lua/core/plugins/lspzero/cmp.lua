local cmp = require('cmp')
local utils = require('core.plugins.lspzero.utils')
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
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp_actions.luasnip_supertab({ behavior = 'select' }),
    ['<S-Tab>'] = cmp_actions.luasnip_shift_supertab({ behavior = 'select' }),
    ['<C-e>'] = cmp_actions.toggle_completion({ modes = { 'i' }})
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

cmp.setup.cmdline({ ':' }, {
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = ''
      return vim_item
    end
  },
  mapping = cmp.mapping.preset.cmdline {
    ['<CR>'] = { c = cmp.mapping.confirm({ select = false }) },
    ['<Tab>'] = { c = utils.tab_next },
    ['<S-Tab>'] = { c = utils.tab_prev },
    ['<C-e>'] = cmp_actions.toggle_completion({ modes = { 'c' }})
  },
  sources = {
    { name = 'cmdline' }
  }
})

