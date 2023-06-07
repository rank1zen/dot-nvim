return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',

        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local super_tab_next = function(fallback)
            if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end

        local super_tab_prev = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end

        local tab_next = function()
            if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
                cmp.complete()
            end
        end

        local tab_prev = function()
            if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
                cmp.complete()
            end
        end

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert {
                ['<CR>'] = { i = cmp.mapping.confirm { select = false } },
                ['<Tab>'] = cmp.mapping(super_tab_next, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(super_tab_prev, { 'i', 's' }),
                ['<C-Space>'] = { i = cmp.mapping.complete() }
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lsp_signature_help' }
            }
        }

        cmp.setup.cmdline({ ':' }, {
            mapping = cmp.mapping.preset.cmdline {
                ['<CR>'] = { c = cmp.mapping.confirm { select = false } },
                ['<Tab>'] = { c = tab_next },
                ['<S-Tab>'] = { c = tab_prev }
            },
            sources = {
                { name = 'cmdline' },
                { name = 'path' }
            }
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline {
                ['<CR>'] = { c = cmp.mapping.confirm { select = false } },
                ['<Tab>'] = { c = tab_next },
                ['<S-Tab>'] = { c = tab_prev }
            },
            sources = {
                { name = 'buffer' }
            }
        })
    end
}
