local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
				})
			end,
		})
	end
end

local servers = {
	biome = {},
	gopls = {},
	cssls = {},
	vtsls = {},
	-- ts_ls = {},
	emmet_language_server = {
		filetypes = {
			"css",
			"svelte",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"pug",
			"typescriptreact",
		},
		-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
		-- **Note:** only the options listed in the table are supported.
		init_options = {
			---@type table<string, string>
			includeLanguages = {},
			--- @type string[]
			excludeLanguages = {},
			--- @type string[]
			extensionsPath = {},
			--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
			preferences = {},
			--- @type boolean Defaults to `true`
			showAbbreviationSuggestions = true,
			--- @type "always" | "never" Defaults to `"always"`
			showExpandedAbbreviation = "always",
			--- @type boolean Defaults to `false`
			showSuggestionsAsSnippets = false,
			--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
			syntaxProfiles = {},
			--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
			variables = {},
		},
	},
	tailwindcss = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
}

for server, opts in pairs(servers) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, opts))
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- local conform = require("conform")
		--- Set minipick as default picker
		-- local pick = require("mini.pick")
		-- vim.ui.select = pick.ui_select

		-- Diagnostics mappings
		-- NOTE alredy native
		-- map("n", "[d", function()
		-- 	vim.diagnostic.goto_prev({ float = false })
		-- end, "Diagnostics goto_prev")
		--
		-- map("n", "]d", function()
		-- 	vim.diagnostic.goto_next({ float = false })
		-- end, "Diagnostics goto_next")
		local function map(mode, keys, action, desc)
			desc = desc or ""
			-- local opts = { noremap = true, remap = true, silent = true, desc = desc }
			local opts = { noremap = true, silent = true, desc = desc }
			vim.keymap.set(mode, keys, action, opts)
		end

		map("n", "ds", vim.diagnostic.setloclist, "Add buffer diagnostics to the location list.")

		-- map("n", "<leader>hi", function()
		-- 	modules.toggle_inlay_hint() -- toggle inlay hint
		-- end, "Toggle inlay hint")
		-- map("n", "<leader>hi", function()
		-- 	local is_enabled = vim.lsp.inlay_hint.is_enabled()
		-- 	vim.lsp.inlay_hint.enable(not is_enabled)
		-- end, "Toggle inlay hints")

		-- map("n", "<leader>K", vim.lsp.buf.hover, "Open lsp hover")
		map("n", "df", function()
			vim.diagnostic.open_float()
		end, "Open diagnostics float ")
		map("n", "<leader>ld", vim.lsp.buf.definition, "Goto lsp definition")
		map("n", "<leader>lh", vim.lsp.buf.declaration, "Goto lsp declaration")
		map("n", "<leader>lt", vim.lsp.buf.type_definition, "Goto lsp type definition")
		map("n", "<leader>ls", vim.lsp.buf.document_symbol, "Document symbols")
		map("n", "<leader>li", vim.lsp.buf.implementation, "Goto lsp implementation")
		map("n", "<leader>lR", vim.lsp.buf.references, "Goto lsp reference")
		map("n", "<leader>lr", vim.lsp.buf.rename, "Lsp rename")
		map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Open lsp code action")
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

-- require("lspconfig").biome.setup { capabilities = capabilities }
-- require("lspconfig").cssls.setup { capabilities = capabilities }
-- require("lspconfig").gopls.setup { capabilities = capabilities }
-- require("lspconfig").lua_ls.setup { capabilities = capabilities }
-- require("lspconfig").emmet_language_server.setup { capabilities = capabilities }
-- require("lspconfig").tailwindcss.setup { capabilities = capabilities }
-- require("lspconfig").html.setup { capabilities = capabilities }

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then
--       return
--     end
--
--     if client.supports_method("textDocument/formatting") then
--       -- Format the current buffer on save
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = args.buf,
--         callback = function()
--           require("conform").format({
--             lsp_fallback = true,
--             async = false,
--           })
--           -- vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
--         end,
--       })
--     end
--   end,
-- })

-- decreases the frequency of diagnoses.
vim.diagnostic.config({
	update_in_insert = false, -- Does not update diagnostics in insert mode
	virtual_text = false, -- Reduces visual noise
	signs = true, -- Show error icons in gutter
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})
