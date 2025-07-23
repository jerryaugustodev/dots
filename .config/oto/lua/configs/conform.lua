local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		fish = { "fish_indent" },
		bash = { "shellharden" },
		css = { "biome" },
		go = { "goimports-reviser", "gofumpt" },
		html = { "prettierd" },
		graphql = { "biome" },
		javascript = { "biome" },
		javascriptreact = { "rustywind", "biome" },
		json = { "biome" },
		jsonc = { "biome" },
		markdown = { "biome" },
		rust = { "rustfmt" },
		typescript = { "biome" },
		typescriptreact = { "rustywind", "biome" },
		toml = { "taplo" },
		yaml = { "yamlfmt" },
		["*"] = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	-- formatters = {
	--   biome = {
	--     condition = function()
	--       return vim.loop.fs_realpath(".prettierrc.js") ~= nil or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
	--     end,
	--   },
	-- },
})
