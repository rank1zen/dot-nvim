local H = {}

-- Config.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }
Config.borders = 'rounded'

H.keys = {
  ['cr'] = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y'] = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

Config.prompt_write_session = function()
  local input = vim.fn.input('Save session name: ')
  MiniSessions.write(input)
end

Config.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and H.keys['ctrl-y'] or H.keys['ctrl-y_cr']
  else
    return require('mini.pairs').cr()
  end
end
