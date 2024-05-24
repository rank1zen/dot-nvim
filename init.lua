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
  MiniDeps.add('rose-pine/neovim')
  require('rose-pine').setup({
    styles = {
      bold = true,
      italic = false,
    },
    groups = {
      border = 'text',
    },
    before_highlight = function(group, highlight, palette)
      if highlight.bg == palette.base then highlight.bg = '#0d0d0d' end
      if highlight.bg == palette.surface then highlight.bg = '#181716' end
      if highlight.bg == palette.overlay then highlight.bg = '#302a27' end
      if highlight.fg == palette.rose then highlight.fg = '#ffd7b5' end
    end,
  })
  vim.cmd('colorscheme rose-pine')
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
      process_items = function(items, base)
        -- TODO: Fuzzy search? doesn't work that well

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

MiniDeps.later(function() require('mini.pick').setup() end)
MiniDeps.later(function() require('mini.visits').setup() end)
MiniDeps.later(function() require('mini.files').setup() end)
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
  require('mason').setup()
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  })
end)

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')
  require('core.plugins.nvim-lspconfig')
end)

MiniDeps.later(function()
  MiniDeps.add('preservim/vimux')
end)

MiniDeps.later(function()
  MiniDeps.add('vim-test/vim-test')
  vim.cmd([[let test#strategy = "vimux"]])
end)
