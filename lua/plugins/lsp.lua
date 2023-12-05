return {
  {
    'folke/neodev.nvim',
    priority = 100,
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
    dependencies = {
      'VonHeikemen/lsp-zero.nvim',
    },
    opts = {
      ensure_installed = { 'lua_ls' },
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())
      lspconfig.clangd.setup({})
      lspconfig.gopls.setup({})
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
      local lspzero = require('lsp-zero').preset({ manage_nvim_cmp = false })

      lspzero.on_attach(function(client, bufnr)
        lspzero.default_keymaps({ buffer = bufnr })
        vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, { buffer = bufnr })
        vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, { buffer = bufnr })
        vim.keymap.set('n', 'go', function() require('telescope.builtin').lsp_type_definitions() end, { buffer = bufnr })
        vim.keymap.set('n', 'gi', function() require('telescope.builtin').lsp_implementations() end, { buffer = bufnr })
      end)
      lspzero.setup()
    end
  },
}
