return {
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
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_actions = lsp_zero.cmp_action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = { ghost_text = true },
        preselect = cmp.PreselectMode.None,
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
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
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
        ensure_installed = { 'lua_ls', 'gopls', 'clangd' },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end
        }
      })
    end
  },
}
