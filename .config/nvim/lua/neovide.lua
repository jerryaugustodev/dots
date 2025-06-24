-- Optimized Neovide Config

-- Check if Neovide is running
if not vim.g.neovide then
	return
end

local g = vim.g

-- Basic Settings
g.neovide_transparency = 0.8 -- Starting transparency level
g.neovide_normal_opacity = 0.8
g.neovide_scale_factor = 1.0 -- Initial scale factor
g.neovide_floating_shadow = false
g.neovide_floating_corner_radius = 0.0
g.neovide_show_border = false
g.neovide_cursor_antialiasing = true

-- Cursor Effects for Better Performance
g.neovide_cursor_animate_in_insert_mode = false
g.neovide_cursor_animate_command_line = false
g.neovide_cursor_smooth_blink = false
g.neovide_cursor_animation_length = 0.05 -- Shorter cursor animation
g.neovide_cursor_trail_size = 0.3 -- Smaller cursor trail to boost performance
g.neovide_cursor_vfx_mode = "pixiedust" -- Lighter cursor effect for lower resource usage
g.neovide_hide_mouse_when_typing = true -- Hide mouse when typing

-- Cursor styles per mode
vim.opt.guicursor = {
	"i-ci-c:ver25",
	"n-sm:block",
	"r-cr-o-v:hor10",
	"a:blinkwait200-blinkoff350-blinkon550",
}

-- Font Size and Resizing Functions
g.gui_font_default_size = 10
g.gui_font_size = g.gui_font_default_size
g.gui_font_face = "JetBrainsMono Nerd Font"
-- g.gui_font_face = "Aporetic Sans Mono"
-- g.gui_font_face = "JuliaMono"
-- g.gui_font_face = "Hack Nerd Font"
-- g.gui_font_face = "SauceCOdePro Nerd Font" -- Font face for Neovide

-- Function to Refresh Font Settings
local function RefreshGuiFont()
	vim.opt.guifont = string.format("%s:h%s", g.gui_font_face, g.gui_font_size)
end

-- Function to Adjust Font Size
local function ResizeGuiFont(delta)
	g.gui_font_size = g.gui_font_size + delta
	RefreshGuiFont()
end

-- Reset Font to Default Size
local function ResetGuiFont()
	g.gui_font_size = g.gui_font_default_size
	RefreshGuiFont()
end

-- Set default font size at startup
ResetGuiFont()

-- Toggle Transparency
local function toggleTransparency()
	if g.neovide_transparency == 1.0 then
		g.neovide_transparency = 0.9
	else
		g.neovide_transparency = 1.0
	end
end

-- Toggle Fullscreen
local function toggleFullscreen()
	g.neovide_fullscreen = not g.neovide_fullscreen
end

-- Keymaps for Font, Transparency, and Fullscreen Controls
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Font Size Adjustment
keymap({ "n", "i" }, "<F12>", function()
	ResizeGuiFont(1)
end, opts)
keymap({ "n", "i" }, "<F11>", function()
	ResizeGuiFont(-1)
end, opts)
keymap({ "n", "i" }, "<F10>", ResetGuiFont, opts)

-- Fullscreen and Transparency Toggle
keymap("n", "<F8>", toggleFullscreen, opts)
keymap("n", "<F9>", toggleTransparency, opts)

-- Clipboard Shortcuts for Copy and Paste (Ctrl+C and Ctrl+V)
keymap({ "n", "v" }, "<C-c>", '"+y', opts) -- Copy
keymap({ "n", "v" }, "<C-v>", '"+p', opts) -- Paste
keymap("i", "<C-v>", "<C-r>+", opts) -- Paste in insert mode
keymap("c", "<C-v>", "<C-r>+", opts) -- Paste in command mode
keymap("i", "<C-BS>", "<Esc>ciw", opts) -- Ctrl+Backspace to delete a word in insert mode
