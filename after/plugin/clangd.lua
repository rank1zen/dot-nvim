local function start_clangd()
  local root_files = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  }
  local paths = vim.fs.find(root_files, { stop = vim.env.HOME })

  vim.lsp.start({
    name = 'clangd',
    cmd = { 'clangd' },
    root_dir = vim.fs.dirname(paths[1]),
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = -1
    start_clangd()
  end
})
