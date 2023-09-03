return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = false,
      section_separators = '',
      component_separators = '',
      globalstatus = true
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'buffers',
          hide_filename_extension = true,
          symbols = { alternate_file = '' },
        },
        'location',
        'branch',
        'filename',
        'diagnostics'
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
  }
}
