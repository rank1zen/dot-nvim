local cmp = require('cmp')
local utils = require('core.plugins.lspzero.utils')

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
    ['<Tab>'] = utils.tab_next,
    ['<S-Tab>'] = utils.tab_prev
  },
  sources = {
    {
      name = 'nvim_lsp',
      entry_filter = function(entry, context)
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
      end
    }
  }
}

cmp.setup.cmdline({ ':' }, {
  formatting = {
    fields = { 'abbr' }
  },
  mapping = cmp.mapping.preset.cmdline {
    ['<CR>'] = { c = cmp.mapping.confirm { select = false } },
    ['<Tab>'] = { c = utils.tab_next },
    ['<S-Tab>'] = { c = utils.tab_prev }
  },
  sources = {
    { name = 'cmdline' }
  }
})
