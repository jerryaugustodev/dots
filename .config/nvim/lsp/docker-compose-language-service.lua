---@brief
---
--- https://github.com/microsoft/compose-language-service
--- This project contains a language service for Docker Compose.
---
--- `compose-language-service` can be installed via `npm`:
---
--- ```sh
--- npm install @microsoft/compose-language-service
--- ```
---
--- Note: If the docker-compose-langserver doesn't startup when entering a `docker-compose.yaml` file, make sure that the filetype is `yaml.docker-compose`. You can set with: `:set filetype=yaml.docker-compose`.

local blink = require("blink.cmp")

return {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },

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
