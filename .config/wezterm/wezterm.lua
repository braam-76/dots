local wezterm = require 'wezterm'
local config = {}
config.default_prog = { "/usr/bin/fish", "-l" }

config.font = wezterm.font "ZedMono Nerd Font"
config.font_size = 12
config.color_scheme = "Kanagawa (Gogh)"

-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false

return config
