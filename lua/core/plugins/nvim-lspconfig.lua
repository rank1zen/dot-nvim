vim.diagnostic.config {
  signs = false,
  float = { border = 'rounded' },
  virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
}

local lspconfig = require('lspconfig')

local on_attach_custom = function(client, buf_id)
  vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = client.buf })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = client.buf })
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright

lspconfig.gopls.setup {
  on_attach = on_attach_custom,
}

lspconfig.templ.setup {
  on_attach = on_attach_custom,
}

lspconfig.lua_ls.setup {
  handlers = {
    -- Show only one definition to be usable with `a = function()` style.
    -- Because LuaLS treats both `a` and `function()` as definitions of `a`.
    ['textDocument/definition'] = function(err, result, ctx, config)
      if type(result) == 'table' then result = { result[1] } end
      vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
    end,
  },
  on_attach = function(client, bufnr)
    on_attach_custom(client, bufnr)
    -- Reduce unnecessarily long list of completion triggers for better
    -- `MiniCompletion` experience
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize common globals
        globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
        disable = { 'need-check-nil' },
        -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
        workspaceDelay = -1,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}
