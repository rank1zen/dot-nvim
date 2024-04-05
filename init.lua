local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
    vim.opt.softtabstop = -1
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "lua" },
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = -1
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf })
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = ev.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = ev.buf })
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = ev.buf })
    vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format({ async = true }) end, { buffer = ev.buf })
  end,
})

vim.diagnostic.config({ signs = false })

local plugins = {
  'neovim/nvim-lspconfig',
  'echasnovski/mini.nvim',
  'ctrlpvim/ctrlp.vim',
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        italic = false,
        bold = true,
        transparency = true,
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      highlight = { enable = true },
    },
  },
}

vim.g.ctrlp_map = '<C-e>'
vim.g.ctrlp_cmd = 'CtrlPMRU'
vim.g.ctrlp_mruf_relative = 1

require('lazy').setup(plugins)

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({})

lspconfig.gopls.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=webkit",
  },
}

lspconfig.pyright.setup {
  {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  }
}

lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.completion').setup {
  delay = { completion = 20, info = 20, signature = 100 },
}

vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

vim.cmd('colorscheme rose-pine')
