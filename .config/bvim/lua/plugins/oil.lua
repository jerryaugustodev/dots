return {
	"stevearc/oil.nvim",
	keys = {
		{
			"-",
			function()
				require("oil").toggle_float()
			end,
			desc = "Oil File Explorer",
		},
	},
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		keymaps = {
			["<Esc>"] = { "actions.close", mode = "n" },
			["<C-c>"] = "actions.close",
			["q"] = "actions.close",
			["<cr>"] = "actions.select",
			["<C-r>"] = "actions.refresh",
			["<S-h>"] = { "actions.toggle_hidden", mode = "n" },
		},

		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true, -- Show hidden files
			is_open = true,     -- Ensure directories open automatically
		},
		float = {
			padding = 5, -- Add padding around floating window
			max_width = 140,
			max_height = 0,
			border = "rounded",
		},
	}
}
