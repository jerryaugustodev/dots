local ui = require("configs.ui")

vim.lsp.enable({
	"biome",
	"css-modules",
	"css-variables",
	"cssls",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"emmet-language-server",
	"gopls",
	"html",
	"lua-ls",
	"marksman",
	"oxc-language-server",
	"postgres-lsp",
	"prismals",
	"rescriptls",
	"sqruff",
	"tailwindcss",
	"terraform-ls",
	"vtsls",
	"yaml-language-server",
})

vim.diagnostic.config({
	-- virtual_lines = true,
	-- virtual_text = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "", -- ● 󰝤
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = ui.border, -- 󰷼 󱐋
		focusable = false,
		-- style = "minimal",
		-- border = "rounded",
		source = "if_many",
		prefix = "󰙎 ", -- ● 
		-- header = "",
		-- prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

-- Binds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- local conform = require("conform")
		--- Set minipick as default picker
		-- local pick = require("mini.pick")
		-- vim.ui.select = pick.ui_select
		local function map(mode, keys, action, desc)
			desc = desc or ""
			-- local opts = { noremap = true, remap = true, silent = true, desc = desc }
			local opts = { noremap = true, silent = true, desc = desc }
			vim.keymap.set(mode, keys, action, opts)
		end

		-- Diagnostics mappings
		-- NOTE alredy native
		map("n", "[d", function()
			vim.diagnostic.goto_prev({ float = false })
		end, "Diagnostics goto_prev")

		map("n", "]d", function()
			vim.diagnostic.goto_next({ float = false })
		end, "Diagnostics goto_next")

		local diagnostic_goto = function(next, severity)
			local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			severity = severity and vim.diagnostic.severity[severity] or nil
			return function()
				go({ severity = severity })
			end
		end
		-- Rreplaced by snacks.nvim
		-- map("n", "<leader>ds", vim.diagnostic.setloclist, "Add buffer diagnostics to the location list.")
		map("n", "]e", diagnostic_goto(true, "ERROR"), "Goto next error")
		map("n", "[e", diagnostic_goto(false, "ERROR"), "Goto previous error")
		map("n", "]w", diagnostic_goto(true, "WARN"), "Goto next warning")
		map("n", "[w", diagnostic_goto(false, "WARN"), "Goto previous warning")
		map("n", "]h", diagnostic_goto(false, "HINT"), "Goto next hint")
		map("n", "[h", diagnostic_goto(false, "HINT"), "Goto previous hint")

		map("n", "<leader>K", vim.lsp.buf.hover, "Open lsp hover")
		map("n", "df", function()
			vim.diagnostic.open_float()
		end, "Open diagnostics float ")
		-- map("n", "<leader>ld", vim.lsp.buf.definition, "Goto lsp definition")
		-- map("n", "<leader>lh", vim.lsp.buf.declaration, "Goto lsp declaration")
		-- map("n", "<leader>lt", vim.lsp.buf.type_definition, "Goto lsp type definition")
		-- map("n", "<leader>ls", vim.lsp.buf.document_symbol, "Document symbols")
		-- map("n", "<leader>li", vim.lsp.buf.implementation, "Goto lsp implementation")
		-- map("n", "<leader>lR", vim.lsp.buf.references, "Goto lsp reference")
		map("n", "<leader>lr", vim.lsp.buf.rename, "Lsp rename")
		-- map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Open lsp code action")
		map("n", "<leader>lb", vim.lsp.buf.references, "Lsp Buffer References")
		map("n", "<C-k>", vim.lsp.buf.signature_help, "Lsp signature help")
		map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
		map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove folder to workspace")
		map("n", "<space>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
		map("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List workspace folders")
	end,
})

-- Extras
local function restart_lsp(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local clients
	if vim.lsp.get_clients then
		clients = vim.lsp.get_clients({ bufnr = bufnr })
	else
		---@diagnostic disable-next-line: deprecated
		clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	end

	for _, client in ipairs(clients) do
		vim.lsp.stop_client(client.id)
	end

	vim.defer_fn(function()
		vim.cmd("edit")
	end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
	restart_lsp()
end, {})

local function lsp_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("󰅚 No LSP clients attached")
		return
	end

	print(" 󰒋 LSP Status for buffer " .. bufnr .. ":")
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format(" 󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
		print("  Root: " .. (client.config.root_dir or "N/A"))
		print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

		-- Check capabilities
		local caps = client.server_capabilities
		local features = {}
		if caps.completionProvider then
			table.insert(features, "completion")
		end
		if caps.hoverProvider then
			table.insert(features, "hover")
		end
		if caps.definitionProvider then
			table.insert(features, "definition")
		end
		if caps.referencesProvider then
			table.insert(features, "references")
		end
		if caps.renameProvider then
			table.insert(features, "rename")
		end
		if caps.codeActionProvider then
			table.insert(features, "code_action")
		end
		if caps.documentFormattingProvider then
			table.insert(features, "formatting")
		end

		print("  Features: " .. table.concat(features, ", "))
		print("")
	end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		print(" No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		print(" Capabilities for " .. client.name .. ":")
		local caps = client.server_capabilities

		local capability_list = {
			{ "Completion", caps.completionProvider },
			{ "Hover", caps.hoverProvider },
			{ "Signature Help", caps.signatureHelpProvider },
			{ "Go to Definition", caps.definitionProvider },
			{ "Go to Declaration", caps.declarationProvider },
			{ "Go to Implementation", caps.implementationProvider },
			{ "Go to Type Definition", caps.typeDefinitionProvider },
			{ "Find References", caps.referencesProvider },
			{ "Document Highlight", caps.documentHighlightProvider },
			{ "Document Symbol", caps.documentSymbolProvider },
			{ "Workspace Symbol", caps.workspaceSymbolProvider },
			{ "Code Action", caps.codeActionProvider },
			{ "Code Lens", caps.codeLensProvider },
			{ "Document Formatting", caps.documentFormattingProvider },
			{ "Document Range Formatting", caps.documentRangeFormattingProvider },
			{ "Rename", caps.renameProvider },
			{ "Folding Range", caps.foldingRangeProvider },
			{ "Selection Range", caps.selectionRangeProvider },
		}

		for _, cap in ipairs(capability_list) do
			local status = cap[2] and "✓" or "✗"
			print(string.format("  %s %s", status, cap[1]))
		end
		print("")
	end
end

vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)

	local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

	for _, diagnostic in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[diagnostic.severity]
		counts[severity] = counts[severity] + 1
	end

	print(" 󰒡 Diagnostics for current buffer:")
	print("  Errors: " .. counts.ERROR)
	print("  Warnings: " .. counts.WARN)
	print("  Info: " .. counts.INFO)
	print("  Hints: " .. counts.HINT)
	print("  Total: " .. #diagnostics)
end

vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })

local function lsp_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	print("═══════════════════════════════════")
	print("           LSP INFORMATION          ")
	print("═══════════════════════════════════")
	print("")

	-- Basic info
	print(" 󰈙 Language client log: " .. vim.lsp.get_log_path())
	print(" 󰈚 Detected filetype: " .. vim.bo.filetype) -- 󰈔
	print(" 󰈮 Buffer: " .. bufnr)
	print(" 󰈚 Root directory: " .. (vim.fn.getcwd() or "N/A")) -- 󰈔
	print("")

	if #clients == 0 then
		print(" 󰅚 No LSP clients attached to buffer " .. bufnr)
		print("")
		print("Possible reasons:")
		print("  • No language server installed for " .. vim.bo.filetype)
		print("  • Language server not configured")
		print("  • Not in a project root directory")
		print("  • File type not recognized")
		return
	end

	print(" 󰒋 LSP clients attached to buffer " .. bufnr .. ":")
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format(" 󰌘 Client %d: %s", i, client.name))
		print("  ID: " .. client.id)
		print("  Root dir: " .. (client.config.root_dir or "Not set"))
		print("  Command: " .. table.concat(client.config.cmd or {}, " "))
		print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

		-- Server status
		if client.is_stopped() then
			print("  Status: 󰅚 Stopped")
		else
			print("  Status: 󰄬 Running")
		end

		-- Workspace folders
		if client.workspace_folders and #client.workspace_folders > 0 then
			print("  Workspace folders:")
			for _, folder in ipairs(client.workspace_folders) do
				print("    • " .. folder.name)
			end
		end

		-- Attached buffers count
		local attached_buffers = {}
		for buf, _ in pairs(client.attached_buffers or {}) do
			table.insert(attached_buffers, buf)
		end
		print("  Attached buffers: " .. #attached_buffers)

		-- Key capabilities
		local caps = client.server_capabilities
		local key_features = {}
		if caps.completionProvider then
			table.insert(key_features, "completion")
		end
		if caps.hoverProvider then
			table.insert(key_features, "hover")
		end
		if caps.definitionProvider then
			table.insert(key_features, "definition")
		end
		if caps.documentFormattingProvider then
			table.insert(key_features, "formatting")
		end
		if caps.codeActionProvider then
			table.insert(key_features, "code_action")
		end

		if #key_features > 0 then
			print("  Key features: " .. table.concat(key_features, ", "))
		end

		print("")
	end

	-- Diagnostics summary
	local diagnostics = vim.diagnostic.get(bufnr)
	if #diagnostics > 0 then
		print(" 󰒡 Diagnostics Summary:")
		local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

		for _, diagnostic in ipairs(diagnostics) do
			local severity = vim.diagnostic.severity[diagnostic.severity]
			counts[severity] = counts[severity] + 1
		end

		print("  󰅚 Errors: " .. counts.ERROR)
		print("  󰀪 Warnings: " .. counts.WARN)
		print("  󰋽 Info: " .. counts.INFO)
		print("  󰌶 Hints: " .. counts.HINT)
		print("  Total: " .. #diagnostics)
	else
		print("󰄬 No diagnostics")
	end

	print("")
	print("Use :LspLog to view detailed logs")
	print("Use :LspCapabilities for full capability list")
end

-- Create command
vim.api.nvim_create_user_command("LspInfo", lsp_info, { desc = "Show comprehensive LSP information" })

local function lsp_status_short()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		return "" -- Return empty string when no LSP
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	return "  " .. table.concat(names, ",") -- 󰒋    󰘋 󱙋 󰞑   
end

local function git_branch()
	local ok, handle = pcall(io.popen, "git branch --show-current 2>/dev/null")
	if not ok or not handle then
		return ""
	end
	local branch = handle:read("*a")
	handle:close()
	if branch and branch ~= "" then
		branch = branch:gsub("\n", "")
		return "  " .. branch -- 󰊢 
	end
	return ""
end
local function git_log()
	local ok, handle = pcall(io.popen, "git log -1 --pretty=format:'%h'")
	if not ok or not handle then
		return ""
	end
	local log = handle:read("*a")
	handle:close()
	if log and log ~= "" then
		log = log:gsub("\n", "")
		return "  " .. log -- ⎇
	end
	return ""
end

-- Safe wrapper functions for statusline
local function safe_git_branch()
	local ok, result = pcall(git_branch)
	return ok and result or ""
end
local function safe_git_log()
	local ok, result = pcall(git_log)
	return ok and result or ""
end

local function safe_lsp_status()
	local ok, result = pcall(lsp_status_short)
	return ok and result or ""
end

_G.git_branch = safe_git_branch
_G.git_log = safe_git_log
_G.lsp_status = safe_lsp_status

-- THEN set the statusline
vim.opt.statusline = table.concat({
	"",
	"%{v:lua.git_branch()}", -- Git branch
	"%{v:lua.git_log()}", -- Git log
	"%f", -- File name
	"%m", -- Modified flag
	"%r", -- Readonly flag
	"%=", -- Right align
	"%{v:lua.lsp_status()}", -- LSP status
	" %l:%c", -- Line:Column
	" %p%%", -- Percentage through file
	"",
}, " ")

-- Make hover window have borders
-- local border = require("configs.ui").border
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
})

vim.diagnostic.config({
	float = { border = border },
})
