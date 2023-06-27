return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      disable_italics = true,
      disable_background = true,
      highlight_groups = {
        TelescopePromptNormal = { bg = 'surface' },
        TelescopePromptBorder = { fg = 'surface', bg = 'surface' },
        TelescopePromptTitle = { fg = 'surface' },

        TelescopeResultsNormal = { bg = 'surface' },
        TelescopeResultsBorder = { fg = 'surface', bg = 'surface' },
        TelescopeResultsTitle = { fg = 'surface' },

        TelescopePreviewNormal = { bg = 'base' },
        TelescopePreviewBorder = { bg = 'base', fg = 'base' },
        TelescopePreviewTitle = { fg = 'base' },
      }
    }
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = {},
      statementStyle = {},
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          TelescopePromptTitle = { fg = theme.ui.bg_p1 },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },

          TelescopeResultsTitle = { fg = theme.ui.bg_m1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },

          TelescopePreviewTitle = { fg = theme.ui.bg_dim },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
      theme = 'wave',
      background = {
        dark = 'dragon',
        light = 'lotus'
      }
    }
  }
}
