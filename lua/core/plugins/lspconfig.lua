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

        local navic = require('nvim-navic')

        local icons = require('core.icons')

        navic.setup {
            icons = icons.no_icons
        }

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
            on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
            end
        }

        lspconfig.clangd.setup {
            capabilities = cmp_capabilities,
            on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
            end
        }
    end,
}
