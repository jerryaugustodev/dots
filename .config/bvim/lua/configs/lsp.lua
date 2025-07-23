local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "LSP Info" })
end

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
	virtual_text = {
		prefix = "", -- Empty, since we'll provide the icon via format
		format = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = "󰅚 ", -- 
				[vim.diagnostic.severity.WARN] = "󰀪 ", -- 
				[vim.diagnostic.severity.INFO] = "󰋽 ", -- 
				[vim.diagnostic.severity.HINT] = "󰌶 ", -- 
			}
			return icons[diagnostic.severity] or ""
		end,
		spacing = 4,
		source = "if_many",
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		-- style = "minimal",
		border = "rounded",
		source = "if_many",
		prefix = "󰙎 ", -- ● 
		-- header = "",
		-- prefix = "",
	},
	signs = false,
})

-- Binds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local api = vim.api
		local lsp = vim.lsp

		local function check_trigger_chars(trigger_chars)
			local cur_line = api.nvim_get_current_line()
			local pos = api.nvim_win_get_cursor(0)[2]
			local prev_char = cur_line:sub(pos - 1, pos - 1)
			local cur_char = cur_line:sub(pos, pos)

			for _, char in ipairs(trigger_chars) do
				if cur_char == char or prev_char == char then
					return true
				end
			end
		end

		local function setup_signature_autocmd(client, bufnr)
			if not client.server_capabilities.signatureHelpProvider then
				return
			end

			local group = api.nvim_create_augroup("LspSignatureHelp", { clear = false })
			api.nvim_clear_autocmds({ group = group, buffer = bufnr })

			local trigger_chars = client.server_capabilities.signatureHelpProvider.triggerCharacters

			api.nvim_create_autocmd("TextChangedI", {
				group = group,
				buffer = bufnr,
				callback = function()
					if check_trigger_chars(trigger_chars) then
						lsp.buf.signature_help({ focus = false, silent = true, max_height = 7, border = "rounded" })
					end
				end,
			})
		end
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Global LSP Handlers with enhanced UI

		-- Custom border config
		local border_opts = {
			border = "rounded",
			title_pos = "center",
		}

		-- Override 'textDocument/hover'
		lsp.handlers["textDocument/hover"] = lsp.with(
			lsp.handlers.hover,
			vim.tbl_extend("force", border_opts, {
				title = { { " Hover ", "@comment" } },
			})
		)

		-- Override 'textDocument/signatureHelp'
		lsp.handlers["textDocument/signatureHelp"] = lsp.with(
			lsp.handlers.signature_help,
			vim.tbl_extend("force", border_opts, {
				title = { { " Signature Help ", "@comment" } },
				max_height = 10,
			})
		)

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
			vim.diagnostic.goto_prev({ float = true })
		end, "Diagnostics goto_prev")

		map("n", "]d", function()
			vim.diagnostic.goto_next({ float = true })
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
		map("n", "<C-k>", vim.lsp.buf.signature_help, "Lsp signature help")
		map("n", "df", function()
			vim.diagnostic.open_float()
		end, "Open diagnostics float ")
		-- map("n", "<leader>ld", vim.lsp.buf.definition, "Goto lsp definition")
		-- map("n", "<leader>lh", vim.lsp.buf.declaration, "Goto lsp declaration")
		-- map("n", "<leader>lt", vim.lsp.buf.type_definition, "Goto lsp type definition")
		-- map("n", "<leader>ls", vim.lsp.buf.document_symbol, "Document symbols")
		-- map("n", "<leader>li", vim.lsp.buf.implementation, "Goto lsp implementation")
		-- map("n", "<leader>lR", vim.lsp.buf.references, "Goto lsp reference")
		-- map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Open lsp code action")
		map("n", "<leader>lb", vim.lsp.buf.references, "Lsp Buffer References")
		map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
		map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove folder to workspace")
		map("n", "<space>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
		map("n", "<space>wl", function()
			notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List workspace folders")

		setup_signature_autocmd(vim.lsp.get_client_by_id(ev.data.client_id), ev.buf)

		local function rename_symbol()
			local lsp = vim.lsp
			local api = vim.api

			local function get_symbol(cb)
				local cword = vim.fn.expand("<cword>")
				local clients = lsp.get_clients({ bufnr = 0, method = "textDocument/rename" })
				if #clients == 0 then
					cb(cword)
					return
				end

				local client = clients[1] -- Prioriza o primeiro cliente
				if client.supports_method("textDocument/prepareRename") then
					local params = lsp.util.make_position_params()
					client.request("textDocument/prepareRename", params, function(err, result)
						if err or not result then
							cb(cword)
							return
						end

						if result.placeholder then
							cb(result.placeholder)
						elseif result.range then
							cb(
								vim.api.nvim_buf_get_text(
									0,
									result.range.start.line,
									result.range.start.character,
									result.range["end"].line,
									result.range["end"].character,
									{}
								)[1]
							)
						else
							cb(cword)
						end
					end)
				else
					cb(cword)
				end
			end

			get_symbol(function(symbol)
				local buf = api.nvim_create_buf(false, true)
				local opts = {
					relative = "cursor",
					width = #symbol + 10,
					height = 1,
					row = 1,
					col = 1,
					border = "rounded",
					style = "minimal",
				}
				local win = api.nvim_open_win(buf, true, opts)
				api.nvim_buf_set_lines(buf, 0, -1, false, { symbol })
				vim.bo[buf].buftype = "prompt"
				vim.fn.prompt_setprompt(buf, "")

				vim.fn.prompt_setcallback(buf, function(input)
					api.nvim_buf_delete(buf, { force = true })
					if input and input ~= symbol then
						local params = lsp.util.make_position_params()
						params.newName = input
						lsp.buf_request(0, "textDocument/rename", params)
					end
				end)

				api.nvim_input("A") -- Move para o final do input

				vim.keymap.set({ "n", "i" }, "<Esc>", function()
					api.nvim_buf_delete(buf, { force = true })
				end, { buffer = buf })
			end)
		end

		map("n", "<leader>lr", rename_symbol, "Lsp rename with prompt")
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
		notify("󰅚 No LSP clients attached", vim.log.levels.WARN)
		return
	end

	for i, client in ipairs(clients) do
		local details = {
			string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id),
			"  Root: " .. (client.config.root_dir or "N/A"),
			"  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "),
		}

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

		table.insert(details, "  Features: " .. table.concat(features, ", "))
		notify(table.concat(details, "\n"))
	end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		notify(" No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		notify(" Capabilities for " .. client.name .. ":")
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
			notify(string.format("  %s %s", status, cap[1]))
		end
		notify("")
	end
end

vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)

	if vim.tbl_isempty(diagnostics) then
		notify("󰄬 No diagnostics in current buffer", vim.log.levels.INFO)
		return
	end

	local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

	for _, diagnostic in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[diagnostic.severity]
		if counts[severity] ~= nil then
			counts[severity] = counts[severity] + 1
		end
	end

	local summary = {
		"󰒡 Diagnostics for current buffer:",
		"  Errors:   " .. counts.ERROR,
		"  Warnings: " .. counts.WARN,
		"  Info:     " .. counts.INFO,
		"  Hints:    " .. counts.HINT,
		"  Total:    " .. #diagnostics,
	}

	notify(table.concat(summary, "\n"))
end

vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })

local function lsp_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	local info = {
		"═══════════════════════════════════",
		"           LSP INFORMATION         ",
		"═══════════════════════════════════",
		"",
		"󰈚 Language client log: " .. vim.lsp.get_log_path(), -- 󰈙
		"󰈚 Detected filetype: " .. vim.bo.filetype,
		"󰈚 Buffer: " .. bufnr, -- 󰈮
		"󰈚 Root directory: " .. (vim.fn.getcwd() or "N/A"),
		"",
	}

	if #clients == 0 then
		table.insert(info, "󰅚 No LSP clients attached to buffer " .. bufnr)
		table.insert(info, "")
		table.insert(info, "Possible reasons:")
		table.insert(info, "  • No language server installed for " .. vim.bo.filetype)
		table.insert(info, "  • Language server not configured")
		table.insert(info, "  • Not in a project root directory")
		table.insert(info, "  • File type not recognized")
		notify(table.concat(info, "\n"))
		return
	end

	table.insert(info, "󰒋 LSP clients attached to buffer " .. bufnr .. ":")
	table.insert(
		info,
		"─────────────────────────────────"
	)

	for i, client in ipairs(clients) do
		table.insert(info, string.format("󰌘 Client %d: %s", i, client.name))
		table.insert(info, "  ID: " .. client.id)
		table.insert(info, "  Root dir: " .. (client.config.root_dir or "Not set"))
		table.insert(info, "  Command: " .. table.concat(client.config.cmd or {}, " "))
		table.insert(info, "  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

		table.insert(info, "  Status: " .. (client.is_stopped() and "󰅚 Stopped" or "󰄬 Running"))

		if client.workspace_folders and #client.workspace_folders > 0 then
			table.insert(info, "  Workspace folders:")
			for _, folder in ipairs(client.workspace_folders) do
				table.insert(info, "    • " .. folder.name)
			end
		end

		local attached_buffers = vim.tbl_keys(client.attached_buffers or {})
		table.insert(info, "  Attached buffers: " .. #attached_buffers)

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
			table.insert(info, "  Key features: " .. table.concat(key_features, ", "))
		end

		table.insert(info, "")
	end

	local diagnostics = vim.diagnostic.get(bufnr)
	if #diagnostics > 0 then
		local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }
		for _, diagnostic in ipairs(diagnostics) do
			local severity = vim.diagnostic.severity[diagnostic.severity]
			counts[severity] = counts[severity] + 1
		end

		table.insert(info, "󰒡 Diagnostics Summary:")
		table.insert(info, " 󰅚 Errors: " .. counts.ERROR)
		table.insert(info, " 󰀪 Warnings: " .. counts.WARN)
		table.insert(info, " 󰋽 Info: " .. counts.INFO)
		table.insert(info, " 󰌶 Hints: " .. counts.HINT)
		table.insert(info, "  Total: " .. #diagnostics)
	else
		table.insert(info, "󰄬 No diagnostics")
	end

	table.insert(info, "")
	table.insert(info, "Use :LspLog to view detailed logs")
	table.insert(info, "Use :LspCapabilities for full capability list")

	notify(table.concat(info, "\n"))
end

-- Create command
vim.api.nvim_create_user_command("LspInfo", lsp_info, { desc = "Show comprehensive LSP information" })

-- local border = "rounded"
--
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = border,
-- })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 	border = border,
-- })
--
-- vim.diagnostic.config({
-- 	float = { border = border },
-- })
