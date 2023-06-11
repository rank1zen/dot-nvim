return {
    'neovim/nvim-lspconfig',
    config = function()
        vim.diagnostic.config {
            virtual_text = false,
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
    end,
}
