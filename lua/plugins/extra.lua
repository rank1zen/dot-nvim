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
    lazy = false,
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          layout_strategy = 'center',
          layout_config = {
            prompt_position = "bottom",
          },
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
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
          local function is_git_repo()
            vim.fn.system("git rev-parse --is-inside-work-tree")
            return vim.v.shell_error == 0
          end

          local function get_git_root()
            local dot_git_path = vim.fn.finddir(".git", ".;")
            return vim.fn.fnamemodify(dot_git_path, ":h")
          end

          local opts = {}
          if is_git_repo() then
            opts = {
              cwd = get_git_root(),
            }
          end

          require("telescope.builtin").find_files(opts)
        end,
      },
      {
        '<C-n>',
        function()
          local theme = require('telescope.themes').get_dropdown({
            previewer = false,
            prompt_title = false,
          })
          vim.cmd("Telescope")
        end,
      },
    }
  },
}
