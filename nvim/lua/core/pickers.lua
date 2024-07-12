local OrgApi = require('orgmode.api')

local M = {}

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

MiniPick.registry.visit_paths = function(local_opts, opts)
  opts = centered_picker()

  local_opts.preserve_order = true
  return MiniExtra.pickers.visit_paths(local_opts, opts)
end

function M.load_files(opts)
  ---@type { file: OrgApiFile, filename: string, last_used: number }[]
  local file_results = vim.tbl_map(function(file)
    local file_stat = vim.uv.fs_stat(file.filename) or 0
    return { file = file, filename = file.filename, last_used = file_stat.mtime.sec }
  end, OrgApi.load())

  if not opts.archived then
    file_results = vim.tbl_filter(function(entry) return not entry.file.is_archive_file end, file_results)
  end

  table.sort(file_results, function(a, b) return a.last_used > b.last_used end)

  return file_results
end

function M.refile(opts) return OrgApi.refile(opts) end

function M.insert_link(destination) return OrgApi.insert_link(destination) end

function M.get_closest_headline() return OrgApi.current():get_closest_headline() end

MiniPick.registry.org_headlines = function(local_opts, opts)
  local pick = require('mini.pick')

  local org_items = M.load_files({})

  local items = {}
  for _, file_entry in ipairs(org_items) do
    for _, headline in ipairs(file_entry.file.headlines) do
      local file = vim.fn.fnamemodify(file_entry.filename, ':t')
      local tags = table.concat(headline.all_tags, ':')
      local title = headline.title
      local ts = headline.deadline or ''
      local state = headline.todo_value or ''

      local entry = {
        text = string.format('%s | %s %s %s', file, ts, state, title),
        path = file_entry.filename,
        lnum = headline.position.start_line,
      }

      table.insert(items, entry)
    end
  end

  local source = {
    name = 'Orgmode headlines',
    show = MiniPick.default_show,
    preview = MiniPick.default_preview,
    choose = MiniPick.default_choose,
    choose_marked = pick.default_choose_marked,
    items = items,
  }

  return MiniPick.start({ source = source })
end

M.validate_pick = function() end
