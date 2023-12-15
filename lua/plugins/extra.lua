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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    keys = {
      {
        '<leader>a',
        function() require('harpoon.mark').add_file() end,
      },
      {
        '<C-e>',
        function() require('harpoon.ui').toggle_quick_menu() end,
      },
    },
  },
}
