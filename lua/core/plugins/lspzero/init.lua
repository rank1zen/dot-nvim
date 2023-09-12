return {
  'folke/neodev.nvim',
  'hrsh7th/cmp-cmdline',
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      {'neovim/nvim-lspconfig'},

      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},

      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'}
    },
    config = function()
      require('neodev').setup()

      vim.diagnostic.config {
        signs = false
      }

      local lspzero = require('lsp-zero').preset({})

      lspzero.on_attach(function(client, bufnr)
        lspzero.default_keymaps({ buffer = bufnr })
        vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, { buffer = bufnr })
        vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, { buffer = bufnr })
        vim.keymap.set('n', 'J', function() vim.diagnostic.open_float() end)
      end)

      lspzero.set_server_config {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      }

      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())
      lspconfig.jdtls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.texlab.setup({})

      lspzero.setup()

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
}
