local wezterm = require("wezterm")
local config = {}
config.default_prog = { "/usr/bin/fish", "-l" }

config.font = wezterm.font("ZedMono Nerd Font")
config.font_size = 12
config.color_scheme = "Novel"

config.animation_fps = 60 -- smoothen easing effects for cursor blink and visual bell
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"

-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "X::DotShare (terminal.sexy)"
	else
		-- return "Belafonte Day"

    return "modus-operandi"
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	local colors = wezterm.get_builtin_color_schemes()[scheme]
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return config
