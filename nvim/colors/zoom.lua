if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

require('mini.hues').setup({
  background = '#ffffff',
  foreground = '#212121',
  saturation = 'high',
  plugins = {
    default = false,
    ['echasnovski/mini.nvim'] = true,
  },
})

vim.api.nvim_set_hl(0, '@org.agenda.deadline', { fg = '#FFAAAA' })
vim.api.nvim_set_hl(0, '@org.agenda.scheduled', { fg = '#AAFFAA' })

vim.g.colors_name = "zoom"
