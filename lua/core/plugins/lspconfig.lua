return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim'
  },
  config = function()
    vim.diagnostic.config {
      signs = false
    }

    require('neodev').setup()
    local lspconfig = require('lspconfig')

    local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.lua_ls.setup {
      capabilities = cmp_capabilities,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false
          }
        }
      }
    }

    lspconfig.pyright.setup {
      capabilities = cmp_capabilities,
    }

    lspconfig.clangd.setup {
      capabilities = cmp_capabilities,
    }
    lspconfig.tailwindcss.setup {
      capabilities = cmp_capabilities,
    }
    lspconfig.tsserver.setup {
      capabilities = cmp_capabilities
    }
  end,
}
