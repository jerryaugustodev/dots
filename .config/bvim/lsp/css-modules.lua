---@brief
---
--- https://github.com/antonk52/cssmodules-language-server
---
--- Language server for autocompletion and go-to-definition functionality for CSS modules.
---
--- You can install cssmodules-language-server via npm:
--- ```sh
--- npm install -g cssmodules-language-server
--- ```
-- local blink = require("blink.cmp")

return {
	cmd = { "cssmodules-language-server" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json" },
	-- capabilities = vim.tbl_deep_extend(
	-- 	"force",
	-- 	{},
	-- 	vim.lsp.protocol.make_client_capabilities(),
	-- 	blink.get_lsp_capabilities(),
	-- 	{
	-- 		fileOperations = {
	-- 			didRename = true,
	-- 			willRename = true,
	-- 		},
	-- 	}
	-- ),
}
