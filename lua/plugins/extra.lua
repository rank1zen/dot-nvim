return {
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
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      disable_italics = true,
      disable_background = true,
      disable_float_background = true
    }
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    keys = {
      {
        '<leader>a',
        function () require('harpoon.mark').add_file() end,
      },
      {
        '<C-e>',
        function () require('harpoon.ui').toggle_quick_menu() end,
      },
    },
  }
}
