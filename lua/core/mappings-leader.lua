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

_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
}

-- stylua: ignore start

-- (e)xplore
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',                             'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
nmap_leader('ec', '<Cmd>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',     'Config')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                                    'Neovim Init')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                     'Quickfix')

-- (f)ind
nmap_leader('ff', '<Cmd>Pick files<CR>',       'Files')
nmap_leader('fl', '<Cmd>Pick resume<CR>',      'Last')
nmap_leader('fv', '<Cmd>Pick visit_paths<CR>', 'Visit paths')
nmap_leader('fc', '<Cmd>Pick commands<CR>',    'Commands')
nmap_leader('fh', '<Cmd>Pick help<CR>',        'Help tags')
nmap_leader('fH', '<Cmd>Pick hipatterns<CR>',  'Hipatterns')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',   'Grep live')

nmap_leader('fD', '<Cmd>Pick diagnostic<CR>',  'Diagnostics')
nmap_leader('fd', '<Cmd>Pick lsp scope="definition"<CR>', 'Definition')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>', 'References')
nmap_leader('fi', '<Cmd>Pick lsp scope="implementation"<CR>', 'Implementations')

-- (g)it
nmap_leader('gc', '<Cmd>Git commit<CR>',                      'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',              'Commit amend')
nmap_leader('gg', '<Cmd>lua Config.open_lazygit()<CR>',       'Git tab') -- FIXME: we dont have this function
nmap_leader('gl', '<Cmd>Git log --oneline<CR>',               'Log')
nmap_leader('gL', '<Cmd>Git log --oneline --follow -- %<CR>', 'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>',   'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',    'Show at cursor')
xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',    'Show at selection')

-- (l)sp
nmap_leader('lD', '<Cmd>lua vim.diagnostic.open_float()<CR>',                    'Diagnostics')
nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>',                       'Definition')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',                       'References')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',                   'Implementations')
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',                      'Code Action')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',                           'Rename')
nmap_leader('lf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format')
xmap_leader('lf', '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', 'Format Selection')
--nmap_leader('ls', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')

-- Vimtest
nmap_leader('tt', '<Cmd>TestLast<CR>',    'Test Last')
nmap_leader('tr', '<Cmd>TestNearest<CR>', 'Test Nearest')
nmap_leader('tf', '<Cmd>TestFile<CR>',    'Test File')
nmap_leader('ts', '<Cmd>TestSuite<CR>',   'Test Suit')

-- Vimux
nmap_leader('vv', '<Cmd>VimuxRunLastCommand<CR>',  'Vimux Last')
nmap_leader('vp', '<Cmd>VimuxPromptCommand<CR>',   'Vimux Prompt')
nmap_leader('vi', '<Cmd>VimuxInspectRunner<CR>',   'Vimux Inspect')
nmap_leader('vq', '<Cmd>VimuxCloseRunner<CR>',     'Vimux Close')
nmap_leader('vc', '<Cmd>VimuxInterruptRunner<CR>', 'Vimux Interrupt')
nmap_leader('vz', '<Cmd>VimuxZoomRunner<CR>',      'Vimux Zoom')
