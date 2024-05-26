vim.diagnostic.config({
  signs = false,
  float = { border = 'rounded' },
})

local lspconfig = require('lspconfig')

-- LSP settings (for overriding per client)
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local on_attach_custom = function(client, buf_id)
  vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = client.buf })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = client.buf })
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright

lspconfig.gopls.setup({
  on_attach = on_attach_custom,
})

lspconfig.templ.setup({
  on_attach = on_attach_custom,
})

lspconfig.lua_ls.setup({
  handlers = handlers,
})
