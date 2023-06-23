return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 's',
          node_incremental = 's',
          node_decremental = 'S'
        }
      },
      autotag = {
        enable = true
      }
    }
  end
}
