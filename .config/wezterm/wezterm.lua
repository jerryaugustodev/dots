local wezterm = require("wezterm")

local kanagawa = require("themes/kanagawa")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font"

return {
	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",

	force_reverse_video_cursor = true,
	colors = kanagawa,
	-- color_scheme = "Catppuccin Mocha",

	-- Font config
	font = font_with_fallback(font_name),
	-- font_rules = {
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Normal",
	-- 		font = font_with_fallback(font_name, { weight = "Regular" }),
	-- 	},
	-- 	{
	-- 		intensity = "Bold",
	-- 		font = font_with_fallback(font_name, { weight = "Black" }),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		font = font_with_fallback(font_name, { weight = "Light" }),
	-- 	},
	-- 	-- {
	-- 	-- 	intensity = "Bold",
	-- 	-- 	font = font_with_fallback(font_name, { bold = true }),
	-- 	-- },
	-- },
	warn_about_missing_glyphs = false,
	font_size = 9,
	line_height = 1.2,
	dpi = 96.0,

	-- Cursor style
	-- default_cursor_style = "SteadyBlock",
	-- default_cursor_style = "BlinkingBlock",
	-- default_cursor_style = "SteadyUnderline",
	-- default_cursor_style = "BlinkingUnderline",
	-- default_cursor_style = "SteadyBar",
	default_cursor_style = "BlinkingBar",

	-- X11
	enable_wayland = true,

	-- Keybinds
	disable_default_key_bindings = true,
	keys = {
		{
			key = [[\]],
			mods = "CTRL|ALT",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "CTRL",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{ -- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "x",
			mods = "CTRL",
			action = "ActivateCopyMode",
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
	},

	-- Aesthetic Night Colorscheme
	bold_brightens_ansi_colors = true,
	-- Padding
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 2,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,

	-- General
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 0.8,
	window_close_confirmation = "NeverPrompt",
	window_frame = { active_titlebar_bg = "#2D4F67", font = font_with_fallback(font_name, { bold = true }) },
}
