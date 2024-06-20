_G.Config = {}

_G.Config.borders = 'rounded'

--- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

MiniDeps.now(function() require('core.settings') end)
MiniDeps.now(function() require('core.functions') end)
MiniDeps.now(function() require('core.mappings') end)
MiniDeps.now(function() require('core.mappings-leader') end)

vim.cmd('colorscheme zoom')

-- MiniDeps.now(function()
--   MiniDeps.add('rebelot/kanagawa.nvim')
--   require('core.plugins.kanagawa')
--   -- vim.cmd('colorscheme kanagawa')
-- end)

MiniDeps.later(
  function()
    require('mini.notify').setup({
      window = { config = { border = _G.Config.borders } },
    })
  end
)

MiniDeps.now(function()
  require('mini.statusline').setup({
    content = {
      active = function()
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 140 })

        return MiniStatusline.combine_groups({
          { strings = { filename } },
          { strings = { git, diff, diagnostics } },
          '%<', -- Mark general truncate point
          '%=', -- End left alignment
          '%-14.(%l,%c%V%)',
          '%P',
        })
      end,
    },
  })
end)

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
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'i', keys = '<C-x>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },
    window = { config = { border = _G.Config.borders } },
  })
end)

MiniDeps.later(function()
  local miniai = require('mini.ai')
  miniai.setup({
    custom_textobjects = {
      F = miniai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    },
  })
end)

MiniDeps.later(function() require('mini.sessions').setup() end)
MiniDeps.later(function() require('mini.align').setup() end)
MiniDeps.later(function() require('mini.bracketed').setup() end)

MiniDeps.later(function() require('mini.surround').setup() end)
MiniDeps.later(function() require('mini.splitjoin').setup() end)
MiniDeps.later(function() require('mini.operators').setup() end)

MiniDeps.later(function()
  require('mini.completion').setup({
    delay = { completion = 100, info = 100, signature = 10 ^ 7 },
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        -- Don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = { info = { border = _G.Config.borders } },
  })
end)

MiniDeps.later(function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id
      vim.wo[win_id].winblend = 25
      vim.api.nvim_win_set_config(win_id, { border = _G.Config.borders })
    end,
  })

  require('mini.files').setup({
    content = {
      prefix = function() end,
    },
    options = {
      use_as_default_explorer = false,
    },
  })
end)

MiniDeps.later(function()
  require('mini.pairs').setup({})
  vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
end)

MiniDeps.later(function()
  local minipick = require('mini.pick')
  minipick.setup({
    source = {
      show = minipick.default_show,
    },
    window = {
      prompt_prefix = ' ',
      config = {
        border = _G.Config.borders,
      },
    },
  })

  vim.ui.select = MiniPick.ui_select
end)

MiniDeps.later(function()
  local minivisits = require('mini.visits')
  minivisits.setup({
    list = {
      sort = minivisits.gen_sort.z(),
    },
    store = {
      normalize = minivisits.gen_normalize.default(),
    },
  })
end)

MiniDeps.later(function() require('mini.diff').setup() end)
MiniDeps.later(function() require('mini.git').setup() end)
MiniDeps.later(function() require('mini.extra').setup() end)
MiniDeps.later(function() require('mini.bufremove').setup() end)
MiniDeps.later(function() require('mini.move').setup() end)

MiniDeps.later(function()
  local minihipatterns = require('mini.hipatterns')
  minihipatterns.setup({
    highlighters = {
      hex_color = minihipatterns.gen_highlighter.hex_color(),
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    },
  })
end)

MiniDeps.later(function()
  local minimap = require('mini.map')
  minimap.setup({
    integrations = {
      minimap.gen_integration.builtin_search(),
      minimap.gen_integration.diagnostic(),
      minimap.gen_integration.diff(),
    },
  })
end)

-- EXTRA PLUGINS

MiniDeps.later(function()
  MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  require('core.plugins.nvim-treesitter')
end)

MiniDeps.later(function()
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup()
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  require('core.plugins.conform')
end)

MiniDeps.now(function()
  MiniDeps.add('lervag/vimtex')
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_quickfix_ignore_filters = {
    -- HACK: OMEGA hack ignores latex errors for tufte-latex
    'Package xcolor Warning',
    'Marginpar on page',
  }
  vim.g.vimtex_syntax_conceal = {
    accents = 1,
    ligatures = 1,
    cites = 1,
    fancy = 0,
    spacing = 0,
    greek = 1,
    math_bounds = 0,
    math_delimiters = 1,
    math_fracs = 0,
    math_super_sub = 0,
    math_symbols = 1,
    sections = 0,
    styles = 0,
  }
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

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')
  require('core.plugins.nvim-lspconfig')
end)

MiniDeps.later(function()
  MiniDeps.add('kassio/neoterm')
  -- Don't add extra call to REPL when sending
  vim.g.neoterm_direct_open_repl = 1

  -- Open terminal to the right by default
  vim.g.neoterm_default_mod = 'vertical'

  -- Go into insert mode when terminal is opened
  vim.g.neoterm_autoinsert = 1

  -- Scroll to recent command when it is executed
  vim.g.neoterm_autoscroll = 1

  if vim.fn.executable('zsh') == 1 then vim.g.neoterm_shell = 'zsh' end
end)

MiniDeps.later(function()
  MiniDeps.add({ source = 'vim-test/vim-test', depends = { 'tpope/vim-dispatch' } })
  vim.cmd([[let test#strategy = 'neoterm']])
end)
