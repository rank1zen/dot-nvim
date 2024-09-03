vim.diagnostic.config({
  virtual_text = {},
  float = { border = Config.borders, source = 'if_many' },
  signs = false,
})

local lspconfig = require('lspconfig')

require('lspconfig.ui.windows').default_opts({ border = Config.borders })

local default_config = {
  handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = Config.borders }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = Config.borders }),
  },
}

lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, default_config)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
})

lspconfig.lua_ls.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd

lspconfig.gopls.setup({
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      semanticTokens = true,
    },
  },
})

lspconfig.templ.setup({})

lspconfig.tailwindcss.setup({
  filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
  init_options = { userLanguages = { templ = 'html' } },
})

lspconfig.tsserver.setup({})

lspconfig.pyright.setup({})

lspconfig.ccls.setup({})
