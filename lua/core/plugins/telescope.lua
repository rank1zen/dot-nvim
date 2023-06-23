return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
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
  }
}
