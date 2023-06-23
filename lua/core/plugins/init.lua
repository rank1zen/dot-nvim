return {
  require('core.plugins.cmp'),
  require('core.plugins.treesitter'),
  require('core.plugins.lualine'),

  require('core.plugins.lspconfig'),
  require('core.plugins.telescope'),
  require('core.plugins.colorscheme'),
  require('core.plugins.flash'),
  require('core.plugins.autopairs'),

  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {}
  }

}
