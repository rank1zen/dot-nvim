if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

require('mini.hues').setup({
  background = '#f5f5f5',
  foreground = '#363631',
  saturation = 'high',
})

vim.g.colors_name = "zoom"
