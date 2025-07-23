local git = require("mini.git")

git.setup({
	integratins = {
		diff = true,
		blame = true,
		status = true,
	},
	use_icons = true,
	blame_format = "<author>, <date> - <summary>",
	mappings = {
		blame = "<leader>Gb",
		diff_preview = "<leader>Gd",
		pull = "<leader>Gp",
		push = "<leader>GP",
	},
})
