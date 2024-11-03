_G.Config = {}

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup({ path = { package = path_package } })

MiniDeps.now(function()
  Config.borders = 'rounded'
  -- stylua: ignore start
  vim.g.mapleader      = ' '
  vim.g.maplocalleader = '\\'

  vim.o.autoindent     = true
  vim.o.breakindent    = true
  vim.o.expandtab      = true
  vim.o.number         = true
  vim.o.relativenumber = true
  vim.o.pumheight      = 10
  vim.o.shiftwidth     = 2
  vim.o.tabstop        = 2
  vim.o.showmode       = false
  vim.o.scrolloff      = 999
  -- stylua: ignore end

  vim.o.statusline = '%<%f %h%m%r %{getbufvar(bufnr(), "minigit_summary_string")}%= %-14.(%l,%c%V%) %P'

  vim.filetype.add({
    extension = { templ = 'templ' },
    pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  })
end)

MiniDeps.now(function()
  vim.keymap.set('i', '<C-a>', '<C-o>A')
end)

MiniDeps.now(function()
  local keys = {
    ['cr'] = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y'] = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
      return require('mini.pairs').cr()
    end
  end

  vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
  vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
end)

MiniDeps.now(function() require('core.mappings') end)

vim.cmd('colorscheme zoom')

MiniDeps.later(function() require('mini.extra').setup() end)

MiniDeps.later(function()
  local miniai, miniextra = require('mini.ai'), require('mini.extra')

  local opts = {
    custom_textobjects = {
      -- stylua: ignore start
      C = miniai.gen_spec.treesitter({ a = '@class.outer',       i = '@class.inner' }),
      F = miniai.gen_spec.treesitter({ a = '@function.outer',    i = '@function.inner' }),
      c = miniai.gen_spec.treesitter({ a = '@comment.outer',     i = '@comment.inner' }),
      p = miniai.gen_spec.treesitter({ a = '@parameter.outer',   i = '@parameter.inner' }),
      b = miniai.gen_spec.treesitter({ a = '@block.outer',       i = '@block.inner' }),
      l = miniai.gen_spec.treesitter({ a = '@loop.outer',        i = '@loop.inner' }),
      o = miniai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
      -- stylua: ignore end
      B = miniextra.gen_ai_spec.buffer(),
      I = miniextra.gen_ai_spec.indent(),
      L = miniextra.gen_ai_spec.line(),
    },
  }

  miniai.setup(opts)
end)

MiniDeps.later(function()
  require('mini.pick').setup({
    window = { prompt_prefix = ' ' },
  })
end)

MiniDeps.later(function()
  require('mini.files').setup({
    content = { prefix = function() end },
    options = { permanent_delete = true, use_as_default_explorer = false },
  })

  -- there are more things you can do with auto commands
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)
      config.border = Config.borders
      vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
  })
end)

MiniDeps.later(function()
  local completion = require('mini.completion')

  local opts = {
    lsp_completion = {
      auto_setup = false,
      source_func = 'omnifunc',
      process_items = function(items, base)
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return completion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = Config.borders },
      signature = { border = Config.borders },
    },
  }

  completion.setup(opts)
end)

MiniDeps.later(function()
  local jump2d = require('mini.jump2d')

  local opts = {
    mappings = { start_jumping = '' },
  }

  jump2d.setup(opts)
end)

MiniDeps.later(function()
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      hex_colour = hipatterns.gen_highlighter.hex_color(),
      fixme = { pattern = '%f[%S]FIXME%f[:]', group = 'MiniHipatternsFixme' },
      todo = { pattern = '%f[%S]TODO%f[:]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%S]NOTE%f[:]', group = 'MiniHipatternsNote' },
    },
  })
end)

MiniDeps.later(function() require('mini.pairs').setup() end)
MiniDeps.later(function() require('mini.align').setup() end)
MiniDeps.later(function() require('mini.diff').setup() end)
MiniDeps.later(function() require('mini.git').setup() end)
MiniDeps.later(function() require('mini.jump').setup() end)
MiniDeps.later(function() require('mini.operators').setup() end)
MiniDeps.later(function() require('mini.splitjoin').setup() end)
MiniDeps.later(function() require('mini.surround').setup() end)
MiniDeps.later(function() require('mini.visits').setup() end)
MiniDeps.later(function() require('mini.trailspace').setup() end)

MiniDeps.later(function()
  MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    monitor = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  MiniDeps.add('nvim-treesitter/nvim-treesitter-textobjects')

  require('core.plugins.nvim-treesitter')
end)

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')
  require('core.plugins.nvim-lspconfig')
end)

MiniDeps.later(function()
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup()
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  require('core.plugins.conform')
end)

MiniDeps.later(function()
  MiniDeps.add({
    source = 'L3MON4D3/LuaSnip',
    depends = { 'rafamadriz/friendly-snippets' },
  })

  require('luasnip.loaders.from_vscode').lazy_load()

  local ls = require('luasnip')

  vim.keymap.set({ 'i' }, '<C-K>', function() ls.expand() end, { silent = true })
  vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, { silent = true })
  vim.keymap.set({ 'i', 's' }, '<C-J>', function() ls.jump(-1) end, { silent = true })

  vim.keymap.set({ 'i', 's' }, '<C-E>', function()
    if ls.choice_active() then ls.change_choice(1) end
  end, { silent = true })
end)

MiniDeps.later(function()
  MiniDeps.add('folke/lazydev.nvim')
  require('lazydev').setup({})
end)
