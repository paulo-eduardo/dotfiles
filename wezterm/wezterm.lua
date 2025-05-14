local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 24.0

-- Window configuration
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

-- Tab bar configuration
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- Window decorations
config.window_decorations = "RESIZE"

-- Background opacity and blur
config.window_background_opacity = 0.80
config.macos_window_background_blur = 10

return config

