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
  vim.o.expandtab      = true
  vim.o.pumheight      = 10
  vim.o.shiftwidth     = 2
  vim.o.tabstop        = 2
  -- stylua: ignore end

  vim.o.statusline = '%<%f %h%m%r %{getbufvar(bufnr(), "minigit_summary_string")}%= %-14.(%l,%c%V%) %P'

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

MiniDeps.now(function()
  local H = {}

  H.gen_opts = {}

  Config.mappings = {}

  local mapn = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
  end

  local mapx = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
  end

  mapn('ci', '<CMD>edit $MYVIMRC<CR>')

  Config.mappings.stack_previous = function() MiniVisits.iterate_paths('forward', nil, H.gen_opts.stack()) end
  Config.mappings.stack_next = function() MiniVisits.iterate_paths('backward', nil, H.gen_opts.stack()) end
  Config.mappings.stack_recent = function() MiniVisits.iterate_paths('first', nil, H.gen_opts.stack()) end
  Config.mappings.stack = function() MiniExtra.pickers.visit_paths(H.gen_opts.stack()) end

  -- stylua: ignore start
  mapn('es', '<CMD>lua Config.mappings.stack()<CR>')
  mapn('en', '<CMD>lua Config.mappings.stack_next()<CR>')
  mapn('ep', '<CMD>lua Config.mappings.stack_previous()<CR>')
  mapn('er', '<CMD>lua Config.mappings.stack_recent()<CR>')
  mapn('ez', '<CMD>Pick visit_paths sort=MiniVisits.gen_sort.z()<CR>')
  -- stylua: ignore end

  -- stylua: ignore start
  mapn('ef', '<Cmd>Pick files<CR>',                                       'Find files')
  mapn('ed', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'Open Explorer')
  mapn('el', '<Cmd>b#<CR>',                                               'Alternate file')

  mapn('fg', '<Cmd>Pick grep_live<CR>',              'Grep')
  mapn('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep (current word)')
  mapn('fh', '<Cmd>Pick help<CR>',                   'Help')
  mapn('fi', '<Cmd>Pick hipatterns<CR>',             'Hipatterns')
  mapn('fj', '<Cmd>Pick hl_groups<CR>',              'Highlight groups')
  mapn('f/', '<Cmd>Pick history scope="/"<CR>',      '"/"')
  mapn('f:', '<Cmd>Pick history scope=":"<CR>',      '":"')
  mapn('fH', '<Cmd>Pick commands<CR>',               'Commands')
  mapn('f.', '<Cmd>Pick resume<CR>',                 'Resume')
  mapn('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Pick Lines (all)')
  mapn('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Pick Lines (current)')
  mapn('fb', '<Cmd>Pick buffers<CR>', 'Pick Buffers')

  mapn('lq',  '<Cmd>lua vim.lsp.buf.definition()<CR>',                       'Definition')
  mapn('lt',  '<Cmd>lua vim.lsp.buf.type_definition()<CR>',                  'Type definition')
  mapn('lr',  '<Cmd>lua vim.lsp.buf.references()<CR>',                       'References')
  mapn('li',  '<Cmd>lua vim.lsp.buf.implementation()<CR>',                   'Implementation')
  mapn('ls',  '<Cmd>lua vim.lsp.buf.signature_help()<CR>',                   'Signature')
  mapn('lar', '<Cmd>lua vim.lsp.buf.rename()<CR>',                           'Rename')
  mapn('las', '<Cmd>lua vim.lsp.buf.code_action()<CR>',                      'Code Action')
  mapn('laf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format')
  mapx('laf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format Selection')
  mapn('lfo', '<Cmd>Pick lsp scope="document_symbol"<CR>',                   'Document symbol')
  mapn('lfw', '<Cmd>Pick lsp scope="workspace_symbol"<CR>',                  'Workspace symbol')
  mapn('lfq', '<Cmd>Pick lsp scope="definition"<CR>',                        'Definition')
  mapn('lfr', '<Cmd>Pick lsp scope="references"<CR>',                        'References')
  mapn('lfi', '<Cmd>Pick lsp scope="implementation"<CR>',                    'Implementation')
  mapn('lfu', '<Cmd>Pick lsp scope="declaration"<CR>',                       'Declaration')
  mapn('lft', '<Cmd>Pick lsp scope="type_definition"<CR>',                   'Type definition')
  mapn('lfd', '<Cmd>Pick diagnostic scope="all"<CR>',                        'Diagnostic (all)')
  mapn('lfD', '<Cmd>Pick diagnostic scope="current"<CR>',                    'Diagnostic (current)')
  mapn('lga', '<Cmd>lua Config.golang_test_file()<CR>', 'Switch Go _test')

  mapn('gcc', '<CMD>Git commit<CR>')
  mapn('gca', '<CMD>Git commit --amend<CR>')
  mapn('gbb', '<CMD>vert Git blame -- %<CR>')

  mapn('gczz', '<CMD>Git stash<CR>')
  mapn('gczw', '<CMD>Git stash --keep-index<CR>')
  mapn('gczA', '<CMD>Git stash apply<CR>')
  mapn('gczP', '<CMD>Git stash pop<CR>')

  mapn('gl', '<Cmd>Git log --oneline<CR>', 'Log (all)')
  mapn('gL', '<Cmd>Git log --oneline --follow -- %<CR>', 'Log (current)')
  mapn('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
  mapn('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')
  mapx('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')
  mapn('gaa', '<Cmd>Git add %<CR>', 'Add file')
  mapn('gfc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
  mapn('gfC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (current)')
  mapn('gfs', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
  mapn('gfS', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', 'Added hunks (current)')
  mapn('gfh', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
  mapn('gfH', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (current)')
  mapn('gfb', '<Cmd>Pick git_branches<CR>', 'Branches (all)')
  -- stylua: ignore end

  Config.golang_test_file = function()
    local file = vim.fn.expand('%')
    if #file <= 1 then
      vim.notify('no buffer name', vim.log.levels.ERROR)
      return
    end

    if string.find(file, '_test%.go$') then
      vim.cmd('edit ' .. string.gsub(file, '_test.go', '.go'))
    elseif string.find(file, '%.go$') then
      vim.cmd('edit ' .. vim.fn.expand('%:r') .. '_test.go')
    else
      vim.notify('not a go file', vim.log.levels.ERROR)
    end
  end

  H.gen_opts.stack = function()
    return {
      filter = function(path_data) return vim.fn.isdirectory(path_data.path) == 0 end,
      sort = MiniVisits.gen_sort.default({ recency_weight = 1 }),
    }
  end
end)

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
      I = miniextra.gen_ai_spec.indent(),
      L = miniextra.gen_ai_spec.line(),
    },
  }

  miniai.setup(opts)
end)

MiniDeps.later(function()
  require('mini.pick').setup({
    source = { show = require('mini.pick').default_show },
    window = { prompt_prefix = ' ', config = { border = Config.borders } },
    options = { content_from_bottom = true },
  })
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

MiniDeps.later(function() require('mini.jump2d').setup() end)

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

MiniDeps.later(function()
  MiniDeps.add('neovim/nvim-lspconfig')

  vim.diagnostic.config({
    virtual_text = {},
    float = { border = Config.borders, source = 'if_many' },
    signs = false,
  })

  local lspconfig = require('lspconfig')

  require('lspconfig.ui.windows').default_opts({ border = Config.borders })

  local default_config = {
    handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = Config.borders }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = Config.borders }),
    },
  }

  lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, default_config)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
  })

  lspconfig.lua_ls.setup({})

  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd

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
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup()
end)

MiniDeps.later(function()
  MiniDeps.add('stevearc/conform.nvim')
  local conform = require('conform')

  conform.setup({
    formatters_by_ft = {
      go = { 'gofumpt', 'goimports' },
      lua = { 'stylua' },
      nix = { 'alejandra' },
      sql = { 'sqlfluff' },
      templ = { 'templ' },
    },
  })
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
