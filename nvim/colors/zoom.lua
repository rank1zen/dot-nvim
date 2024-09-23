if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

require('mini.hues').setup({
  background = '#ffffff',
  foreground = '#111111',
  saturation = 'high',
  plugins = { default = false, ['echasnovski/mini.nvim'] = true },
})

vim.g.colors_name = 'zoom'
