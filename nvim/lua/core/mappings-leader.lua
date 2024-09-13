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

-- stylua: ignore start

Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>e',  desc = '+Edit' },
  { mode = 'n', keys = '<Leader>ef', desc = '+find' },
  { mode = 'n', keys = '<Leader>f',  desc = '+Find' },
  { mode = 'n', keys = '<Leader>g',  desc = '+Git' },
  { mode = 'n', keys = '<Leader>gf', desc = '+find' },
  { mode = 'n', keys = '<Leader>ga', desc = '+actions' },
  { mode = 'n', keys = '<Leader>l',  desc = '+LSP' },
  { mode = 'x', keys = '<Leader>l',  desc = '+LSP' },
  { mode = 'n', keys = '<Leader>lf', desc = '+find' },
  { mode = 'n', keys = '<Leader>la', desc = '+actions' },
}

-- +Edit
nmap_leader('ed', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>',                  'Explorer')
nmap_leader('ef', '<Cmd>Pick visit_paths preserve_order=true sort=MiniVisits.gen_sort.z()<CR>', 'Recent files')
nmap_leader('es', '<Cmd>Pick visit_paths preserve_order=true recency_weight=1<CR>',             'Visit stack')
nmap_leader('ep', '<Cmd>lua Config.visit_stack_prev()<CR>',                                     'Visit stack previous')
nmap_leader('en', '<Cmd>lua Config.visit_stack_next()<CR>',                                     'Visit stack next')
nmap_leader('el', '<Cmd>b#<CR>',                                                                'Alternate buffer')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>', 'Quickfix')

-- +Lang
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

-- +Find
nmap_leader('ff', '<Cmd>Pick files<CR>',                  'Files')
nmap_leader('fi', '<Cmd>Pick hipatterns<CR>',             'Hipatterns')
nmap_leader('fj', '<Cmd>Pick hl_groups<CR>',              'Highlight groups')
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',      '"/"')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',      '":"')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',              'Grep')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep (current word)')
nmap_leader('fh', '<Cmd>Pick help<CR>',                   'Help')
nmap_leader('fH', '<Cmd>Pick commands<CR>',               'Commands')
nmap_leader('f.', '<Cmd>Pick resume<CR>',                 'Resume')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Pick Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Pick Lines (current)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Pick Buffers')

-- +Git
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
