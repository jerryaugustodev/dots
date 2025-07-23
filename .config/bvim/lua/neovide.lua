-- Optimized Neovide Config

-- Check if Neovide is running
if not vim.g.neovide then
	return
end

local g = vim.g

-- Basic Settings
g.neovide_opacity = 0.7 -- Starting transparency level
-- g.transparency = 0.8
g.neovide_normal_opacity = 0.7
-- g.neovide_scale_factor = 1.0 -- Initial scale factor
-- g.neovide_floating_shadow = false
-- g.neovide_floating_corner_radius = 0.0
-- g.neovide_show_border = false
-- g.neovide_cursor_antialiasing = true

-- Cursor Effects for Better Performance
-- g.neovide_cursor_animate_in_insert_mode = false
-- g.neovide_cursor_animate_command_line = false
-- g.neovide_cursor_smooth_blink = false
-- g.neovide_cursor_animation_length = 0.05 -- Shorter cursor animation
-- g.neovide_cursor_trail_size = 0.3 -- Smaller cursor trail to boost performance
-- g.neovide_cursor_vfx_mode = "pixiedust" -- Lighter cursor effect for lower resource usage
-- g.neovide_hide_mouse_when_typing = true -- Hide mouse when typing

-- Cursor styles per mode
-- vim.opt.guicursor = {
-- 	"i-ci-c:ver25",
-- 	"n-sm:block",
-- 	"r-cr-o-v:hor10",
-- 	"a:blinkwait200-blinkoff350-blinkon550",
-- }

-- Font Size and Resizing Functions
-- g.gui_font_default_size = 10
-- g.gui_font_size = g.gui_font_default_size
-- g.gui_font_face = "JetBrainsMono Nerd Font"

-- Exit early if not running inside Neovide
-- if not vim.g.neovide then return end

-- Set a developer-friendly font with good ligature support and crisp rendering
vim.o.guifont = "JetBrainsMono Nerd Font:h10"

-- Enable smooth transparency to reduce visual clutter while maintaining readability
-- vim.g.neovide_transparency = 0.7

-- Apply subtle blur to floating windows (e.g., LSP popups, completion menu)
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- Improve typing focus by hiding the mouse while actively editing
vim.g.neovide_hide_mouse_when_typing = true

-- Enable smooth, non-distracting cursor animation (railgun is performant and elegant)
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_size = 0.2

-- Use a consistent refresh rate during activity and idle periods
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 30

-- Improve user experience when switching between keyboard layouts (especially on macOS)
vim.g.neovide_input_use_logo = true -- Enables Command/Super key as a modifier
vim.g.neovide_input_macos_alt_is_meta = true -- Correctly maps Option key to Meta

-- Persist window size between sessions
vim.g.neovide_remember_window_size = true

-- Disable quit confirmation prompt for faster shutdown
vim.g.neovide_confirm_quit = false

-- Prevent idle mode from disabling refresh rate (optional)
vim.g.neovide_no_idle = false

-- Improve cursor rendering (anti-aliasing reduces jagged edges)
vim.g.neovide_cursor_antialiasing = true

-- g.gui_font_face = "Aporetic Sans Mono"
-- g.gui_font_face = "JuliaMono"
-- g.gui_font_face = "Hack Nerd Font"
-- g.gui_font_face = "SauceCOdePro Nerd Font" -- Font face for Neovide

-- Function to Refresh Font Settings
-- local function RefreshGuiFont()
-- 	vim.opt.guifont = string.format("%s:h%s", g.gui_font_face, g.gui_font_size)
-- end

-- Increase font size
vim.keymap.set("n", "<C-=>", function()
	local font = vim.o.guifont
	local name, size = font:match("^(.-):h(%d+)")
	size = tonumber(size) + 1
	vim.o.guifont = string.format("%s:h%d", name, size)
end, { desc = "Increase font size" })

-- Decrease font size
vim.keymap.set("n", "<C-->", function()
	local font = vim.o.guifont
	local name, size = font:match("^(.-):h(%d+)")
	size = tonumber(size) - 1
	vim.o.guifont = string.format("%s:h%d", name, size)
end, { desc = "Decrease font size" })
--
-- -- Function to Adjust Font Size
-- local function ResizeGuiFont(delta)
-- 	g.gui_font_size = g.gui_font_size + delta
-- 	RefreshGuiFont()
-- end
--
-- -- Reset Font to Default Size
-- local function ResetGuiFont()
-- 	g.gui_font_size = g.gui_font_default_size
-- 	RefreshGuiFont()
-- end
--
-- -- Set default font size at startup
-- ResetGuiFont()
--
-- -- Toggle Transparency
-- local function toggleTransparency()
-- 	if g.neovide_transparency == 1.0 then
-- 		g.neovide_transparency = 0.9
-- 	else
-- 		g.neovide_transparency = 1.0
-- 	end
-- end
--
-- -- Toggle Fullscreen
-- local function toggleFullscreen()
-- 	g.neovide_fullscreen = not g.neovide_fullscreen
-- end
--
-- Keymaps for Font, Transparency, and Fullscreen Controls
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
--
-- -- Font Size Adjustment
-- keymap({ "n", "i" }, "<F12>", function()
-- 	ResizeGuiFont(1)
-- end, opts)
-- keymap({ "n", "i" }, "<F11>", function()
-- 	ResizeGuiFont(-1)
-- end, opts)
-- keymap({ "n", "i" }, "<F10>", ResetGuiFont, opts)
--
-- -- Fullscreen and Transparency Toggle
-- keymap("n", "<F8>", toggleFullscreen, opts)
-- keymap("n", "<F9>", toggleTransparency, opts)
--
-- Clipboard Shortcuts for Copy and Paste (Ctrl+C and Ctrl+V)
keymap({ "n", "v" }, "<C-c>", '"+y', opts) -- Copy
keymap({ "n", "v" }, "<C-v>", '"+p', opts) -- Paste
keymap("i", "<C-v>", "<C-r>+", opts) -- Paste in insert mode
keymap("c", "<C-v>", "<C-r>+", opts) -- Paste in command mode
keymap("i", "<C-BS>", "<Esc>ciw", opts) -- Ctrl+Backspace to delete a word in insert mode

