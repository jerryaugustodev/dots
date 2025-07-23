return {
	"mistricky/codesnap.nvim",
	build = "make",
	keys = {
		{
			"<leader>cc",
			function()
				require("codesnap").copy_into_clipboard()
			end,
			mode = { "x", "n" },
			desc = "Save selected code snapshot into clipboard",
		},
		{
			"<leader>cs",
			function()
				require("codesnap").save_snapshot()
			end,
			mode = { "x", "n" },
			desc = "Save selected code snapshot in ~/Pictures",
		},
	},
	opts = {
		title = "CodeSnap",
		save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
		has_breadcrumbs = true,
		has_line_number = true,
		mac_window_bar = false,
		code_font_family = "JetBrainsMono Nerd Font",
		bg_theme = "dusk",
		-- bg_color = "#1F1F28",
		watermark = "@jerryaugustodev",
	},
}
