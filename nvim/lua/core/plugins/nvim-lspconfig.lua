vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    spacing = 2,
  },
  float = {
    border = _G.Config.borderst,
    source = 'if_many',
  },
  signs = false,
})

local lspconfig = require('lspconfig')

-- LSP settings (for overriding per client)
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = _G.Config.borders }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _G.Config.borders }),
}

local on_attach_custom = function(client, buf_id)
  vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = client.buf })
  vim.keymap.set('i', '<C-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = client.buf })
end

lspconfig.lua_ls.setup({
  on_attach = on_attach_custom,
  handlers = handlers,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright

lspconfig.gopls.setup({
  on_attach = on_attach_custom,
  handlers = handlers,
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

lspconfig.templ.setup({
  on_attach = on_attach_custom,
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach_custom,
  filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
  init_options = { userLanguages = { templ = 'html' } },
})

-- lspconfig.html.setup({
--   on_attach = on_attach_custom,
--   filetypes = { 'html', 'templ' },
-- })
