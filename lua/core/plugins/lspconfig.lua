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
        navic.setup {
            icons = {
                File          = '',
                Module        = '',
                Namespace     = '',
                Package       = '',
                Class         = '',
                Method        = '',
                Property      = '',
                Field         = '',
                Constructor   = '',
                Enum          = '',
                Interface     = '',
                Function      = '',
                Variable      = '',
                Constant      = '',
                String        = '',
                Number        = '',
                Boolean       = '',
                Array         = '',
                Object        = '',
                Key           = '',
                Null          = '',
                EnumMember    = '',
                Struct        = '',
                Event         = '',
                Operator      = '',
                TypeParameter = '',
            }
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
