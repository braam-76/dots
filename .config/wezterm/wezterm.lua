local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 14
config.font = wezterm.font("Fantasque Sans Mono")

config.color_scheme = 'Catppuccin Mocha'

config.default_prog = { "fish" }

config.enable_tab_bar = false

return config
