_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>e', desc = '+General' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
}

local function nmap_leader(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

local function xmap_leader(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- stylua: ignore start

-- +General
nmap_leader('ed', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'Directory')
nmap_leader('eD', '<Cmd>lua MiniFiles.open()<CR>',                             'Directory (CWD)')
nmap_leader('ef', '<Cmd>Pick visit_paths<CR>',                                 'Files (Frequent)')
nmap_leader('eF', '<Cmd>Pick files<CR>',                                       'Files')
nmap_leader('eg', '<Cmd>Pick grep_live<CR>',                                   'Grep')
nmap_leader('eG', '<Cmd>Pick grep pattern="<cword>"<CR>',                      'Grep (Current word)')
nmap_leader('eh', '<Cmd>Pick help<CR>',                                        'Help')
nmap_leader('eH', '<Cmd>Pick commands<CR>',                                    'Commands')
nmap_leader('el', '<Cmd>Pick buf_lines scope="all"<CR>',                       'Lines')
nmap_leader('eL', '<Cmd>Pick buf_lines scope="current"<CR>',                   'Lines (current)')
nmap_leader('er', '<Cmd>lua MiniSessions.read()<CR>',                          'Sessions')
nmap_leader('eR', '<Cmd>lua MiniSessions.select()<CR>',                        'Sessions (Select)')
nmap_leader('et', '<Cmd>edit ~/.config/nvim/TODO.md<CR>', 'Config TODO')
nmap_leader('eT', '<Cmd>edit ~/.config/nvim/init.lua<CR>', 'Config')
nmap_leader('em', '<Cmd>lua MiniMap.toggle()<CR>',                     'MiniMap')
nmap_leader('eM', '<Cmd>lua MiniMap.toggle_focus()<CR>',                     'MiniMap focus')
nmap_leader('eb', '<Cmd>Pick buffers<CR>',                                     'Buffers')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                     'Quickfix')

-- +Other
nmap_leader('or', '<Cmd>Pick resume<CR>',                 'Last')
nmap_leader('oh', '<Cmd>Pick hipatterns<CR>',             'Hipatterns')
nmap_leader('og', '<Cmd>Pick hl_groups<CR>',              'Highlight groups')
nmap_leader('o/', '<Cmd>Pick history scope="/"<CR>',      '"/" history')
nmap_leader('o:', '<Cmd>Pick history scope=":"<CR>',      '":" history')
nmap_leader('op', '<Cmd>lua Config.golang_test_file()<CR>', 'Switch to Go Test')

-- +Git
nmap_leader('gc', '<Cmd>Git commit<CR>',                             'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',                     'Commit amend')
nmap_leader('gl', '<Cmd>Git log --oneline<CR>',                      'Log (all)')
nmap_leader('gL', '<Cmd>Git log --oneline --follow -- %<CR>',        'Log (current)')

nmap_leader('gv', '<Cmd>Pick git_commits<CR>',                       'Commits (all)')
nmap_leader('gV', '<Cmd>Pick git_commits path="%"<CR>',              'Commits (current)')
nmap_leader('gs', '<Cmd>Pick git_hunks scope="staged"<CR>',          'Added hunks (all)')
nmap_leader('gS', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', 'Added hunks (current)')
nmap_leader('gh', '<Cmd>Pick git_hunks<CR>',                         'Modified hunks (all)')
nmap_leader('gH', '<Cmd>Pick git_hunks path="%"<CR>',                'Modified hunks (current)')
nmap_leader('gb', '<Cmd>Pick git_branches<CR>',                         'Branches (all)')

nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>',          'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',           'Show at cursor')
xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',           'Show at selection')

-- +LSP
nmap_leader('lf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format')
xmap_leader('lf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format Selection')
nmap_leader('lo', '<Cmd>Pick lsp scope="document_symbol"<CR>',                   'Symbols buffer')
nmap_leader('lO', '<Cmd>Pick lsp scope="workspace_symbol"<CR>',                  'Symbols workspace')
nmap_leader('lm', '<Cmd>lua vim.diagnostic.open_float()<CR>',                    'Diagnostics popup')

nmap_leader('lq', '<Cmd>Pick diagnostic scope="current"<CR>',                    'Diagnostic buffer')
nmap_leader('lQ', '<Cmd>Pick diagnostic scope="all"<CR>',                        'Diagnostic workspace')
nmap_leader('lc', '<Cmd>lua vim.lsp.buf.rename()<CR>',                           'Rename')
nmap_leader('lC', '<Cmd>lua vim.lsp.buf.code_action()<CR>',                      'Code Action')

nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>',                       'Definition')
-- nmap_leader('ld', '<Cmd>Pick lsp scope="definition"<CR>', 'Definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>',                       'Type Definition')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.references()<CR>',                       'References')
nmap_leader('lR', '<Cmd>Pick lsp scope="references"<CR>', 'References')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',                   'Implementations')
nmap_leader('li', '<Cmd>Pick lsp scope="implementation"<CR>', 'Implementations')
nmap_leader('la', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')
