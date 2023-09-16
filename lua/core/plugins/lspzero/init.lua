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
      end)

      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())
      lspconfig.clangd.setup({})

      lspconfig.jdtls.setup({})

      lspconfig.tailwindcss.setup({})
      lspconfig.tsserver.setup({})

      lspzero.setup()

      local cmp = require('cmp')
      local utils = require('core.plugins.lspzero.utils')
      local a = lspzero.cmp_action()

      local ts_utils = require('nvim-treesitter.utils')
      lspzero.cmp_action()

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        experimental = {
          ghost_text = true
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function (entry, vim_item)
            local function trim(text)
              local max = 40
              if text and text:len() > max then
                text = text:sub(1, max) .. "..."
              end
              return text
            end
            vim_item.abbr = trim(vim_item.abbr)
            return vim_item
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = a.luasnip_supertab({ behavior = cmp.SelectBehavior.Select }),
          ['<S-Tab>'] = a.luasnip_shift_supertab({ behavior = cmp.SelectBehavior.Select }),
          ['<C-Space>'] = cmp.mapping.complete()
        },
        sources = {
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, context)
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
          },
          { name = 'luasnip' }
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
    require('luasnip.loaders.from_vscode').lazy_load()
    end
  }
}
