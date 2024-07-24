local H = {}

local orgmode = require('orgmode')

orgmode.setup({
  org_agenda_files = { '~/Dropbox/org/*', '~/org/*' },
  org_default_notes_file = '~/Dropbox/org/refile.org',
  org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'PROG(p)', 'REVI(r)', 'INTR(i)', '|', 'DONE(d)', 'CANC(c)' },
  org_todo_repeat_to_state = nil,
  org_todo_keyword_faces = {
    TODO = string.format(':foreground %s :weight bold', Config.palette.purple),
    NEXT = string.format(':foreground %s :weight bold', Config.palette.blue),
    PROG = string.format(':foreground %s :weight bold', Config.palette.red),
    REVI = string.format(':foreground %s :weight bold', Config.palette.cyan),
    INTR = string.format(':foreground %s :weight bold', Config.palette.red),
    DONE = string.format(':foreground %s :weight bold', Config.palette.green),
    CANC = string.format(':foreground %s :weight bold', Config.palette.red),
  },
  org_deadline_warning_days = 14,
  org_agenda_min_height = 16,
  org_agenda_span = 'week', -- day/week/month/year/number of days
  org_agenda_start_on_weekday = false,
  org_agenda_start_day = '-1d', -- start from today + this modifier
  calendar_week_start_day = 1,
  calendar = {
    round_min_with_hours = true,
    min_big_step = 15,
  },
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n',
    },
    d = {
      description = 'Today',
      template = '* TODO %?\nDEADLINE: <%<%Y-%m-%d %A 22:00>>\n',
    },
  },
  org_startup_folded = 'overview',
  org_agenda_skip_scheduled_if_done = false,
  org_agenda_skip_deadline_if_done = false,
  org_agenda_text_search_extra_files = {},
  org_priority_highest = 'A',
  org_priority_default = 'B',
  org_priority_lowest = 'C',
  org_archive_location = '%s_archive::',
  org_tags_column = -80,
  org_use_tag_inheritance = true,
  org_tags_exclude_from_inheritance = {},
  org_hide_leading_stars = false,
  org_hide_emphasis_markers = false,
  org_ellipsis = '...',
  org_log_done = 'time',
  org_log_repeat = 'time',
  org_log_into_drawer = nil,
  org_highlight_latex_and_related = nil,
  org_custom_exports = {},
  org_adapt_indentation = true,
  org_startup_indented = false,
  org_indent_mode_turns_off_org_adapt_indentation = true,
  org_indent_mode_turns_on_hiding_stars = true,
  org_time_stamp_rounding_minutes = 5,
  org_blank_before_new_entry = {
    heading = true,
    plain_list_item = false,
  },
  org_src_window_setup = 'top 16new',
  org_edit_src_content_indentation = 0,
  org_id_uuid_program = 'uuidgen',
  org_id_ts_format = '%Y%m%d%H%M%S',
  org_id_method = 'uuid',
  org_id_prefix = nil,
  org_id_link_to_org_use_id = false,
  org_babel_default_header_args = {
    [':tangle'] = 'no',
    [':noweb'] = 'no',
  },
  win_split_mode = 'tabnew',
  win_border = 'single',
  emacs_config = {
    executable_path = 'emacs',
    config_path = '$HOME/.emacs.d/init.el',
  },
  ui = {
    folds = { colored = false },
    menu = {
      handler = nil,
    },
  },
})

H.pickers = {}

H.pickers.org_headlines = function(local_opts, opts)
  local pick = H.validate_pick('org_headlines')
  local org_items = H.org_loadfiles({})

  local org_api = require('orgmode.objects.date')
  local now = org_api:now()

  local items = {}
  for _, file_entry in ipairs(org_items) do
    for _, headline in ipairs(file_entry.file.headlines) do
      local deadline = ''
      if headline.deadline then deadline = headline.deadline:humanize(now) end
      local tags = ''
      if #headline.tags > 0 then tags = ':' .. table.concat(headline.tags, ':') .. ':' end

      local item = {
        title = headline.title,
        status = headline.todo_value or '',
        tags = tags,
        deadline = deadline,
      }

      table.insert(items, item)
    end
  end

  H.pad_table_strings(items)

  for _, item in ipairs(items) do
    item.text = string.format('%s %s %s %s', item.tags, item.status, item.deadline, item.title)
  end

  local source = {
    name = 'Org headlines',
    show = MiniPick.default_show,
    preview = MiniPick.default_preview,
    choose = MiniPick.default_choose,
    choose_marked = pick.default_choose_marked,
    items = items,
  }

  return MiniPick.start({ source = source })
end

H.pickers.org_files = function(local_opts, opts)
  local pick = H.validate_pick('org_headlines')
  local org_items = H.org_loadfiles({})

  local items = {}
  for _, file_entry in ipairs(org_items) do
    local item = {
      filename = file_entry.filename,
      path = file_entry.file.filename,
    }

    table.insert(items, item)
  end

  for _, item in ipairs(items) do
    item.text = string.format('%s', item.filename)
  end

  local source = {
    name = 'Org files',
    show = MiniPick.default_show,
    preview = MiniPick.default_preview,
    choose = MiniPick.default_choose,
    choose_marked = pick.default_choose_marked,
    items = items,
  }

  return MiniPick.start({ source = source })
end

if type(_G.MiniPick) == 'table' then
  for name, f in pairs(H.pickers) do
    _G.MiniPick.registry[name] = function(local_opts) return f(local_opts) end
  end
end

H.formate_date = function(date)
  local now = os.time()
  local secondsInDay = 24 * 60 * 60
  local secondsInWeek = 7 * secondsInDay
  local diff = date - now

  if diff <= 0 then
    return 'Past date'
  elseif diff < secondsInDay then
    return os.date('Today at %H:%M', date)
  elseif diff < 2 * secondsInDay then
    return 'Tomorrow at ' .. os.date('%H:%M', date)
  elseif diff < secondsInWeek then
    return os.date('%A at %H:%M', date)
  else
    return os.date('%Y-%m-%d', date)
  end
end

H.pad_table_strings = function(tables)
  local maxLengths = {}
  for _, tbl in ipairs(tables) do
    for field, str in pairs(tbl) do
      if type(str) == 'string' then maxLengths[field] = math.max(maxLengths[field] or 0, #str) end
    end
  end

  for _, tbl in ipairs(tables) do
    for field, maxLength in pairs(maxLengths) do
      if type(tbl[field]) == 'string' then tbl[field] = tbl[field] .. string.rep(' ', maxLength - #tbl[field]) end
    end
  end

  return tables
end

H.ensure_text_width = function(text, width)
  local text_width = vim.fn.strchars(text)
  if text_width <= width then return text .. string.rep(' ', width - text_width) end
  return '…' .. vim.fn.strcharpart(text, text_width - width + 1, width - 1)
end

H.validate_pick = function(fname)
  local has_pick, pick = pcall(require, 'mini.pick')
  if not has_pick then
    H.error(string.format([[`pickers.%s()` requires 'mini.pick' which can not be found.]], fname))
  end
  return pick
end

H.validate_org = function(fname)
  local has_org, orgapi = pcall(require, 'orgmode.api')
  if not has_org then H.error(string.format([[`pickers.%s()` requires 'orgmode' which can not be found.]], fname)) end
  return orgapi
end

H.org_loadfiles = function(opts)
  local org = H.validate_org('org')

  ---@type { file: OrgApiFile, filename: string, last_used: number }[]
  local file_results = vim.tbl_map(function(file)
    local file_stat = vim.uv.fs_stat(file.filename) or 0
    return { file = file, filename = file.filename, last_used = file_stat.mtime.sec }
  end, org.load())

  if not opts.archived then
    file_results = vim.tbl_filter(function(entry) return not entry.file.is_archive_file end, file_results)
  end

  table.sort(file_results, function(a, b) return a.last_used > b.last_used end)

  return file_results
end
