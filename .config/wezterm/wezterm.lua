local wezterm = require("wezterm")
local config = {}
config.color_scheme = "Kanagawa (Gogh)"
config.font_size = 14 -- set default font size
config.font = wezterm.font("Mononoki Nerd Font", { weight = "Bold", italic = false }) -- set default font

config.window_padding = {
	left = "2cell",
	right = "2cell",
	top = "1cell",
	bottom = "1cell",
}
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true -- hide the tab bar if only one tab is open
config.hide_mouse_cursor_when_typing = true -- hide mouse cursor when typing in the panel
config.default_cursor_style = "SteadyUnderline" -- default cursor style is underline

return config
