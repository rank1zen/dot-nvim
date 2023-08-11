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
  }
}
