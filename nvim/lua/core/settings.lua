--stylua: ignore start

vim.g.mapleader = ' '

vim.o.autoindent     = true
vim.o.breakindent    = true
vim.o.expandtab      = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.pumheight      = 10
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2
vim.o.showmode       = false

-- stylua: ignore end

vim.filetype.add({
  extension = {
    templ = 'templ',
  },
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  },
})
