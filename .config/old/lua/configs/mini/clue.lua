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
		{ mode = "n", keys = "<leader>f", desc = "Fuzzy search" },
		{ mode = "n", keys = "<leader>g", desc = "Git" },
		{ mode = "n", keys = "<leader>l", desc = "LSP" },
		{ mode = "n", keys = "<leader>t", desc = "Split" },
		{ mode = "n", keys = "<leader>s", desc = "Tabs" },
		{ mode = "n", keys = "<leader>u", desc = "Snack Toggles" },
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
