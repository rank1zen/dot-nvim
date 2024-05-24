vim.o.autoindent = true
vim.o.smartindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1

-- vim.o.termguicolors = true

vim.filetype.add({
  extension = {
    templ = 'templ',
  },
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  },
})
