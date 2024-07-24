local H = {}

Config.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }

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

Config.toggle_quickfix = function()
  local quickfix_wins = vim.tbl_filter(
    function(win_id) return vim.fn.getwininfo(win_id)[1].quickfix == 1 end,
    vim.api.nvim_tabpage_list_wins(0)
  )

  local command = #quickfix_wins == 0 and 'copen' or 'cclose'
  vim.cmd(command)
end

Config.golang_test_file = function()
  local file = vim.fn.expand('%')
  if #file <= 1 then
    vim.notify('no buffer name', vim.log.levels.ERROR)
    return
  end

  if string.find(file, '_test%.go$') then
    vim.cmd('edit' .. string.gsub(file, '_test.go', '.go'))
  elseif string.find(file, '%.go$') then
    vim.cmd('edit' .. vim.fn.expand('%:r') .. '_test.go')
  else
    vim.notify('not a go file', vim.log.levels.ERROR)
  end
end

Config.float_win_centered = function()
  local h, w = math.floor(0.2 * vim.o.lines), math.min(math.floor(0.5 * vim.o.columns), 80)
  local r, c = math.floor(0.25 * (vim.o.lines - h)), math.floor(0.5 * (vim.o.columns - w))
  return { anchor = 'NW', height = h, width = w, row = r, col = c, border = Config.borders }
end

Config.float_win_full = function()
  local h, w = math.floor(0.9 * vim.o.lines), math.floor(0.9 * vim.o.columns)
  local r, c = math.floor(0.35 * (vim.o.lines - h)), math.floor(0.5 * (vim.o.columns - w))
  return { anchor = 'NW', height = h, width = w, row = r, col = c, border = Config.borders }
end

Config.floating_window_bottom = function()
  local h, w = math.floor(0.3 * vim.o.lines), vim.o.columns
  local r, c = vim.o.lines - h, 0
  return { anchor = 'NW', height = h, width = w, row = r, col = c, border = Config.borders }
end
