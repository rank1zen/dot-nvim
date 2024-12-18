if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = 'aog'

require('mini.base16').setup({
  palette = {
    base00 = '#fdf6e3',
    base01 = '#eee8d5',
    base02 = '#c0c4bb',
    base03 = '#93a1a1',
    base04 = '#839496',
    base05 = '#657b83',
    base06 = '#586e75',
    base07 = '#002b36',
    base08 = '#dc322f',
    base09 = '#cb4b16',
    base0A = '#b58900',
    base0B = '#859900',
    base0C = '#2aa198',
    base0D = '#268bd2',
    base0E = '#6c71c4',
    base0F = '#d33682',
  },
  use_cterm = true,
  plugins = { default = false, ['echasnovski/mini.nvim'] = true },
})
