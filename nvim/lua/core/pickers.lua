local centered_picker = function()
  local height = math.floor(0.25 * vim.o.lines)
  local width = math.floor(0.5 * vim.o.columns)
  return {
    window = {
      config = {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.25 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      },
    },
  }
end

MiniPick.registry.visit_paths = function(local_opts)
  local opts = centered_picker()

  local_opts.preserve_order = true
  return MiniExtra.pickers.visit_paths(local_opts, opts)
end
