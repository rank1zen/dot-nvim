local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Solarized (light) (terminal.sexy)'
-- config.color_scheme = 'Solarized Light (Gogh)'

config.font = wezterm.font('GeistMono Nerd Font', { weight = 'Bold' })
config.font_size = 15

config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true

return config
