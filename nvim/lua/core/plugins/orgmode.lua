local H = {}

local orgmode = require('orgmode')

orgmode.setup({
  org_agenda_files = { '~/Dropbox/org/*', '~/org/*' },
  org_default_notes_file = '~/Dropbox/org/refile.org',
  org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'PROG(p)', 'INTR(i)', '|', 'DONE(d)', 'CANC(c)' },
  org_todo_repeat_to_state = nil,
  org_todo_keyword_faces = {
    TODO = 'foreground blue',
    NEXT = 'foreground #611300',
    PROG = 'foreground red',
    DONE = 'foreground green',
    CANC = 'foreground purple',
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
  org_startup_folded = 'showeverything',
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
  mappings = {
    disable_all = false,
    org_return_uses_meta_return = false,
    prefix = '<Leader>o',
    global = {
      org_agenda = '<prefix>a',
      org_capture = '<prefix>c',
    },
    agenda = {
      org_agenda_later = 'f',
      org_agenda_earlier = 'b',
      org_agenda_goto_today = '.',
      org_agenda_day_view = 'vd',
      org_agenda_week_view = 'vw',
      org_agenda_month_view = 'vm',
      org_agenda_year_view = 'vy',
      org_agenda_quit = 'q',
      org_agenda_switch_to = '<CR>',
      org_agenda_goto = '<TAB>',
      org_agenda_goto_date = 'J',
      org_agenda_redo = 'r',
      org_agenda_todo = 't',
      org_agenda_clock_goto = '<prefix>xj',
      org_agenda_set_effort = '<prefix>xe',
      org_agenda_clock_in = 'I',
      org_agenda_clock_out = 'O',
      org_agenda_clock_cancel = 'X',
      org_agenda_clockreport_mode = 'R',
      org_agenda_priority = '<prefix>,',
      org_agenda_priority_up = '+',
      org_agenda_priority_down = '-',
      org_agenda_archive = '<prefix>$',
      org_agenda_toggle_archive_tag = '<prefix>A',
      org_agenda_set_tags = '<prefix>t',
      org_agenda_deadline = '<prefix>id',
      org_agenda_schedule = '<prefix>is',
      org_agenda_filter = '/',
      org_agenda_refile = '<prefix>r',
      org_agenda_show_help = 'g?',
    },
    capture = {
      org_capture_finalize = '<C-c>',
      org_capture_refile = '<prefix>r',
      org_capture_kill = '<prefix>k',
      org_capture_show_help = 'g?',
    },
    note = {
      org_note_finalize = '<C-c>',
      org_note_kill = '<prefix>k',
      org_note_show_help = 'g?',
    },
    org = {
      org_refile = '<prefix>r',
      org_timestamp_up_day = '<S-UP>',
      org_timestamp_down_day = '<S-DOWN>',
      org_timestamp_up = '<C-a>',
      org_timestamp_down = '<C-x>',
      org_change_date = 'cid',
      org_priority = '<prefix>,',
      org_priority_up = 'ciR',
      org_priority_down = 'cir',
      org_todo = 'cit',
      org_todo_prev = 'ciT',
      org_toggle_checkbox = '<C-Space>',
      org_toggle_heading = '<prefix>*',
      org_open_at_point = '<prefix>o',
      org_edit_special = [[<prefix>']],
      org_cycle = '<TAB>',
      org_global_cycle = '<S-TAB>',
      org_archive_subtree = '<prefix>$',
      org_set_tags_command = '<prefix>t',
      org_toggle_archive_tag = '<prefix>A',
      org_do_promote = '<<',
      org_do_demote = '>>',
      org_promote_subtree = '<s',
      org_demote_subtree = '>s',
      org_meta_return = '<Leader><CR>', -- Add heading, item or row (context-dependent)
      org_return = '<CR>',
      org_insert_heading_respect_content = '<prefix>ih', -- Add new heading after current heading block (same level)
      org_insert_todo_heading = '<prefix>iT', -- Add new todo heading right after current heading (same level)
      org_insert_todo_heading_respect_content = '<prefix>it', -- Add new todo heading after current heading block (same level)
      org_move_subtree_up = '<prefix>K',
      org_move_subtree_down = '<prefix>J',
      org_export = '<prefix>e',
      org_next_visible_heading = '}',
      org_previous_visible_heading = '{',
      org_forward_heading_same_level = ']]',
      org_backward_heading_same_level = '[[',
      outline_up_heading = 'g{',
      org_deadline = '<prefix>id',
      org_schedule = '<prefix>is',
      org_time_stamp = '<prefix>i.',
      org_time_stamp_inactive = '<prefix>i!',
      org_toggle_timestamp_type = '<prefix>d!',
      org_insert_link = '<prefix>li',
      org_store_link = '<prefix>ls',
      org_clock_in = '<prefix>xi',
      org_clock_out = '<prefix>xo',
      org_clock_cancel = '<prefix>xq',
      org_clock_goto = '<prefix>xj',
      org_set_effort = '<prefix>xe',
      org_show_help = 'g?',
      org_babel_tangle = '<prefix>bt',
    },
    edit_src = {
      org_edit_src_abort = '<prefix>k',
      org_edit_src_save = '<prefix>w',
      org_edit_src_show_help = 'g?',
    },
    text_objects = {
      inner_heading = 'ih',
      around_heading = 'ah',
      inner_subtree = 'ir',
      around_subtree = 'ar',
      inner_heading_from_root = 'Oh',
      around_heading_from_root = 'OH',
      inner_subtree_from_root = 'Or',
      around_subtree_from_root = 'OR',
    },
  },
  emacs_config = {
    executable_path = 'emacs',
    config_path = '$HOME/.emacs.d/init.el',
  },
  ui = {
    folds = {
      colored = true,
    },
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
      if headline.deadline then
        deadline = headline.deadline:humanize(now)
      end
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
      path = file_entry.file.filename
    }

    table.insert(items, item)
  end

  for _,item in ipairs(items) do
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

  return MiniPick.start({ source = source})
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
