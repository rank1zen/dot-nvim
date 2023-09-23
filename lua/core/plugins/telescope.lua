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
          anchor = 'S',
        },
        width_padding = 0.2
      },
    },
    keys = {
      {
        '<leader>ff',
        function() require('telescope.builtin').find_files() end,
        desc = 'Telescope find files',
      },
      {
        '<leader>gf',
        function() require('telescope.builtin').git_files() end,
        desc = 'Telescope find Git files',
      },
      {
        '<Leader>fh',
        function() require('telescope.builtin').help_tags() end,
        desc = 'Telescope find help tags',
      },
      {
        '<Leader>fd',
        function() require('telescope.builtin').diagnostics() end,
        desc = 'Telescope diagnostics',
      },
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
