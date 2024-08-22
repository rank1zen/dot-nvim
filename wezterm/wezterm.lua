local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Builtin Light"
config.font = wezterm.font("GeistMono Nerd Font", { weight = "Bold" })
config.font_size = 10.7

config.default_prog = { "/usr/bin/fish", "-l" }
config.enable_tab_bar = true

config.enable_wayland = false
config.window_padding = { left = 15, right = 15, top = 5, bottom = 10 }
config.dpi = 192.0

config.unix_domains = {
	{ name = "unix" },
}

-- stylua: ignore start
config.ssh_domains = {
	{ name = "teach.cs", remote_address = "teach.cs.utoronto.ca", username = "chens527", multiplexing = "None", assume_shell = "Posix" },
}
-- stylua: ignore end

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

config.leader = { key = "Space", mods = "CTRL|SHIFT" }

config.keys = {
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	{
		key = "a",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "activate_pane",
			timeout_milliseconds = 1000,
		}),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
	},
}

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	-- Defines the keys that are active in our activate-pane mode.
	-- 'activate_pane' here corresponds to the name="activate_pane" in
	-- the key assignments above.
	activate_pane = {
		{ key = "LeftArrow", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	},
}

return config
