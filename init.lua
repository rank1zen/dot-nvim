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
end)

MiniDeps.now(function()
  MiniDeps.add('rebelot/kanagawa.nvim')
  require('kanagawa').setup({
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
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
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
    theme = 'wave',
    background = {
      dark = 'dragon',
      light = 'lotus',
    },
  })

  -- setup must be called before loading
  vim.cmd('colorscheme kanagawa')
MiniDeps.later(function()
  local miniclue = require('mini.clue')
  --stylua: ignore
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
      { mode = 'n', keys = '<Leader>' }, -- Leader triggers
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = '[' },        -- mini.bracketed
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'i', keys = '<C-x>' },    -- Built-in completion
      { mode = 'n', keys = 'g' },        -- `g` key
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },        -- Marks
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },        -- Registers
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },    -- Window commands
      { mode = 'n', keys = 'z' },        -- `z` key
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

MiniDeps.later(
  function()
    require('mini.pick').setup({
      window = {
        config = {
          border = 'rounded',
        },
        prompt_prefix = ' ',
      },
    })
  end
)

MiniDeps.later(function()
  require('mini.files').setup({
    content = {
      prefix = function() end,
    },
  })
end)

MiniDeps.later(function() require('mini.visits').setup() end)
MiniDeps.later(function() require('mini.extra').setup() end)

MiniDeps.later(function() require('mini.diff').setup() end)
MiniDeps.later(function() require('mini.git').setup() end)

MiniDeps.later(function()
  local hipatterns = require('mini.hipatterns')

  hipatterns.setup({
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

MiniDeps.now(function() MiniDeps.add('nvim-tree/nvim-web-devicons') end)

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
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
  })
end)

MiniDeps.later(function()
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup({
    ui = {
      border = 'rounded'
    }
  })
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      tex = { 'latexindent' },
    },
  })
end)

MiniDeps.now(function() MiniDeps.add('folke/neodev.nvim') end)

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')
  require('neodev').setup({})
  require('core.plugins.nvim-lspconfig')
end)

MiniDeps.later(function() MiniDeps.add('preservim/vimux') end)

MiniDeps.later(function()
  MiniDeps.add('vim-test/vim-test')
  vim.cmd([[let test#strategy = "vimux"]])
end)
