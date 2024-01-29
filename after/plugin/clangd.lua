local function start_clangd()
  local root_files = {
    "Makefile",
    "configure.ac",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja",
    '.git',
  }

  local paths = vim.fs.find(root_files, { stop = vim.env.HOME })

  vim.lsp.start({
    name = 'clangd',
    cmd = {
      "clangd",
      "--background-index",
      "--completion-style=bundled",
      "--fallback-style=llvm",
    },
    root_dir = vim.fs.dirname(paths[1]),
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = -1
    start_clangd()
  end
})
