return {
  {
    'folke/neodev.nvim',
    opts = {},
  },
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local lsp_zero = require('lsp-zero');
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_actions = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        experimental = {
          ghost_text = true
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp_actions.luasnip_supertab({ behavior = 'select' }),
          ['<S-Tab>'] = cmp_actions.luasnip_shift_supertab({ behavior = 'select' }),
          ['<C-e>'] = cmp_actions.toggle_completion({ modes = { 'i' } }),
        },
      })
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
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
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'gopls', 'clangd', 'sqlls' },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
          end
        }
      })
    end
  },
}
