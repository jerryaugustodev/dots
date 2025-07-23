---@brief
---
--- Language Server for the Prisma JavaScript and TypeScript ORM
---
--- `@prisma/language-server` can be installed via npm
--- ```sh
--- npm install -g @prisma/language-server
--- ```

local blink = require("blink.cmp")

return {
	cmd = { "prisma-language-server", "--stdio" },
	filetypes = { "prisma" },
	settings = {
		prisma = {
			prismaFmtBinPath = "",
		},
	},
	root_markers = { ".git", "package.json" },

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
