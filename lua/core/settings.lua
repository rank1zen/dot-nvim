vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.o.termguicolors = true

vim.o.spelllang = 'en_us,en_ca'
vim.o.spelloptions = 'camel'
vim.opt.complete:append('kspell')
vim.opt.complete:remove('t')

vim.o.dictionary = vim.fn.stdpath('config') .. '/misc/dict/english.txt'
