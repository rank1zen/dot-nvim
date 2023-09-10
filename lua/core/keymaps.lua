vim.keymap.set('n', 'L', '<cmd>bnext<CR>')
vim.keymap.set('n', 'H', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<Tab>', '<C-w>w')

vim.keymap.set('n', 'J', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)

vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end)
vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end)
vim.keymap.set('n', 'gq', function() require('telescope.builtin').diagnostics { bufnr = 0 } end)
vim.keymap.set('n', 'gs', function() require('telescope.builtin').lsp_document_symbols() end)

vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', '<leader>fr', function() vim.lsp.buf.format { async = true } end)
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end)
