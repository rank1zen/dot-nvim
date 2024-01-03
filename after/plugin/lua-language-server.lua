local function start_lua_ls()
  local root_files = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml",
    "selene.yml", ".git" }
  local paths = vim.fs.find(root_files, { stop = vim.env.HOME })

  vim.lsp.start({
    name = 'lua-language-server',
    cmd = { "lua-language-server" },
    root_dir = vim.fs.dirname(paths[1]),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      }
    }
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "lua" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = -1
    start_lua_ls()
  end
})
