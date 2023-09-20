return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmds = { 'Telescope' },
    opts = {
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          height = 0.5,
          width = 0.5,
          anchor = 'SW',
        },
        prompt_prefix = '>  '
      },
    },
    keys = {
      {
        '<Leader>ff',
        function() require('telescope.builtin').find_files() end,
        desc = 'Telescope find files',
      },
      {
        '<Leader>gf',
        function() require('telescope.builtin').git_files() end,
        desc = 'Telescope find Git files',
      }
    }
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = true,
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('ui-select')
    end
  }
}
