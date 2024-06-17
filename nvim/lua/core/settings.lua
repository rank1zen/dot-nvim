--stylua: ignore start
vim.g.mapleader = ' '

vim.o.autoindent     = true
vim.o.breakindent    = true
vim.o.expandtab      = true
vim.o.number         = true
vim.o.pumblend       = 10
vim.o.pumheight      = 10
vim.o.relativenumber = true
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2

-- stylua: ignore end

vim.filetype.add({
  extension = {
    templ = 'templ',
  },
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  },
})
