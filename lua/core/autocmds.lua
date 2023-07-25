vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.lua" },
  callback = function(ev)
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.tex" },
  callback = function(ev)
    vim.o.conceallevel = 2
  end
})

vim.cmd 'colorscheme kanagawa'
