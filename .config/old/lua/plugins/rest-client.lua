return {
	-- Kulala Rest Client
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{
				"<leader>kr",
				function()
					require("kulala").run()
				end,
				desc = "Send request",
			},
			{
				"<leader>ka",
				function()
					require("kulala").run_all()
				end,
				desc = "Send all requests",
			},
			{
				"<leader>kk",
				function()
					require("kulala").replay()
				end,
				desc = "Open scratchpad",
			},
		},
		ft = { "http", "rest" },
		opts = {
			-- your configuration comes here
			global_keymaps = false,
			ui = {
				-- display mode: possible values: "split", "float"
				display_mode = "float",
				icons = {
					inlay = {
						loading = "󱎫", -- ⏳
						done = "", -- ✅
						error = "", -- ❌
					},
					-- lualine = "🐼",
				},
			},
		},
	},

	-- Rest.nvim Rest Client
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	main = "rest-nvim",
	-- 	ft = { "http", "rest" },
	-- 	cmd = "Rest",
	-- 	keys = {
	-- 		{ "<leader>rr", "<cmd>Rest run<cr>", desc = "Execute HTTP client" },
	-- 	},
	-- 	config = function()
	-- 		require("configs.rest")
	-- 	end,
	-- },
}
