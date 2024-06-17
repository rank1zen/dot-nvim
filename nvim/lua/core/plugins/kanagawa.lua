require('kanagawa').setup({
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'NONE',
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
        Pmenu = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
})
