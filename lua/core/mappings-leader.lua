-- stylua: ignore start

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

nmap_leader('oc', '<Cmd>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',     'Config')
nmap_leader('oe', '<Cmd>lua MiniFiles.open()<CR>',                             'Directory')
nmap_leader('of', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')

nmap_leader('pp', '<Cmd>Pick resume<CR>',      'Resume')
nmap_leader('pv', '<Cmd>Pick visit_paths<CR>', 'Visit paths')
nmap_leader('pf', '<Cmd>Pick files<CR>',       'Files')
nmap_leader('pg', '<Cmd>Pick grep_live<CR>',   'Grep live')
nmap_leader('ph', '<Cmd>Pick help<CR>',        'Help tags')

nmap_leader('pd', '<Cmd>Pick lsp              scope="definition"<CR>',       'Definition')
nmap_leader('pR', '<Cmd>Pick lsp              scope="references"<CR>',       'References')
nmap_leader('pD', '<Cmd>Pick diagnostic<CR>', 'Diagnostics')
nmap_leader('ps', '<Cmd>Pick lsp              scope="workspace_symbol"<CR>', 'Symbols workspace')
nmap_leader('pS', '<Cmd>Pick lsp              scope="document_symbol"<CR>',  'Symbols buffer')

nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Definition')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('lD', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics popup')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('la', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')
nmap_leader('lf', '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>', 'Format')
xmap_leader('lf', '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>', 'Format Selection')

nmap_leader('tr', '<Cmd>TestNearest<CR>', 'Test Nearest')
nmap_leader('tf', '<Cmd>TestFile<CR>',    'Test File')
nmap_leader('ts', '<Cmd>TestSuite<CR>',   'Test Suit')
nmap_leader('tt', '<Cmd>TestLast<CR>',    'Test Last')

-- TODO: Vimux mappings
