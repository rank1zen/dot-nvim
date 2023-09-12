vim.keymap.set('n', 'L', '<cmd>bnext<CR>')
vim.keymap.set('n', 'H', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<Tab>', '<C-w>w')

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end)
