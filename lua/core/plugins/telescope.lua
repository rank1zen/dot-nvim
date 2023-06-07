return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup {
            defaults = {
                mappings = {
                    n = { ['q'] = actions.close }
                },
                layout_config = {
                    prompt_position = 'top'
                },
                initial_mode = 'normal',
                sorting_strategy = 'ascending',
                scroll_strategy = 'limit',
                prompt_prefix = '>  '
            }
        }
    end
}
