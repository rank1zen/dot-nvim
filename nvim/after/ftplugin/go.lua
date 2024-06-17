vim.opt_local.expandtab = false
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 8

vim.cmd('setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable')
