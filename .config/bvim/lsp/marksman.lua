---@brief
---
--- https://github.com/artempyanykh/marksman
---
--- Marksman is a Markdown LSP server providing completion, cross-references, diagnostics, and more.
---
--- Marksman works on MacOS, Linux, and Windows and is distributed as a self-contained binary for each OS.
---
--- Pre-built binaries can be downloaded from https://github.com/artempyanykh/marksman/releases

local bin_name = "marksman"
local cmd = { bin_name, "server" }
local blink = require("blink.cmp")

return {
	cmd = cmd,
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".marksman.toml", ".git" },

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
