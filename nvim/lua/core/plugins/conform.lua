local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    go = { 'gofumpt', 'goimports' },
    lua = { 'stylua' },
    nix = { 'alejandra' },
    sql = { 'sqlfluff' },
    templ = { 'templ' },
    tex = { 'latexindent' },
  },
})
