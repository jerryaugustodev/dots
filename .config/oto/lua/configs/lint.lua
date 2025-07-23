local lint = require("lint")

lint.linters_by_ft = {
	["*"] = { "cspell", "codespell" },
	bash = { "bash" },
	css = { "biomejs" },
	docker = { "hadolint" },
	fish = { "fish" },
	go = { "golangcilint" },
	html = { "biomejs" },
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	json = { "biomejs" },
	jsonc = { "biomejs" },
	lua = { "selene" },
	markdown = { "markdownlint-cli2" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
