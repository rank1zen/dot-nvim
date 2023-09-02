return function()
  vim.diagnostic.config {
    signs = false,
    float = { border = 'rounded' }
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = 'rounded'
    }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = 'rounded'
    }
  )

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

  lspconfig.texlab.setup {
    capabilities = cmp_capabilities,
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
            "%f",
            "-output-directory=build"
          },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = true
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = false
        }
      }
    }
  }
end
