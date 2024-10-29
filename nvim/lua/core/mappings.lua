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

local H = {}

H.gen_opts = {}

Config.mappings = {}

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

nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read session')
nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete session')

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

Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>l', desc = '+Lang' },
  { mode = 'x', keys = '<Leader>l', desc = '+Lang' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
}

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

-- stylua: ignore end

H.gen_opts.stack = function()
  return {
    filter = function(path_data) return vim.fn.isdirectory(path_data.path) == 0 end,
    sort = MiniVisits.gen_sort.default({ recency_weight = 1 }),
  }
end
