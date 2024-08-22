# pylint: disable=C0111
from qutebrowser.config.config import ConfigContainer  # noqa: F401

c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

base00 = "#fafafa"
base01 = "#f3f4f5"
base02 = "#f8f9fa"
base03 = "#abb0b6"
base04 = "#828c99"
base05 = "#5c6773"
base06 = "#242936"
base07 = "#1a1f29"
base08 = "#f07178"
base09 = "#fa8d3e"
base0A = "#f2ae49"
base0B = "#86b300"
base0C = "#4cbf99"
base0D = "#36a3d9"
base0E = "#a37acc"
base0F = "#e6ba7e"

palette = {
  "accent"    : "#212121",
  "accent_bg" : "#ffffff",
  "azure"     : "#006783",
  "azure_bg"  : "#a2e5ff",
  "bg"        : "#ffffff",
  "bg_edge"   : "#ffffff",
  "bg_edge2"  : "#ffffff",
  "bg_mid"    : "#d7d7d7",
  "bg_mid2"   : "#afafaf",
  "blue"      : "#0e026b",
  "blue_bg"   : "#a8c0ff",
  "cyan"      : "#00796a",
  "cyan_bg"   : "#b1fff0",
  "fg"        : "#212121",
  "fg_edge"   : "#151515",
  "fg_edge2"  : "#080808",
  "fg_mid"    : "#424242",
  "fg_mid2"   : "#666666",
  "green"     : "#295700",
  "green_bg"  : "#d5ffbd",
  "orange"    : "#722c00",
  "orange_bg" : "#ffc2a3",
  "purple"    : "#44005a",
  "purple_bg" : "#efc0ff",
  "red"       : "#620031",
  "red_bg"    : "#ffb8d0",
  "yellow"    : "#745b00",
  "yellow_bg" : "#ffe9a9"
}

c.colors.completion.fg                          = palette["fg_mid2"]
c.colors.completion.odd.bg                      = palette["bg"]
c.colors.completion.even.bg                     = palette["bg"]
c.colors.completion.category.fg                 = palette["fg_edge2"]
c.colors.completion.category.bg                 = palette["bg"]
c.colors.completion.category.border.top         = palette["bg"]
c.colors.completion.category.border.bottom      = palette["bg"]
c.colors.completion.item.selected.fg            = palette["fg_mid2"]
c.colors.completion.item.selected.bg            = palette["bg_mid"]
c.colors.completion.item.selected.border.top    = palette["bg_mid"]
c.colors.completion.item.selected.border.bottom = palette["bg_mid"]
c.colors.completion.item.selected.match.fg      = palette["fg_edge2"]
c.colors.completion.match.fg                    = palette["fg_edge2"]
c.colors.completion.scrollbar.fg                = base05
c.colors.completion.scrollbar.bg                = base00

c.colors.statusbar.command.bg           = palette["bg"]
c.colors.statusbar.command.fg           = palette["fg"]
c.colors.statusbar.insert.bg            = palette["bg"]
c.colors.statusbar.insert.fg            = palette["fg"]
c.colors.statusbar.normal.bg            = palette["bg"]
c.colors.statusbar.normal.fg            = palette["fg"]
c.colors.statusbar.passthrough.bg       = palette["bg"]
c.colors.statusbar.passthrough.fg       = palette["fg"]
c.colors.statusbar.progress.bg          = palette["cyan_bg"]
c.colors.statusbar.url.error.fg         = palette["red"]
c.colors.statusbar.url.fg               = palette["fg_mid2"]
c.colors.statusbar.url.hover.fg         = palette["fg_mid2"]
c.colors.statusbar.url.success.http.fg  = palette["cyan"]
c.colors.statusbar.url.success.https.fg = palette["green"]
c.colors.statusbar.url.warn.fg          = palette["orange"]

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base01

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

c.colors.keyhint.fg        = palette["fg_mid"]
c.colors.keyhint.bg        = palette["bg_mid"]
c.colors.keyhint.suffix.fg = palette["fg"]

c.colors.hints.fg = palette["fg_mid2"]
c.colors.hints.match.fg = palette["fg_edge2"]
c.colors.hints.bg = palette["bg"]

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = base01

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = base04

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg =  base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base02

#Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = base05

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base02

# Foreground color for the selected item in filename prompts.
c.colors.prompts.selected.fg = base05

# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base01

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = base05

# Background color of unselected even tabs.
c.colors.tabs.even.bg = base00

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base0C

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = base07

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = base0B

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = base07

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base02

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = base05

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base02

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = base05

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base05

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base02

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base05

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base02
