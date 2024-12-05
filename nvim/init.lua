_G.Cfg = {}

Cfg.leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

Cfg.xeader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

Cfg.maps = {}

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
  Cfg.borders = 'rounded'
  -- stylua: ignore start
  vim.g.mapleader      = ' '
  vim.g.maplocalleader = '\\'

  vim.o.autoindent     = true
  vim.o.expandtab      = true
  vim.o.pumheight      = 10
  vim.o.shiftwidth     = 2
  vim.o.tabstop        = 2
  vim.o.showmode       = false
  -- stylua: ignore end

  vim.o.statusline = '%<%f %{getbufvar(bufnr(), "minigit_summary_string")} %h%m%r %= %-14.(%l,%c%V%) %P'

  vim.filetype.add({
    extension = { templ = 'templ' },
    pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  })
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

vim.cmd('colorscheme zoom')

MiniDeps.later(function() require('mini.extra').setup() end)

MiniDeps.now(function()
  Cfg.leader('en', '<cmd>lua Cfg.maps.stack_next()<cr>')
  Cfg.leader('ep', '<cmd>lua Cfg.maps.stack_prev()<cr>')
  Cfg.leader('er', '<cmd>lua Cfg.maps.stack_recent()<cr>')
  -- stylua: ignore start
  Cfg.leader('ei', '<cmd>edit $MYVIMRC<cr>',                                    'Go to init.lua')
  Cfg.leader('eg', '<cmd>Pick grep_live<cr>',                                   'Live grep')
  Cfg.leader('eh', '<cmd>Pick help<cr>',                                        'List help files')
  Cfg.leader('es', '<cmd>Pick visit_paths recency_weight=1<cr>',                'List the MRU file stack')
  Cfg.leader('ez', '<cmd>Pick visit_paths sort=MiniVisits.gen_sort.z()<cr>',    'List the Z file stack')
  Cfg.leader('ef', '<cmd>Pick files<cr>',                                       'List directory files')
  Cfg.leader('ed', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', 'Open the file explorer')
  Cfg.leader('e.', '<cmd>Pick resume<cr>',                                      'Resume most recent picker')
  Cfg.leader('eq', '<cmd>Pick list scope="jump"<cr>',                           'List the jumplist')
  Cfg.leader('ew', '<cmd>Pick grep pattern="<cword>"<cr>',                      'Grep current word')
  Cfg.leader('et', '<cmd>Pick history scope=":"<cr>',                           'List command history')
  -- stylua: ignore end
end)

MiniDeps.later(function() require('mini.visits').setup() end)

MiniDeps.later(function()
  local miniai, miniextra = require('mini.ai'), require('mini.extra')

  local opts = {
    custom_textobjects = {
      -- stylua: ignore start
      C = miniai.gen_spec.treesitter({ a = '@class.outer',       i = '@class.inner' }),
      F = miniai.gen_spec.treesitter({ a = '@function.outer',    i = '@function.inner' }),
      P = miniai.gen_spec.treesitter({ a = '@parameter.outer',   i = '@parameter.inner' }),
      l = miniai.gen_spec.treesitter({ a = '@loop.outer',        i = '@loop.inner' }),
      o = miniai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
      -- stylua: ignore end
      I = miniextra.gen_ai_spec.indent(),
      L = miniextra.gen_ai_spec.line(),
    },
  }

  miniai.setup(opts)
end)

MiniDeps.later(function()
  local pick = require('mini.pick')
  local spec = {
    options = { content_from_bottom = true },
    source = { show = pick.default_show },
    window = {
      prompt_prefix = '',
      prompt_cursor = '█ ',
      config = function()
        return {
          height = math.floor(0.5 * vim.o.lines),
          width = vim.o.columns,
          row = 0,
          col = 0,
          border = { ' ', ' ', ' ', ' ', ' ', '─', ' ', ' ' },
        }
      end,
    },
  }
  pick.setup(spec)
end)

MiniDeps.later(function()
  require('mini.files').setup({
    content = { prefix = function() end },
    options = { permanent_delete = true, use_as_default_explorer = false },
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)
      config.border = Cfg.borders
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
      info = { border = Cfg.borders },
      signature = { border = Cfg.borders },
    },
  }

  completion.setup(opts)
end)

MiniDeps.later(function() require('mini.jump2d').setup() end)

MiniDeps.now(function()
  -- stylua: ignore start
  Cfg.leader('gcc',  '<cmd>Git commit<cr>',                               'Create a commit')
  Cfg.leader('gca',  '<cmd>Git commit --amend<cr>',                       'Amend the last commit and edit the message')

  Cfg.leader('gbb',  '<cmd>vert Git blame -- %<cr>')

  Cfg.leader('gczz', '<cmd>Git stash<cr>',                                'Push stash')
  Cfg.leader('gczw', '<cmd>Git stash --keep-index<cr>',                   'Push stash of the work-tree')

  Cfg.leader('ghu',  '<cmd>Pick git_hunks scope="unstaged"<cr>',          'List unstaged hunks')
  Cfg.leader('ghU',  '<cmd>Pick git_hunks scope="unstaged" path="%"<cr>', 'List unstaged hunks of current file')
  -- stylua: ignore end
end)

MiniDeps.later(function() require('mini.diff').setup() end)

MiniDeps.later(function()
  require('mini.git').setup()

  local align_blame = function(au_data)
    if au_data.data.git_subcommand ~= 'blame' then return end

    -- Align blame output with source
    local win_src = au_data.data.win_source
    vim.wo.wrap = false
    vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

    -- Bind both windows so that they scroll together
    vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
  end

  vim.api.nvim_create_autocmd('User', { pattern = 'MiniGitCommandSplit', callback = align_blame })
end)

MiniDeps.later(function() require('mini.pairs').setup() end)
MiniDeps.later(function() require('mini.align').setup() end)
MiniDeps.later(function() require('mini.jump').setup() end)
MiniDeps.later(function() require('mini.operators').setup() end)
MiniDeps.later(function() require('mini.splitjoin').setup() end)
MiniDeps.later(function() require('mini.surround').setup() end)
MiniDeps.later(function() require('mini.trailspace').setup() end)

MiniDeps.later(function()
  MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    monitor = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  MiniDeps.add('nvim-treesitter/nvim-treesitter-textobjects')

  require('nvim-treesitter.configs').setup({
    ensure_installed = { },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(_, buf)
        if not vim.bo[buf].modifiable then return false end
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > (250 * 1024)
      end,
    },
    indent = { enable = false },
    textobjects = {
      enable = true,
    },
  })
end)

MiniDeps.now(function()
  -- stylua: ignore start
  Cfg.leader('lq',  '<cmd>lua vim.lsp.buf.definition()<cr>',                       'Definition')
  Cfg.leader('lt',  '<cmd>lua vim.lsp.buf.type_definition()<cr>',                  'Type definition')
  Cfg.leader('lr',  '<cmd>lua vim.lsp.buf.references()<cr>',                       'References')
  Cfg.leader('li',  '<cmd>lua vim.lsp.buf.implementation()<cr>',                   'Implementation')
  Cfg.leader('ls',  '<cmd>lua vim.lsp.buf.signature_help()<cr>',                   'Signature')

  Cfg.leader('lfo', '<cmd>Pick lsp scope="document_symbol"<cr>',                   'Document symbol')
  Cfg.leader('lfw', '<cmd>Pick lsp scope="workspace_symbol"<cr>',                  'Workspace symbol')

  Cfg.leader('lfq', '<cmd>Pick lsp scope="definition"<cr>',                        'Definition')
  Cfg.leader('lfr', '<cmd>Pick lsp scope="references"<cr>',                        'References')
  Cfg.leader('lfi', '<cmd>Pick lsp scope="implementation"<cr>',                    'Implementation')
  Cfg.leader('lfu', '<cmd>Pick lsp scope="declaration"<cr>',                       'Declaration')
  Cfg.leader('lft', '<cmd>Pick lsp scope="type_definition"<cr>',                   'Type definition')

  Cfg.leader('lfd', '<cmd>Pick diagnostic scope="all"<cr>',                        'Diagnostic (all)')
  Cfg.leader('lfD', '<cmd>Pick diagnostic scope="current"<cr>',                    'Diagnostic (current)')

  Cfg.leader('lar', '<cmd>lua vim.lsp.buf.rename()<cr>',                           'Rename')
  Cfg.leader('las', '<cmd>lua vim.lsp.buf.code_action()<cr>',                      'Code Action')

  Cfg.leader('laf', '<cmd>lua require("conform").format()<cr>', 'Format')
  Cfg.xeader('laf', '<cmd>lua require("conform").format()<cr>', 'Format Selection')

  Cfg.leader('lga', '<cmd>lua Cfg.maps.golang_test_file()<cr>',                         'Switch Go _test')
  -- stylua: ignore end
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')

  local conform = require('conform')

  local spec = {
    formatters_by_ft = {
      -- stylua: ignore start
      go    = { 'goimports', 'gofumpt' },
      lua   = { 'stylua' },
      nix   = { 'alejandra' },
      templ = { 'templ' },
      -- stylua: ignore end
    },
  }

  conform.setup(spec)
end)

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')

  vim.diagnostic.config({
    virtual_text = {},
    float = { border = Cfg.borders, source = 'if_many' },
    signs = false,
  })

  local lspconfig = require('lspconfig')

  require('lspconfig.ui.windows').default_opts({ border = Cfg.borders })

  local default_config = {
    handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = Cfg.borders }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = Cfg.borders }),
    },
  }

  lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, default_config)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
  })

  lspconfig.lua_ls.setup({})

  lspconfig.gopls.setup({
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
        semanticTokens = true,
      },
    },
  })

  lspconfig.templ.setup({})

  lspconfig.tailwindcss.setup({
    filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
    init_options = { userLanguages = { templ = 'html' } },
  })

  lspconfig.pyright.setup({})

  lspconfig.ccls.setup({})

  lspconfig.texlab.setup({})
end)

MiniDeps.later(function()
  MiniDeps.add('folke/lazydev.nvim')
  require('lazydev').setup({})
end)

local H = {}

Cfg.maps.golang_test_file = function()
  local file = vim.fn.expand('%')
  if #file <= 1 then
    vim.notify('(cfg) no buffer name', vim.log.levels.ERROR)
    return
  end

  if string.find(file, '_test%.go$') then
    vim.cmd('edit ' .. string.gsub(file, '_test.go', '.go'))
  elseif string.find(file, '%.go$') then
    vim.cmd('edit ' .. vim.fn.expand('%:r') .. '_test.go')
  else
    vim.notify('(cfg) not a go file', vim.log.levels.ERROR)
  end
end

H.stack_opts = function()
  return {
    filter = function(path_data) return vim.fn.isdirectory(path_data.path) == 0 end,
    sort = MiniVisits.gen_sort.default({ recency_weight = 1 }),
  }
end

Cfg.maps.stack_prev = function()
  MiniVisits.iterate_paths('forward', nil, H.stack_opts())
end

Cfg.maps.stack_next = function()
  MiniVisits.iterate_paths('backward', nil, H.stack_opts())
end

Cfg.maps.stack_recent = function()
  MiniVisits.iterate_paths('first', nil, H.stack_opts())
end
