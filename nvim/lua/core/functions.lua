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

Config.golang_test_file = function()
  local file = vim.fn.expand('%')
  if #file <= 1 then
    vim.notify('no buffer name', vim.log.levels.ERROR)
    return
  end

  if string.find(file, '_test%.go$') then
    vim.cmd('edit ' .. string.gsub(file, '_test.go', '.go'))
  elseif string.find(file, '%.go$') then
    vim.cmd('edit ' .. vim.fn.expand('%:r') .. '_test.go')
  else
    vim.notify('not a go file', vim.log.levels.ERROR)
  end
end

Config.visit_stack_next = function()
  local opts = { sort = MiniVisits.gen_sort.default({ recency_weight = 1 }) }
  MiniVisits.iterate_paths('backward', nil, opts)
end

Config.visit_stack_prev = function()
  local opts = { sort = MiniVisits.gen_sort.default({ recency_weight = 1 }) }
  MiniVisits.iterate_paths('forward', nil, opts)
end

Config.toggle_quickfix = function()
  local quickfix_wins = vim.tbl_filter(
    function(win_id) return vim.fn.getwininfo(win_id)[1].quickfix == 1 end,
    vim.api.nvim_tabpage_list_wins(0)
  )

  local command = #quickfix_wins == 0 and 'copen' or 'cclose'
  vim.cmd(command)
end
