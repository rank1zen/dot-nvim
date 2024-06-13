_G.Config = {}

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
    spacing = 1,
    greek = 1,
    math_bounds = 1,
    math_delimiters = 1,
    math_fracs = 0,
    math_super_sub = 0,
    math_symbols = 1,
    sections = 0,
    styles = 1,
  }
end)

MiniDeps.now(function()
  MiniDeps.add('rebelot/kanagawa.nvim')
  require('kanagawa').setup({
    undercurl = true,
    transparent = true,
    colors = {
      palette = {},
      theme = {
        dragon = {
          ui = {
            bg_gutter = 'NONE',
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        Pmenu = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  })

  vim.cmd('colorscheme kanagawa-dragon')
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
    window = { config = { border = 'rounded' } },
  })
end)

MiniDeps.later(function() require('mini.ai').setup() end)
MiniDeps.later(function() require('mini.align').setup() end)
MiniDeps.later(function() require('mini.surround').setup() end)
MiniDeps.later(function() require('mini.splitjoin').setup() end)
MiniDeps.later(function() require('mini.operators').setup() end)
MiniDeps.later(function() require('mini.bracketed').setup() end)

MiniDeps.later(function() require('mini.sessions').setup() end)

MiniDeps.later(function()
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        -- Don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = 'rounded' },
      signature = { border = 'rounded' },
    },
  })
end)

MiniDeps.later(function()
  require('mini.pairs').setup()
  vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
end)

MiniDeps.later(function()
  local minipick = require('mini.pick')
  minipick.setup({
    source = {
      show = minipick.default_show,
    },
    window = {
      config = {
        border = 'rounded',
      },
      prompt_prefix = ': ',
    },
  })
end)

MiniDeps.later(function()
  vim.api.nvim_create_autocmd('User', {
    desc = 'Add rounded corners to minifiles window',
    pattern = 'MiniFilesWindowOpen',
    callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = 'rounded' }) end,
  })

  require('mini.files').setup({
    content = {
      prefix = function() end,
    },
  })
end)

MiniDeps.later(function()
  require('mini.visits').setup({
    store = {
      --normalize = MiniVisits.gen_normalize.default(),
    },
    track = {
      event = 'BufWritePre',
      delay = 20,
    },
  })
end)

MiniDeps.later(function() require('mini.diff').setup() end)
MiniDeps.later(function() require('mini.git').setup() end)

MiniDeps.later(function() require('mini.extra').setup() end)

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
  MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'fish',
      'gitcommit',
      'javascript',
      'json',
      'json5',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'rust',
      'scss',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'nix',
    },
    sync_install = false,
    auto_install = true,
    ignore_install = { 'latex' },
    highlight = {
      enable = true,
      disable = function(_, buf)
        -- Don't disable for read-only buffers.
        if not vim.bo[buf].modifiable then return false end

        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        -- Disable for files larger than 250 KB.
        return ok and stats and stats.size > (250 * 1024)
      end,
    },
    indent = { enable = true },
  })
end)

MiniDeps.later(function()
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup()
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      tex = { 'latexindent' },
      templ = { 'templ' },
    },
  })
end)

MiniDeps.later(function()
  MiniDeps.add('folke/lazydev.nvim')
  require('lazydev').setup({})
end)

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')
  require('core.plugins.nvim-lspconfig')
end)

MiniDeps.later(function() MiniDeps.add('preservim/vimux') end)

MiniDeps.later(function()
  MiniDeps.add('vim-test/vim-test')
  vim.cmd([[let test#strategy = "vimux"]])
end)
