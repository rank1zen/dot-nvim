return {
  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    opts = {}
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      disable_italics = true,
      disable_background = true,
      disable_float_background = true
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>a',
        function() require('harpoon.mark').add_file() end,
      },
      {
        '<C-e>',
        function() require('harpoon.ui').toggle_quick_menu() end,
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmds = { 'Telescope' },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          layout_strategy = 'center',
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
            }
          }
        }
      })
    end,
    keys = {
      {
        '<C-p>',
        function()
          local theme = require('telescope.themes').get_dropdown({
            width = 0.8,
            previewer = false,
            prompt_title = false,
          })
          require('telescope.builtin').git_files(theme)
        end,
      }
    }
  },
}
