return {
    require('core.plugins.cmp'),
    require('core.plugins.treesitter'),
    require('core.plugins.lualine'),

    require('core.plugins.lspconfig'),
    require('core.plugins.telescope'),
    require('core.plugins.colorscheme'),

    'SmiteshP/nvim-navic',
    'folke/neodev.nvim',

    {
        'FluxxField/bionic-reading.nvim',
        config = function()
            require('bionic-reading').setup {
                hl_group_value = {
                    bold = true,
                },
                prompt_user = false
            }
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = true
    },
    {
        'xeluxee/competitest.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
            require('competitest').setup {}
        end
    },
}
