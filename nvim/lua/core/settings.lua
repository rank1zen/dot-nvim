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

vim.o.statusline = '%<%f %h%m%r %{getbufvar(bufnr(), "minigit_summary_string")}%=%-14.(%l,%c%V%) %P'

vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
