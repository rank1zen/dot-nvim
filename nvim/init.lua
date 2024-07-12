_G.Config = {}

_G.Config.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }

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

MiniDeps.now(function() require('core.settings') end)
MiniDeps.now(function() require('core.functions') end)
MiniDeps.now(function() require('core.mappings') end)
MiniDeps.now(function() require('core.mappings-leader') end)

vim.cmd('colorscheme zoom')

MiniDeps.later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    clues = {
      _G.Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'n', keys = 'g' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'n', keys = '"' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'x', keys = 'g' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'x', keys = '"' },
      { mode = 'x', keys = 'z' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'i', keys = '<C-x>' },
      { mode = 'c', keys = '<C-r>' },
    },
    window = { config = { border = _G.Config.borders } },
  })
end)

MiniDeps.later(function() require('mini.extra').setup() end)

MiniDeps.later(function()
  local miniai = require('mini.ai')
  local miniextra = require('mini.extra')

  miniai.setup({
    custom_textobjects = {
      C = miniai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
      F = miniai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      A = miniai.gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }),
      c = miniai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
      p = miniai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
      b = miniai.gen_spec.treesitter({ a = '@block.outer', i = '@block.inner' }),
      o = miniai.gen_spec.treesitter({
        a = { '@conditional.outer', '@loop.outer' },
        i = { '@conditional.inner', '@loop.inner' },
      }),
      B = miniextra.gen_ai_spec.buffer(),
      D = miniextra.gen_ai_spec.diagnostic(),
      I = miniextra.gen_ai_spec.indent(),
      L = miniextra.gen_ai_spec.line(),
      N = miniextra.gen_ai_spec.number(),
    },
  })
end)

MiniDeps.later(function()
  local minivisits = require('mini.visits')
  minivisits.setup({
    store = {
      normalize = minivisits.gen_normalize.default({
        decay_threshold = 200,
        decay_target = 200,
        prune_threshold = 0.9,
      }),
    },
  })
end)

MiniDeps.later(function()
  local minipick = require('mini.pick')
  minipick.setup({
    window = {
      prompt_cursor = '▏',
      prompt_prefix = ' ',
      config = {
        border = Config.borders,
      },
    },
  })

  require('core.pickers')

  vim.ui.select = MiniPick.ui_select
end)

MiniDeps.later(function() require('mini.diff').setup() end)
MiniDeps.later(function() require('mini.git').setup() end)

MiniDeps.later(function() require('mini.sessions').setup() end)
MiniDeps.later(function() require('mini.align').setup() end)
MiniDeps.later(function() require('mini.bracketed').setup() end)
MiniDeps.later(function() require('mini.surround').setup() end)
MiniDeps.later(function() require('mini.splitjoin').setup() end)
MiniDeps.later(function() require('mini.operators').setup() end)
MiniDeps.later(function() require('mini.bufremove').setup() end)
MiniDeps.later(function() require('mini.move').setup() end)

MiniDeps.later(function()
  require('mini.completion').setup({
    lsp_completion = {
      auto_setup = false,
      source_func = 'omnifunc',
      process_items = function(items, base)
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = _G.Config.borders },
      signature = { border = _G.Config.borders },
    },
  })
end)

MiniDeps.later(function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id
      vim.api.nvim_win_set_config(win_id, { border = _G.Config.borders })
    end,
  })

  require('mini.files').setup({
    options = {
      use_as_default_explorer = false,
    },
  })
end)

MiniDeps.later(function()
  require('mini.pairs').setup({})
  vim.keymap.set('i', '<CR>', 'v:lua.Config.cr_action()', { expr = true })
end)

MiniDeps.later(function()
  local minihipatterns = require('mini.hipatterns')
  minihipatterns.setup({
    highlighters = {
      hex_color = minihipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- EXTRA PLUGINS

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

MiniDeps.now(function()
  MiniDeps.add('nvim-orgmode/orgmode')
  require('core.plugins.orgmode')
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
