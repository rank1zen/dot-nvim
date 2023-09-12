local M = {}

M.tab_next = function()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  else
    cmp.complete()
  end
end

M.tab_prev = function()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
  else
    cmp.complete()
  end
end

return M
