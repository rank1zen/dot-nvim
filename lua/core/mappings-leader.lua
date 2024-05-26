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

nmap_leader('oe', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('of', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')

-- Picker
nmap_leader('pp', '<Cmd>Pick resume<CR>',      'Last')
nmap_leader('pf', '<Cmd>Pick files<CR>',       'Files')
nmap_leader('pv', '<Cmd>Pick visit_paths<CR>', 'Visit paths')
nmap_leader('pc', '<Cmd>Pick commands<CR>', 'Commands')
nmap_leader('ph', '<Cmd>Pick help<CR>',        'Help tags')
nmap_leader('pH', '<Cmd>Pick hipatterns<CR>',       'Hipatterns')
nmap_leader('pg', '<Cmd>Pick grep_live<CR>',   'Grep live')

-- nmap_leader('ps', '<Cmd>Pick lsp scope="workspace_symbol"<CR>', 'Symbols workspace')
-- nmap_leader('pS', '<Cmd>Pick lsp scope="document_symbol"<CR>' , 'Symbols buffer')

-- Diagnostics
nmap_leader('pD', '<Cmd>Pick diagnostic<CR>', 'Diagnostics')
nmap_leader('lD', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics')

-- LSP Definition
nmap_leader('pd', '<Cmd>Pick lsp scope="definition"<CR>', 'Definition')
nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Definition')

-- LSP References
nmap_leader('pR', '<Cmd>Pick lsp scope="references"<CR>', 'References')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')

-- LSP Implementations
nmap_leader('pi', '<Cmd>Pick lsp scope="implementation"<CR>', 'Implementations')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementations')

-- Conform.nvim Format
nmap_leader('lf', '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>', 'Format')
xmap_leader('lf', '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>', 'Format Selection')

-- Other LSP
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('la', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')

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
