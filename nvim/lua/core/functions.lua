local H = {}

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
    vim.notify("no buffer name", vim.log.levels.ERROR)
    return
  end

  local is_test  = string.find(file, "_test%.go$")
  local source = string.find(file, "%.go$")
  local is_source = (not is_test and source)

  local alt_file = file
  if is_test then
    alt_file = string.gsub(file, "_test.go", ".go")
  elseif is_source then
    alt_file = vim.fn.expand('%:r') .. "_test.go"
  else
    vim.notify('not a go file', vim.log.levels.ERROR)
    return
  end

  if not vim.fn.filereadable(alt_file) or not vim.fn.bufexists(alt_file) then
    vim.notify("couldn't find " .. alt_file, vim.log.levels.ERROR)
    return
  else
    vim.cmd('edit ' .. alt_file)
  end
end

H.keys = {
  ['cr'] = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y'] = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}
