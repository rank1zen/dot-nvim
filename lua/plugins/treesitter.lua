return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 's',
        node_incremental = 's',
        node_decremental = 'S'
      }
    }
  },
}
