---@brief
---
--- https://pgtools.dev
---
--- A collection of language tools and a Language Server Protocol (LSP) implementation for Postgres, focusing on developer experience and reliable SQL tooling.

local blink = require("blink.cmp")

return {
	cmd = { "postgrestools", "lsp-proxy" },
	filetypes = {
		"sql",
	},
	root_markers = { "postgrestools.jsonc" },

	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities(),
		{
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		}
	),
}
