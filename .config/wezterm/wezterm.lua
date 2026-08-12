local wezterm = require("wezterm")
local vague_theme = require("lua/vague")

local config = wezterm.config_builder()

config.font_size = 14
config.font = wezterm.font("FantasqueSansM Nerd Font")

config.colors = vague_theme.colors()

config.default_prog = { "fish" }

config.enable_tab_bar = false

return config
