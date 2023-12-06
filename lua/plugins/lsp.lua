return {
  {
    'folke/neodev.nvim',
    opts = {
      debug = true,
    },
  },
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'lua_ls', 'gopls', 'clangd' },
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('neodev')
      require('lspconfig').lua_ls.setup(require('lsp-zero').nvim_lua_ls())
      require('lspconfig').clangd.setup({})
      require('lspconfig').gopls.setup({})
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
      local lspzero = require('lsp-zero').preset({ manage_nvim_cmp = false })

      lspzero.on_attach(function(client, bufnr)
        lspzero.default_keymaps({ buffer = bufnr })
      end)
      lspzero.setup()
    end
  },
}
