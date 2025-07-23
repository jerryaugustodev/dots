-- kaneogawa.lua
-- Kaneogawa: A Neovim colorscheme for night-time coding sessions
-- Background: #0d1117

local M = {}

--- Generate the color palette
---@return table
local function generate_palette()
	return {
		-- Base Colors
		background = "#0d1117",
		foreground = "#d0d7de",
		comment = "#5f6a7d",
		subtle = "#424a56",

		-- Syntax Colors
		keyword = "#8aadf4",
		string = "#a6da95",
		func = "#f0c987",
		variable = "#d1aaff",
		constant = "#ff8f40",
		type = "#b7bdf8",
		operator = "#89ddff",

		-- UI Elements
		popup_bg = "#161b22",
		selection = "#28323c",
		border = "#3b4048",
		cursorline = "#1c2025",

		-- Diagnostic Colors
		error = "#ff757f",
		warning = "#ffc777",
		info = "#a3d4d5",
		hint = "#8bd5ca",

		-- Special Colors
		diff_add = "#273849",
		diff_change = "#1c2938",
		diff_delete = "#3f2326",
	}
end

--- Apply highlights based on the palette
---@param colors table
local function apply_highlights(colors)
	local set_hl = vim.api.nvim_set_hl

	-- Base UI
	set_hl(0, "Normal", { bg = colors.background, fg = colors.foreground })
	set_hl(0, "Visual", { bg = colors.selection })
	set_hl(0, "CursorLine", { bg = colors.cursorline })

	-- Syntax Groups
	set_hl(0, "Comment", { fg = colors.comment, italic = true })
	set_hl(0, "Keyword", { fg = colors.keyword })
	set_hl(0, "String", { fg = colors.string })
	set_hl(0, "Function", { fg = colors.func })
	set_hl(0, "Variable", { fg = colors.variable })
	set_hl(0, "Constant", { fg = colors.constant })
	set_hl(0, "Type", { fg = colors.type })
	set_hl(0, "Operator", { fg = colors.operator })

	-- Diagnostic
	set_hl(0, "DiagnosticError", { fg = colors.error })
	set_hl(0, "DiagnosticWarn", { fg = colors.warning })
	set_hl(0, "DiagnosticInfo", { fg = colors.info })
	set_hl(0, "DiagnosticHint", { fg = colors.hint })

	-- Floating Windows
	set_hl(0, "NormalFloat", { bg = colors.popup_bg })
	set_hl(0, "FloatBorder", { fg = colors.border })

	-- Diff
	set_hl(0, "DiffAdd", { bg = colors.diff_add })
	set_hl(0, "DiffChange", { bg = colors.diff_change })
	set_hl(0, "DiffDelete", { bg = colors.diff_delete })
end

--- Setup function for the colorscheme
---@param opts table
function M.setup(opts)
	opts = opts or {}
	local colors = generate_palette()
	apply_highlights(colors)
end

-- Automatically set colorscheme on load
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "kaneogawa",
	callback = function()
		M.setup()
	end,
})

return M
