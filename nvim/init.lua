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

MiniDeps.now(function() vim.keymap.set('i', '<C-a>', '<C-o>A') end)

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

  local nmap_leader = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
  end

  local xmap_leader = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
  end

  nmap_leader('ci', '<CMD>edit $MYVIMRC<CR>')

  -- stylua: ignore start
  nmap_leader('jl', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<CR>')
  nmap_leader('jw', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>', '')
  nmap_leader('jc', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>')
  nmap_leader('jf', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.query)<CR>')
  xmap_leader('jl', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<CR>')
  xmap_leader('jw', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>')
  xmap_leader('jc', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>')
  xmap_leader('jf', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.query)<CR>')
  -- stylua: ignore end

  Config.mappings.stack_previous = function() MiniVisits.iterate_paths('forward', nil, H.gen_opts.stack()) end
  Config.mappings.stack_next = function() MiniVisits.iterate_paths('backward', nil, H.gen_opts.stack()) end
  Config.mappings.stack_recent = function() MiniVisits.iterate_paths('first', nil, H.gen_opts.stack()) end
  Config.mappings.stack = function() MiniExtra.pickers.visit_paths(H.gen_opts.stack()) end

  -- stylua: ignore start
  nmap_leader('es', '<CMD>lua Config.mappings.stack()<CR>')
  nmap_leader('en', '<CMD>lua Config.mappings.stack_next()<CR>')
  nmap_leader('ep', '<CMD>lua Config.mappings.stack_previous()<CR>')
  nmap_leader('er', '<CMD>lua Config.mappings.stack_recent()<CR>')
  nmap_leader('ez', '<CMD>Pick visit_paths sort=MiniVisits.gen_sort.z()<CR>')
  -- stylua: ignore end

  -- stylua: ignore start
  nmap_leader('ef', '<Cmd>Pick files<CR>',                                       'Find files')
  nmap_leader('ed', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'Open Explorer')
  nmap_leader('el', '<Cmd>b#<CR>',                                               'Alternate file')

  nmap_leader('fg', '<Cmd>Pick grep_live<CR>',              'Grep')
  nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep (current word)')
  nmap_leader('fh', '<Cmd>Pick help<CR>',                   'Help')
  nmap_leader('fi', '<Cmd>Pick hipatterns<CR>',             'Hipatterns')
  nmap_leader('fj', '<Cmd>Pick hl_groups<CR>',              'Highlight groups')
  nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',      '"/"')
  nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',      '":"')
  nmap_leader('fH', '<Cmd>Pick commands<CR>',               'Commands')
  nmap_leader('f.', '<Cmd>Pick resume<CR>',                 'Resume')
  nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Pick Lines (all)')
  nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Pick Lines (current)')
  nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Pick Buffers')

  nmap_leader('lq',  '<Cmd>lua vim.lsp.buf.definition()<CR>',                       'Definition')
  nmap_leader('lt',  '<Cmd>lua vim.lsp.buf.type_definition()<CR>',                  'Type definition')
  nmap_leader('lr',  '<Cmd>lua vim.lsp.buf.references()<CR>',                       'References')
  nmap_leader('li',  '<Cmd>lua vim.lsp.buf.implementation()<CR>',                   'Implementation')
  nmap_leader('ls',  '<Cmd>lua vim.lsp.buf.signature_help()<CR>',                   'Signature')
  nmap_leader('lar', '<Cmd>lua vim.lsp.buf.rename()<CR>',                           'Rename')
  nmap_leader('las', '<Cmd>lua vim.lsp.buf.code_action()<CR>',                      'Code Action')
  nmap_leader('laf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format')
  xmap_leader('laf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format Selection')
  nmap_leader('lfo', '<Cmd>Pick lsp scope="document_symbol"<CR>',                   'Document symbol')
  nmap_leader('lfw', '<Cmd>Pick lsp scope="workspace_symbol"<CR>',                  'Workspace symbol')
  nmap_leader('lfq', '<Cmd>Pick lsp scope="definition"<CR>',                        'Definition')
  nmap_leader('lfr', '<Cmd>Pick lsp scope="references"<CR>',                        'References')
  nmap_leader('lfi', '<Cmd>Pick lsp scope="implementation"<CR>',                    'Implementation')
  nmap_leader('lfu', '<Cmd>Pick lsp scope="declaration"<CR>',                       'Declaration')
  nmap_leader('lft', '<Cmd>Pick lsp scope="type_definition"<CR>',                   'Type definition')
  nmap_leader('lfd', '<Cmd>Pick diagnostic scope="all"<CR>',                        'Diagnostic (all)')
  nmap_leader('lfD', '<Cmd>Pick diagnostic scope="current"<CR>',                    'Diagnostic (current)')
  nmap_leader('lga', '<Cmd>lua Config.golang_test_file()<CR>', 'Switch Go _test')

  nmap_leader('gl', '<Cmd>Git log --oneline<CR>', 'Log (all)')
  nmap_leader('gL', '<Cmd>Git log --oneline --follow -- %<CR>', 'Log (current)')
  nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
  nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')
  xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')
  nmap_leader('gaa', '<Cmd>Git add %<CR>', 'Add file')
  nmap_leader('gac', '<Cmd>Git commit<CR>', 'Commit')
  nmap_leader('gaC', '<Cmd>Git commit --amend<CR>', 'Commit amend')
  nmap_leader('gfc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
  nmap_leader('gfC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (current)')
  nmap_leader('gfs', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
  nmap_leader('gfS', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', 'Added hunks (current)')
  nmap_leader('gfh', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
  nmap_leader('gfH', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (current)')
  nmap_leader('gfb', '<Cmd>Pick git_branches<CR>', 'Branches (all)')
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

  local show_gitfiles = false
  local toggle_gitfiles = function()
    show_gitfiles = not show_gitfiles
    local new_filter = 0
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args) vim.keymap.set('n', 'g.', toggle_gitfiles, { buffer = args.data.buf_id }) end,
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
