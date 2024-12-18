-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "zooma"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@attribute.builtin", { link = "Special" })
hi(0, "@character.special", { link = "SpecialChar" })
hi(0, "@comment.documentation", { link = "@comment" })
hi(0, "@comment.error", { link = "@text.danger" })
hi(0, "@comment.note", { link = "@text.note" })
hi(0, "@comment.todo", { link = "@text.todo" })
hi(0, "@comment.warning", { link = "@text.warning" })
hi(0, "@conditional", { link = "Conditional" })
hi(0, "@constant.builtin", { link = "Special" })
hi(0, "@constant.macro", { link = "Macro" })
hi(0, "@debug", { link = "Debug" })
hi(0, "@define", { link = "Define" })
hi(0, "@diff.delta", { link = "diffChanged" })
hi(0, "@diff.minus", { link = "diffRemoved" })
hi(0, "@diff.plus", { link = "diffAdded" })
hi(0, "@exception", { link = "Exception" })
hi(0, "@field", { link = "Identifier" })
hi(0, "@float", { link = "Float" })
hi(0, "@function.builtin", { link = "Special" })
hi(0, "@function.call", { link = "Function" })
hi(0, "@function.macro", { link = "Macro" })
hi(0, "@function.method", { link = "@method" })
hi(0, "@function.method.call", { link = "@method.call" })
hi(0, "@include", { link = "Include" })
hi(0, "@keyword.conditional", { link = "@keyword" })
hi(0, "@keyword.conditional.ternary", { link = "Keyword" })
hi(0, "@keyword.coroutine", { link = "@keyword" })
hi(0, "@keyword.debug", { bold = true, fg = "#006255" })
hi(0, "@keyword.directive", { bold = true, fg = "#040039" })
hi(0, "@keyword.directive.define", { link = "@keyword.directive" })
hi(0, "@keyword.exception", { link = "@keyword" })
hi(0, "@keyword.function", { link = "@keyword" })
hi(0, "@keyword.import", { bold = true, fg = "#040039" })
hi(0, "@keyword.operator", { link = "@keyword" })
hi(0, "@keyword.repeat", { link = "@keyword" })
hi(0, "@keyword.return", { bold = true, fg = "#531e00" })
hi(0, "@keyword.storage", { bold = true, fg = "#000000" })
hi(0, "@lsp.mod.deprecated", { fg = "#42001f" })
hi(0, "@lsp.type.class", { link = "@structure" })
hi(0, "@lsp.type.comment", { link = "@comment" })
hi(0, "@lsp.type.decorator", { link = "@function" })
hi(0, "@lsp.type.enum", { link = "@type" })
hi(0, "@lsp.type.enumMember", { link = "@constant" })
hi(0, "@lsp.type.event", { link = "@type" })
hi(0, "@lsp.type.function", { link = "@function" })
hi(0, "@lsp.type.interface", { link = "@type" })
hi(0, "@lsp.type.keyword", { link = "@keyword" })
hi(0, "@lsp.type.macro", { link = "@macro" })
hi(0, "@lsp.type.method", { link = "@method" })
hi(0, "@lsp.type.modifier", { link = "@type.qualifier" })
hi(0, "@lsp.type.namespace", { link = "@namespace" })
hi(0, "@lsp.type.number", { link = "@number" })
hi(0, "@lsp.type.operator", { link = "@operator" })
hi(0, "@lsp.type.parameter", { link = "@parameter" })
hi(0, "@lsp.type.property", { link = "@property" })
hi(0, "@lsp.type.regexp", { link = "@string.regexp" })
hi(0, "@lsp.type.string", { link = "@string" })
hi(0, "@lsp.type.struct", { link = "@structure" })
hi(0, "@lsp.type.type", { link = "@type" })
hi(0, "@lsp.type.typeParameter", { link = "@type.definition" })
hi(0, "@lsp.type.variable", { link = "@variable" })
hi(0, "@macro", { link = "Macro" })
hi(0, "@markup.environment", { link = "@module" })
hi(0, "@markup.heading", { link = "@text.title" })
hi(0, "@markup.italic", { link = "@text.emphasis" })
hi(0, "@markup.link", { link = "@text.reference" })
hi(0, "@markup.link.label", { link = "@markup.link" })
hi(0, "@markup.link.url", { fg = "#000000", underline = true })
hi(0, "@markup.list", { link = "@punctuation.special" })
hi(0, "@markup.list.checked", { link = "DiagnosticOk" })
hi(0, "@markup.list.unchecked", { link = "DiagnosticWarn" })
hi(0, "@markup.math", { link = "@string.special" })
hi(0, "@markup.quote", { link = "@string.special" })
hi(0, "@markup.raw", { link = "@text.literal" })
hi(0, "@markup.raw.block", { link = "@markup.raw" })
hi(0, "@markup.strikethrough", { link = "@text.strike" })
hi(0, "@markup.strong", { link = "@text.strong" })
hi(0, "@markup.underline", { link = "@text.underline" })
hi(0, "@method", { link = "Function" })
hi(0, "@method.call", { link = "Function" })
hi(0, "@module", { link = "@namespace" })
hi(0, "@module.builtin", { link = "@variable.builtin" })
hi(0, "@namespace", { link = "Identifier" })
hi(0, "@none", { link = "Normal" })
hi(0, "@number.float", { link = "@float" })
hi(0, "@parameter", { fg = "#040039" })
hi(0, "@preproc", { link = "PreProc" })
hi(0, "@punctuation.bracket", { link = "@punctuation" })
hi(0, "@punctuation.delimiter", { link = "@punctuation" })
hi(0, "@punctuation.special", { link = "Special" })
hi(0, "@repeat", { link = "Repeat" })
hi(0, "@storageclass", { link = "StorageClass" })
hi(0, "@string.documentation", { link = "@string" })
hi(0, "@string.escape", { link = "SpecialChar" })
hi(0, "@string.regexp", { link = "SpecialChar" })
hi(0, "@string.special", { link = "SpecialChar" })
hi(0, "@string.special.path", { link = "Directory" })
hi(0, "@string.special.symbol", { link = "@constant" })
hi(0, "@string.special.url", { link = "@markup.link.url" })
hi(0, "@string.special.vimdoc", { link = "@constant" })
hi(0, "@structure", { link = "Structure" })
hi(0, "@symbol", { link = "Keyword" })
hi(0, "@tag.attribute", { link = "@tag" })
hi(0, "@tag.builtin", { link = "Special" })
hi(0, "@tag.delimiter", { link = "@punctuation" })
hi(0, "@text.danger", { link = "ErrorMsg" })
hi(0, "@text.emphasis", { italic = true })
hi(0, "@text.literal", { link = "Special" })
hi(0, "@text.note", { link = "MoreMsg" })
hi(0, "@text.reference", { link = "Identifier" })
hi(0, "@text.strike", { strikethrough = true })
hi(0, "@text.strong", { bold = true })
hi(0, "@text.title", { link = "Title" })
hi(0, "@text.todo", { link = "Todo" })
hi(0, "@text.underline", { link = "Underlined" })
hi(0, "@text.uri", { link = "Underlined" })
hi(0, "@text.warning", { link = "WarningMsg" })
hi(0, "@type.builtin", { link = "Special" })
hi(0, "@type.definition", { link = "Typedef" })
hi(0, "@type.qualifier", { link = "StorageClass" })
hi(0, "@variable", { fg = "#000000" })
hi(0, "@variable.builtin", { link = "Special" })
hi(0, "@variable.member", { link = "@field" })
hi(0, "@variable.parameter", { link = "@parameter" })
hi(0, "@variable.parameter.builtin", { link = "Special" })
hi(0, "Added", { fg = "#1d4100" })
hi(0, "Bold", { bold = true })
hi(0, "Changed", { fg = "#006255" })
hi(0, "ColorColumn", { bg = "#a2a2a2" })
hi(0, "Comment", { fg = "#4e4e4e" })
hi(0, "Conceal", { fg = "#005168" })
hi(0, "Constant", { fg = "#2a0039" })
hi(0, "CurSearch", { bg = "#5c4800", fg = "#ffffff" })
hi(0, "Cursor", { bg = "#000000", fg = "#ffffff" })
hi(0, "CursorColumn", { bg = "#d0d0d0" })
hi(0, "CursorLine", { bg = "#d0d0d0" })
hi(0, "CursorLineFold", { fg = "#a2a2a2" })
hi(0, "CursorLineNr", { bold = true, fg = "#000000" })
hi(0, "CursorLineSign", { fg = "#a2a2a2" })
hi(0, "Delimiter", { fg = "#531e00" })
hi(0, "DiagnosticDeprecated", { sp = "#42001f", strikethrough = true })
hi(0, "DiagnosticError", { fg = "#42001f" })
hi(0, "DiagnosticFloatingError", { bg = "#ffffff", fg = "#42001f" })
hi(0, "DiagnosticFloatingHint", { bg = "#ffffff", fg = "#006255" })
hi(0, "DiagnosticFloatingInfo", { bg = "#ffffff", fg = "#040039" })
hi(0, "DiagnosticFloatingOk", { bg = "#ffffff", fg = "#1d4100" })
hi(0, "DiagnosticFloatingWarn", { bg = "#ffffff", fg = "#5c4800" })
hi(0, "DiagnosticHint", { fg = "#006255" })
hi(0, "DiagnosticInfo", { fg = "#040039" })
hi(0, "DiagnosticOk", { fg = "#1d4100" })
hi(0, "DiagnosticUnderlineError", { sp = "#42001f", underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#006255", underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#040039", underline = true })
hi(0, "DiagnosticUnderlineOk", { sp = "#1d4100", underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#5c4800", underline = true })
hi(0, "DiagnosticWarn", { fg = "#5c4800" })
hi(0, "DiffAdd", { bg = "#d5ffbd" })
hi(0, "DiffChange", { bg = "#b1fff0" })
hi(0, "DiffDelete", { bg = "#ffb8d0" })
hi(0, "DiffText", { bg = "#ffe9a9" })
hi(0, "Directory", { fg = "#005168" })
hi(0, "EndOfBuffer", { blend = 0, fg = "#a2a2a2" })
hi(0, "Error", { bg = "#ffb8d0" })
hi(0, "ErrorMsg", { fg = "#42001f" })
hi(0, "Float", { link = "Constant" })
hi(0, "FloatBorder", { bg = "#ffffff", fg = "#000000" })
hi(0, "FloatTitle", { bg = "#ffffff", bold = true, fg = "#000000" })
hi(0, "FoldColumn", { fg = "#a2a2a2" })
hi(0, "Folded", { bg = "#ffffff", fg = "#4e4e4e" })
hi(0, "Function", { fg = "#005168" })
hi(0, "Identifier", { fg = "#5c4800" })
hi(0, "Ignore", {})
hi(0, "IncSearch", { bg = "#5c4800", fg = "#ffffff" })
hi(0, "Italic", { italic = true })
hi(0, "LineNr", { fg = "#a2a2a2" })
hi(0, "LspCodeLens", { link = "Comment" })
hi(0, "LspCodeLensSeparator", { link = "Comment" })
hi(0, "LspReferenceText", { bg = "#a2a2a2" })
hi(0, "LspSignatureActiveParameter", { link = "LspReferenceText" })
hi(0, "MatchParen", { bg = "#a2a2a2", bold = true })
hi(0, "MiniAnimateCursor", { nocombine = true, reverse = true })
hi(0, "MiniAnimateNormalFloat", { link = "NormalFloat" })
hi(0, "MiniClueBorder", { link = "FloatBorder" })
hi(0, "MiniClueDescGroup", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniClueDescSingle", { link = "NormalFloat" })
hi(0, "MiniClueNextKey", { link = "DiagnosticFloatingHint" })
hi(0, "MiniClueNextKeyWithPostkeys", { link = "DiagnosticFloatingError" })
hi(0, "MiniClueSeparator", { link = "DiagnosticFloatingInfo" })
hi(0, "MiniClueTitle", { link = "FloatTitle" })
hi(0, "MiniCompletionActiveParameter", { bg = "#a2a2a2" })
hi(0, "MiniCursorword", { underline = true })
hi(0, "MiniCursorwordCurrent", { underline = true })
hi(0, "MiniDepsChangeAdded", { link = "diffAdded" })
hi(0, "MiniDepsChangeRemoved", { link = "diffRemoved" })
hi(0, "MiniDiffOverAdd", { link = "DiffAdd" })
hi(0, "MiniDiffOverChange", { link = "DiffText" })
hi(0, "MiniDiffOverContext", { link = "DiffChange" })
hi(0, "MiniDiffOverDelete", { link = "DiffDelete" })
hi(0, "MiniDiffSignAdd", { link = "diffAdded" })
hi(0, "MiniDiffSignChange", { link = "diffChanged" })
hi(0, "MiniDiffSignDelete", { link = "diffRemoved" })
hi(0, "MiniFilesBorder", { link = "FloatBorder" })
hi(0, "MiniFilesBorderModified", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniFilesCursorLine", { link = "CursorLine" })
hi(0, "MiniFilesDirectory", { link = "Directory" })
hi(0, "MiniFilesFile", { fg = "#000000" })
hi(0, "MiniFilesNormal", { link = "NormalFloat" })
hi(0, "MiniFilesTitle", { link = "FloatTitle" })
hi(0, "MiniFilesTitleFocused", { bg = "#ffffff", bold = true, fg = "#000000" })
hi(0, "MiniHipatternsFixme", { bg = "#42001f", bold = true, fg = "#ffffff" })
hi(0, "MiniHipatternsHack", { bg = "#5c4800", bold = true, fg = "#ffffff" })
hi(0, "MiniHipatternsNote", { bg = "#006255", bold = true, fg = "#ffffff" })
hi(0, "MiniHipatternsTodo", { bg = "#040039", bold = true, fg = "#ffffff" })
hi(0, "MiniIconsAzure", { fg = "#005168" })
hi(0, "MiniIconsBlue", { fg = "#040039" })
hi(0, "MiniIconsCyan", { fg = "#006255" })
hi(0, "MiniIconsGreen", { fg = "#1d4100" })
hi(0, "MiniIconsGrey", { fg = "#000000" })
hi(0, "MiniIconsOrange", { fg = "#531e00" })
hi(0, "MiniIconsPurple", { fg = "#2a0039" })
hi(0, "MiniIconsRed", { fg = "#42001f" })
hi(0, "MiniIconsYellow", { fg = "#5c4800" })
hi(0, "MiniIndentscopeSymbol", { fg = "#000000" })
hi(0, "MiniIndentscopeSymbolOff", { fg = "#42001f" })
hi(0, "MiniJump", { sp = "#000000", undercurl = true })
hi(0, "MiniJump2dDim", { fg = "#a2a2a2" })
hi(0, "MiniJump2dSpot", { bg = "#ffffff", bold = true, fg = "#000000", nocombine = true })
hi(0, "MiniJump2dSpotAhead", { bg = "#ffffff", fg = "#000000", nocombine = true })
hi(0, "MiniJump2dSpotUnique", { link = "MiniJump2dSpot" })
hi(0, "MiniMapNormal", { bg = "#ffffff", fg = "#4e4e4e" })
hi(0, "MiniMapSymbolCount", { fg = "#4e4e4e" })
hi(0, "MiniMapSymbolLine", { fg = "#000000" })
hi(0, "MiniMapSymbolView", { fg = "#000000" })
hi(0, "MiniNotifyBorder", { link = "FloatBorder" })
hi(0, "MiniNotifyNormal", { link = "NormalFloat" })
hi(0, "MiniNotifyTitle", { link = "FloatTitle" })
hi(0, "MiniOperatorsExchangeFrom", { link = "IncSearch" })
hi(0, "MiniPickBorder", { link = "FloatBorder" })
hi(0, "MiniPickBorderBusy", { link = "DiagnosticFloatingWarn" })
hi(0, "MiniPickBorderText", { link = "FloatTitle" })
hi(0, "MiniPickCursor", { blend = 100, nocombine = true })
hi(0, "MiniPickHeader", { link = "DiagnosticFloatingHint" })
hi(0, "MiniPickIconDirectory", { link = "Directory" })
hi(0, "MiniPickIconFile", { link = "MiniPickNormal" })
hi(0, "MiniPickMatchCurrent", { link = "CursorLine" })
hi(0, "MiniPickMatchMarked", { link = "Visual" })
hi(0, "MiniPickMatchRanges", { link = "DiagnosticFloatingHint" })
hi(0, "MiniPickNormal", { link = "NormalFloat" })
hi(0, "MiniPickPreviewLine", { link = "CursorLine" })
hi(0, "MiniPickPreviewRegion", { link = "IncSearch" })
hi(0, "MiniPickPrompt", { link = "DiagnosticFloatingInfo" })
hi(0, "MiniStarterCurrent", { link = "MiniStarterItem" })
hi(0, "MiniStarterFooter", { link = "Comment" })
hi(0, "MiniStarterHeader", { bold = true, fg = "#000000" })
hi(0, "MiniStarterInactive", { link = "Comment" })
hi(0, "MiniStarterItemBullet", { fg = "#4e4e4e" })
hi(0, "MiniStarterItemPrefix", { bold = true, fg = "#5c4800" })
hi(0, "MiniStarterQuery", { bold = true, fg = "#1d4100" })
hi(0, "MiniStarterSection", { fg = "#2a0039" })
hi(0, "MiniStatuslineDevinfo", { bg = "#d0d0d0", fg = "#262626" })
hi(0, "MiniStatuslineFileinfo", { link = "MiniStatuslineDevinfo" })
hi(0, "MiniStatuslineFilename", { bg = "#ffffff", fg = "#262626" })
hi(0, "MiniStatuslineInactive", { link = "StatusLineNC" })
hi(0, "MiniStatuslineModeCommand", { bg = "#5c4800", bold = true, fg = "#ffffff" })
hi(0, "MiniStatuslineModeInsert", { bg = "#005168", bold = true, fg = "#ffffff" })
hi(0, "MiniStatuslineModeNormal", { bg = "#000000", bold = true, fg = "#ffffff" })
hi(0, "MiniStatuslineModeOther", { bg = "#006255", bold = true, fg = "#ffffff" })
hi(0, "MiniStatuslineModeReplace", { bg = "#42001f", bold = true, fg = "#ffffff" })
hi(0, "MiniStatuslineModeVisual", { bg = "#1d4100", bold = true, fg = "#ffffff" })
hi(0, "MiniSurround", { link = "IncSearch" })
hi(0, "MiniTablineCurrent", { bg = "#ffffff", bold = true, fg = "#000000" })
hi(0, "MiniTablineFill", { link = "MiniTablineHidden" })
hi(0, "MiniTablineHidden", { bg = "#ffffff", fg = "#262626" })
hi(0, "MiniTablineModifiedCurrent", { bg = "#000000", bold = true, fg = "#ffffff" })
hi(0, "MiniTablineModifiedHidden", { bg = "#262626", fg = "#ffffff" })
hi(0, "MiniTablineModifiedVisible", { bg = "#262626", bold = true, fg = "#ffffff" })
hi(0, "MiniTablineTabpagesection", { bg = "#1d4100", bold = true, fg = "#ffffff" })
hi(0, "MiniTablineVisible", { bg = "#ffffff", bold = true, fg = "#262626" })
hi(0, "MiniTestEmphasis", { bold = true })
hi(0, "MiniTestFail", { bold = true, fg = "#42001f" })
hi(0, "MiniTestPass", { bold = true, fg = "#1d4100" })
hi(0, "MiniTrailspace", { bg = "#ffb8d0" })
hi(0, "ModeMsg", { fg = "#1d4100" })
hi(0, "MoreMsg", { fg = "#005168" })
hi(0, "MsgArea", { blend = 0, link = "Normal" })
hi(0, "MsgSeparator", { blend = 0, fg = "#4e4e4e" })
hi(0, "NonText", { fg = "#a2a2a2" })
hi(0, "Normal", { blend = 0, fg = "#000000" })
hi(0, "NormalFloat", { bg = "#ffffff", fg = "#000000" })
hi(0, "NormalNC", { blend = 0, link = "Normal" })
hi(0, "Operator", { fg = "#000000" })
hi(0, "Pmenu", { bg = "#d0d0d0", fg = "#000000" })
hi(0, "PmenuMatch", { bg = "#d0d0d0", bold = true, fg = "#000000" })
hi(0, "PmenuMatchSel", { blend = 0, bold = true, reverse = true })
hi(0, "PmenuSel", { blend = 0, reverse = true })
hi(0, "PmenuThumb", { bg = "#a2a2a2" })
hi(0, "PreProc", { fg = "#040039" })
hi(0, "Question", { fg = "#005168" })
hi(0, "QuickFixLine", { bold = true })
hi(0, "Removed", { fg = "#42001f" })
hi(0, "Search", { bg = "#000000", fg = "#ffffff" })
hi(0, "SignColumn", { fg = "#a2a2a2" })
hi(0, "Special", { fg = "#006255" })
hi(0, "SpecialKey", { fg = "#a2a2a2" })
hi(0, "SpellBad", { sp = "#42001f", undercurl = true })
hi(0, "SpellCap", { sp = "#006255", undercurl = true })
hi(0, "SpellLocal", { sp = "#5c4800", undercurl = true })
hi(0, "SpellRare", { sp = "#040039", undercurl = true })
hi(0, "Statement", { bold = true, fg = "#000000" })
hi(0, "StatusLine", { bg = "#ffffff", fg = "#262626" })
hi(0, "StatusLineNC", { bg = "#ffffff", fg = "#262626" })
hi(0, "String", { fg = "#1d4100" })
hi(0, "Substitute", { bg = "#040039", fg = "#ffffff" })
hi(0, "TabLine", { bg = "#ffffff", fg = "#262626" })
hi(0, "TabLineSel", { bg = "#ffffff", fg = "#000000" })
hi(0, "TermCursorNC", { reverse = true })
hi(0, "Title", { fg = "#000000" })
hi(0, "Todo", { bg = "#ffffff", bold = true, fg = "#000000" })
hi(0, "Type", { fg = "#000000" })
hi(0, "VertSplit", { blend = 0, fg = "#000000" })
hi(0, "Visual", { bg = "#a2a2a2" })
hi(0, "VisualNOS", { bg = "#d0d0d0" })
hi(0, "WarningMsg", { fg = "#5c4800" })
hi(0, "Whitespace", { fg = "#a2a2a2" })
hi(0, "WinBar", { link = "StatusLine" })
hi(0, "WinBarNC", { link = "StatusLineNC" })
hi(0, "WinSeparator", { blend = 0, fg = "#000000" })
hi(0, "diffAdded", { fg = "#1d4100" })
hi(0, "diffChanged", { fg = "#006255" })
hi(0, "diffFile", { fg = "#5c4800" })
hi(0, "diffLine", { fg = "#040039" })
hi(0, "diffRemoved", { fg = "#42001f" })
hi(0, "gitcommitBranch", { bold = true, fg = "#531e00" })
hi(0, "gitcommitComment", { link = "Comment" })
hi(0, "gitcommitDiscarded", { link = "Comment" })
hi(0, "gitcommitDiscardedFile", { bold = true, fg = "#5c4800" })
hi(0, "gitcommitDiscardedType", { fg = "#005168" })
hi(0, "gitcommitHeader", { link = "Title" })
hi(0, "gitcommitOverflow", { fg = "#5c4800" })
hi(0, "gitcommitSelected", { link = "Comment" })
hi(0, "gitcommitSelectedFile", { bold = true, fg = "#1d4100" })
hi(0, "gitcommitSelectedType", { link = "gitcommitDiscardedType" })
hi(0, "gitcommitSummary", { fg = "#1d4100" })
hi(0, "gitcommitUnmergedFile", { link = "gitcommitDiscardedFile" })
hi(0, "gitcommitUnmergedType", { link = "gitcommitDiscardedType" })
hi(0, "gitcommitUntracked", { link = "Comment" })
hi(0, "gitcommitUntrackedFile", { fg = "#006255" })
hi(0, "lCursor", { bg = "#000000", fg = "#ffffff" })

-- Terminal colors
local g = vim.g

g.terminal_color_0 = "#ffffff"
g.terminal_color_1 = "#42001f"
g.terminal_color_2 = "#1d4100"
g.terminal_color_3 = "#5c4800"
g.terminal_color_4 = "#005168"
g.terminal_color_5 = "#2a0039"
g.terminal_color_6 = "#006255"
g.terminal_color_7 = "#000000"
g.terminal_color_8 = "#ffffff"
g.terminal_color_9 = "#42001f"
g.terminal_color_10 = "#1d4100"
g.terminal_color_11 = "#5c4800"
g.terminal_color_12 = "#005168"
g.terminal_color_13 = "#2a0039"
g.terminal_color_14 = "#006255"
g.terminal_color_15 = "#000000"