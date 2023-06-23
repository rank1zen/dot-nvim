return {
  'rose-pine/neovim',
  priority = 1000,
  config = function()
    require('rose-pine').setup {
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

    vim.cmd 'colorscheme rose-pine'
  end
}
