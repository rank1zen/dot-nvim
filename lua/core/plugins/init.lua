return {
    require('core.plugins.cmp'),
    require('core.plugins.treesitter'),
    require('core.plugins.lualine'),

    require('core.plugins.lspconfig'),
    require('core.plugins.telescope'),
    require('core.plugins.colorscheme'),

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
    'folke/neodev.nvim',
}
