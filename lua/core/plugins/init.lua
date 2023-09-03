return {
  require('core.plugins.cmp'),
  require('core.plugins.treesitter'),
  require('core.plugins.lualine'),
  require('core.plugins.lspconfig'),
  require('core.plugins.telescope'),
  require('core.plugins.colorscheme'),
  require('core.plugins.latex'),
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {}
  },
  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    opts = {}
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {}
  }
}
