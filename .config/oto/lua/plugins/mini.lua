return {
	-- {
	-- 	"echasnovski/mini.bracketed",
	-- 	version = "*",
	-- 	event = { "VeryLazy" },
	-- 	config = function()
	-- 		require("configs.bracketed")
	-- 	end,
	-- },
	{
		"echasnovski/mini.clue",
		-- event = { "CmdlineEnter", "CursorHold", "CursorHoldI" },
		keys = {
			{ "<leader>" },
			{ "d" },
			{ "g" },
			{ "z" },
		},
		config = function()
			require("configs.mini.clue")
		end,
	},
	{
		"echasnovski/mini.diff",
		version = "*",
		event = { "VeryLazy" },
		cond = function()
			local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
			return git_root and vim.fn.systemlist("git ls-files --errorunmatch" .. vim.fn.expand("%:p"))[1] ~= nil
		end,
		config = function()
			require("configs.mini.diff")
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		keys = {
			{
				"-",
				function()
					local _ = require("mini.files").close() or require("mini.files").open()
				end,
				"Toggle Mini Files",
			},
		},
		config = function()
			require("configs.mini.files")
		end,
	},
	-- {
	-- 	"echasnovski/mini.fuzzy",
	-- 	version = "*",
	-- 	event = "VeryLazy",
	-- 	config = function() end,
	-- },
	{
		"echasnovski/mini-git",
		version = "*",
		event = "BufReadPre",
		keys = {
			{
				"<leader>gC",
				function()
					MiniGit.show_at_cursor()
				end,
				desc = "Git show at cursor",
			},
		},
		cond = function()
			return vim.fn.system("git rev-parse --is-inside-work-tree"):match("true") ~= nil
		end,
		config = function()
			require("configs.mini.git")
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		cmd = { "ToggleHipatterns" },
		keys = {
			{
				"<leader>hp",
				"<cmd>ToggleHipatterns<cr>",
				"Toggle Mini HiPatterns",
			},
		},
		config = function()
			require("configs.mini.hipatterns")
		end,
	},
	{
		"echasnovski/mini.icons",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("configs.mini.icons")
		end,
	},
	-- {
	-- 	"echasnovski/mini.notify",
	-- 	version = "*",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("configs.mini.notify")
	-- 	end,
	-- },
	-- {
	-- 	"echasnovski/mini.pairs",
	-- 	version = "*",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("configs.mini.pairs")
	-- 	end,
	-- },
	-- {
	-- 	"echasnovski/mini.pick",
	-- 	version = "*",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		{ "echasnovski/mini.extra", version = "*" },
	-- 		{ "echasnovski/mini.misc", version = "*" },
	-- 	},
	-- 	config = function()
	-- 		require("configs.mini.pick")
	-- 	end,
	-- },
	-- {
	-- 	"echasnovski/mini.visits",
	-- 	version = "*",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("mini.visits").setup()
	-- 	end,
	-- },

	-- BUG This bugs float windows
	-- {
	-- 	"echasnovski/mini.statusline",
	-- 	version = "*",
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		require("configs.mini.statusline")
	-- 	end,
	-- },
	{
		"echasnovski/mini.tabline",
		version = "*",
		event = "BufWinEnter",
		-- cond = function()
		--   local buffers = vim.fn.getbufinfo({ buflisted = true })
		--   return #buffers >= 2
		-- end,
		config = function()
			require("configs.mini.tabline")
		end,
	},
}
