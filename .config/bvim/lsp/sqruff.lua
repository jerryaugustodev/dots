---@brief
---
--- https://github.com/quarylabs/sqruff
---
--- `sqruff` can be installed by following the instructions [here](https://github.com/quarylabs/sqruff?tab=readme-ov-file#installation)
---

local blink = require("blink.cmp")

return {
	cmd = { "sqruff", "lsp" },
	filetypes = { "sql" },
	root_markers = { ".sqruff", ".git" },

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
