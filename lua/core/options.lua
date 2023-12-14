vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showcmd = true

vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.swapfile = false

vim.opt.path:remove("/usr/include")
vim.opt.path:append("**")

vim.diagnostic.config({
  signs = false,
})
