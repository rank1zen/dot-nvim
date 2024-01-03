local function start_gopls()
  local root_files = { "go.work", "go.mod", ".git" }
  local paths = vim.fs.find(root_files, { stop = vim.env.HOME })

  vim.lsp.start({
    name = 'gopls',
    cmd = { "gopls" },
    root_dir = vim.fs.dirname(paths[1]),
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    start_gopls()
  end
})
