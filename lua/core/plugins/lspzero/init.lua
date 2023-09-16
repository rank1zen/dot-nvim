return {
  'folke/neodev.nvim',
  'hrsh7th/cmp-cmdline',
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },

      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' }
    },
    config = function()
      require('neodev').setup()

      vim.diagnostic.config {
        signs = false
      }

      local lspzero = require('lsp-zero').preset { manage_nvim_cmp = false }

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
      require('core.plugins.lspzero.cmp')
    end
  }
}
