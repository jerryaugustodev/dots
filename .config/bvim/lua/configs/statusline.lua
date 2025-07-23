--- Statusline configuration and utilities
local M = {}

local statusline = require("mini.statusline")

-- Setup MiniStatusline with custom active content
statusline.setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = statusline.section_mode({ trunc_width = 1000 })
			local search = M.search_query()
			local branch = M.git_branch()
			local log_commit = M.git_log()
			local changes = M.git_changes()
			local filename = M.filename()
			local diagnostics = M.diagnostics_summary()
			local location = M.section_location()
			local service_status = M.services_status()

			return statusline.combine_groups({
				{ hl = mode_hl, strings = { mode:upper() } },
				{ hl = "MiniStatuslineDevinfo", strings = { filename, vim.bo.modified and "󰧞" or "" } },
				"%<",
				{ hl = "", strings = { branch, log_commit, changes } },
				"%=",
				{ hl = "", strings = { diagnostics } },
				{ hl = "MiniStatuslineFileinfo", strings = { service_status } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
	},
})

--- Return active LSPs (up to 2), one linter, one formatter, and Copilot status
---@return string
function M.services_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local lsp_names, linters, formatters = {}, {}, {}
	local copilot_icon = "" -- Default: idle

	-- Gather LSP clients excluding Copilot
	local ok_lsp, clients = pcall(vim.lsp.get_clients, { bufnr = bufnr })
	if ok_lsp then
		for _, client in ipairs(clients) do
			if client.name == "copilot" then
				copilot_icon = "" -- Copilot active
			else
				table.insert(lsp_names, client.name)
			end
		end
	else
		copilot_icon = "" -- Copilot error
	end

	-- Sort LSPs by name length ascending
	table.sort(lsp_names, function(a, b)
		return #a < #b
	end)

	-- Gather linters from nvim-lint
	local ok_lint, lint = pcall(require, "lint")
	if ok_lint then
		for _, linter in ipairs(lint.linters_by_ft[ft] or {}) do
			table.insert(linters, linter)
		end
	end

	-- Gather formatters from conform.nvim
	local ok_conform, conform = pcall(require, "conform")
	if ok_conform then
		for _, formatter in ipairs(conform.list_formatters_for_buffer(bufnr) or {}) do
			table.insert(formatters, formatter)
		end
	end

	local parts, remaining = {}, 0

	-- Add up to 2 LSPs
	for i = 1, math.min(1, #lsp_names) do
		table.insert(parts, lsp_names[i])
	end
	if #lsp_names > 1 then
		remaining = remaining + (#lsp_names - 2)
	end

	-- Add 1 linter
	if #linters > 0 then
		table.insert(parts, linters[1])
		remaining = remaining + (#linters - 1)
	end

	-- Add 1 formatter
	if #formatters > 0 then
		table.insert(parts, formatters[1])
		remaining = remaining + (#formatters - 1)
	end

	-- Append ellipsis if there's anything else left
	if remaining > 0 then
		table.insert(parts, "...")
	end

	if #parts == 0 then
		return copilot_icon
	end

	return string.format("  %s │ %s ", table.concat(parts, " "), copilot_icon) --  
end

--- Returns current cursor position within file as 'Top', 'Bot', or percentage
---@return string
function M.section_location()
	local icon = " "
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")

	if current_line == 1 then
		return icon .. "Top"
	elseif current_line == total_lines then
		return icon .. "Bot"
	end

	local percent = math.floor((current_line / total_lines) * 100)
	return string.format("%s%d󰏰", icon, percent)
end

--- Returns git changes in current buffer (requires gitsigns or minidiff)
---@return string
function M.git_changes()
	local summary = vim.b.minidiff_summary
	if not summary then
		return ""
	end

	local symbols = { added = "+", changed = "~", removed = "-" }
	local parts = {}

	if summary.add and summary.add > 0 then
		table.insert(parts, symbols.added .. summary.add)
	end
	if summary.change and summary.change > 0 then
		table.insert(parts, symbols.changed .. summary.change)
	end
	if summary.delete and summary.delete > 0 then
		table.insert(parts, symbols.removed .. summary.delete)
	end

	return next(parts) and table.concat(parts, " ") or ""
end

--- Returns diagnostic counts by severity: Error, Warn, Info, Hint
---@return string
function M.diagnostics_summary()
	local diagnostics = vim.diagnostic.get(0)
	local counts = { 0, 0, 0, 0 } -- ERROR, WARN, INFO, HINT
	for _, d in ipairs(diagnostics) do
		counts[d.severity] = counts[d.severity] + 1
	end

	local icons = { "󰅚", "󰀪", "󰋽", "󰌶" }
	local result = {}

	for i, count in ipairs(counts) do
		if count > 0 then
			table.insert(result, string.format("%s %d", icons[i], count))
		end
	end

	return next(result) and table.concat(result, " ") or ""
end

--- Returns current file name with associated icon
---@return string
function M.filename()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		return ""
	end

	local filename = vim.fn.fnamemodify(filepath, ":t")
	local icon = require("mini.icons").get("file", filepath) or ""
	return string.format("%s %s", icon, filename)
end

--- Truncates a list of names to fit within max length, adding ellipsis if necessary
---@param names table
---@param max_length number
---@return string
function M.truncate_names(names, max_length)
	local output = ""
	local current_len = 0

	for _, name in ipairs(names) do
		local addition = (output == "" and name or ", " .. name)
		if current_len + #addition > max_length then
			output = output .. "..."
			break
		end
		output = output .. addition
		current_len = #output
	end

	return output
end

--- Returns current git branch
---@return string
function M.git_branch()
	local handle = io.popen("git branch --show-current 2>/dev/null")
	if not handle then
		return ""
	end
	local branch = handle:read("*l")
	handle:close()
	return branch and branch ~= "" and (" " .. branch) or "" -- 
end

--- Returns latest git commit short hash
---@return string
function M.git_log()
	local ok, handle = pcall(io.popen, "git log -1 --pretty=format:' %h'")
	if not ok or not handle then
		return ""
	end
	local output = handle:read("*a"):gsub("\n", "")
	handle:close()
	return output
end

--- Returns active search term and position (current/total) in search results
---@return string
function M.search_query()
	local search = vim.fn.getreg("/")
	if search == "" then
		return ""
	end

	local result = vim.fn.searchcount({ maxcount = 9999, timeout = 500 })
	if (result.total or 0) == 0 then
		return ""
	end

	local current = result.current or 0
	local total = result.total or 0

	return string.format(" %s [%d/%d]", search, current, total) -- 󰈭 󰺮
end

--- Clears the search register and refreshes the statusline
function M.clear_search()
	vim.fn.setreg("/", "")
	-- vim.cmd("redrawstatus")
	vim.cmd('echo "" | redraw | redrawstatus')
end

vim.keymap.set("n", "<Esc>", function()
	M.clear_search()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { noremap = true, silent = true })

return M
