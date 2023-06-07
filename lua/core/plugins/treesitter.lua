return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects'
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            highlight = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 's',
                    node_incremental = 's',
                    node_decremental = 'S'
                }
            },
            textobjects = {
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                }
            }
        }
    end
}
