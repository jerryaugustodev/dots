local clue = require("mini.clue")

clue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>", desc = "Leader key" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },

		-- Diagnostics keys
		{ mode = "n", keys = "d", desc = "Diagnostics" },
	},

	clues = {
		{ mode = "n", keys = "<leader>b", desc = "Buffers" },
		{ mode = "n", keys = "<leader>c", desc = "CodeSnap" },
		{ mode = "n", keys = "<leader>d", desc = "Docker" },
		{ mode = "n", keys = "<leader>f", desc = "Fuzzy Finder" },
		{ mode = "n", keys = "<leader>g", desc = "Git" },
		{ mode = "n", keys = "<leader>l", desc = "LSP" },
		{ mode = "n", keys = "<leader>t", desc = "Test" },
		{ mode = "n", keys = "<leader>T", desc = "Tabs" },
		{ mode = "n", keys = "<leader>k", desc = "Kulala" },
		{ mode = "n", keys = "<leader>s", desc = "Search" },
		{ mode = "n", keys = "<leader>S", desc = "Split" },
		{ mode = "n", keys = "<leader>u", desc = "Snack Toggles" },
		-- { mode = "n", keys = "<leader>o", desc = "Orgmode" },
		-- Enhance this by adding descriptions for <Leader> mapping groups
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		clue.gen_clues.windows(),
		clue.gen_clues.z(),
	},

	window = {
		delay = 500,
	},
})
