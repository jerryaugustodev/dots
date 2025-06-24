local lint = require("lint")

lint.linters_by_ft = {
	lua = { "selene" },
	go = { "golangcilint" },
	css = { "biomejs" },
	html = { "biomejs" },
	markdown = { "markdownlint-cli2" },
	bash = { "bash" },
	fish = { "fish" },
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	yaml = { "yamllint" },
	json = { "biomejs" },
	jsonc = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
