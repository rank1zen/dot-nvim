return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = false,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { 'buffers', hide_filename_extension = true }
      },
      lualine_b = {},
      lualine_c = {
        'location',
        'branch',
        'filename',
        'diagnostics',
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
  }
}
