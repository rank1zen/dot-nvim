if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end

local minihues = require('mini.hues')

local config = {
  background = '#ffffff',
  foreground = '#212121',
  saturation = 'high',
  plugins = {
    default = false,
    ['echasnovski/mini.nvim'] = true,
  },
}

minihues.setup(config)
local p = minihues.make_palette(config)

local hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end

-- stylua: ignore start

hi('@org.headline.level1', { fg=p.fg,     bg=nil, bold=true })
hi('@org.headline.level2', { link='@org.headline.level1' })
hi('@org.headline.level3', { link='@org.headline.level1' })
hi('@org.headline.level4', { link='@org.headline.level1' })
hi('@org.headline.level5', { link='@org.headline.level1' })
hi('@org.headline.level6', { link='@org.headline.level1' })
hi('@org.headline.level7', { link='@org.headline.level1' })
hi('@org.headline.level8', { link='@org.headline.level1' })
hi('@org.agenda.deadline', { fg=p.purple, bg=nil })
hi('@org.agenda.day',      { fg=p.fg,     bg=nil })
hi('@org.agenda.today',    { fg=p.fg,     bg=nil, bold=true })
hi('@org.agenda.weekend',  { link='@org.agenda.day' })

vim.g.colors_name = 'zoom'
