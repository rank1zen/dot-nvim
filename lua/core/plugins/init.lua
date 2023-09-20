return {
  require('core.plugins.treesitter'),
  require('core.plugins.lualine'),
  require('core.plugins.lspzero'),
  require('core.plugins.telescope'),
  require('core.plugins.colorscheme'),
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
    'lewis6991/gitsigns.nvim',
    opts = {
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, { buffer = bufnr })
      end
    }
  }
}
