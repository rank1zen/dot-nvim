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
    ignore_install = { 'latex' },
    highlight = {
      enable = true,
      disable = function(_, buf)
        -- Don't disable for read-only buffers.
        if not vim.bo[buf].modifiable then return false end

        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        -- Disable for files larger than 250 KB.
        return ok and stats and stats.size > (250 * 1024)
      end,
    },
    indent = { enable = false },
  })
