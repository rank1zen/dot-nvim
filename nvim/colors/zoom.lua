if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

local minihues = require('mini.hues')

local config = {
  background = '#ffffff',
  foreground = '#212121',
  saturation = 'high',
  plugins = { default = false, ['echasnovski/mini.nvim'] = true },
}

minihues.setup(config)

vim.g.colors_name = 'zoom'
