return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = true,
  opts = {
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = {
        height = 0.45,
        anchor = 'S',
      },
      scroll_strategy = 'limit',
      prompt_prefix = '>  '
    }
  },
  keys = {
    {
      '<Leader>ff',
      function() require('telescope.builtin').find_files() end,
      desc = 'Telescope find files',
    },
    {
      '<Leader>fF',
      function() require('telescope.builtin').git_files() end,
      desc = 'Telescope find Git files',
    },
  }
}
