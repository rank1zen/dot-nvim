vim.cmd('lua MiniPairs.map_buf(0, "i", "$", {action = "closeopen", pair = "$$"})')
vim.cmd('setlocal conceallevel=2 linebreak')
vim.cmd('setlocal shiftwidth=4 tabstop=4')
