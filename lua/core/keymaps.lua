vim.keymap.set('n', 'L', '<cmd>bnext<CR>')
vim.keymap.set('n', 'H', '<cmd>bprevious<CR>')

vim.keymap.set('n', 'J', vim.diagnostic.open_float)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gd', builtin.lsp_definitions)
vim.keymap.set('n', 'gr', builtin.lsp_references)
vim.keymap.set('n', 'gq', function() builtin.diagnostics { bufnr = 0 } end)
vim.keymap.set('n', 'gs', builtin.lsp_document_symbols)

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>fr', function() vim.lsp.buf.format { async = true } end)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
