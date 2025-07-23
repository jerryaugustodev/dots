return {
	-- Kanagawa the - G O A T - colorscheme ever!
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("configs.kanagawa")
		end,
		init = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	-- {
	-- 	"zenbones-theme/zenbones.nvim",
	-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	-- 	dependencies = "rktjmp/lush.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	-- you can set set configuration options here
	-- 	config = function()
	-- 		-- vim.g.zenbones_darken_comments = 45
	-- 		vim.cmd.colorscheme("kanagawabones")
	-- 	end,
	-- },

	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("configs.scrollbar")
		end,
	},

	-- Yanky Improved
	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = {
			ring = { storage = "sqlite" },
		},
		keys = {
			-- { "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
			{
				"<leader>p",
				function()
					Snacks.picker.yanky()
				end,
				mode = { "n", "x" },
				desc = "Open Yank History",
			},
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
			{ "<c-s-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
			{ "<c-s-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
		config = function()
			require("configs.yanky")
		end,
	},

	-- Beautiful floating terminal manager for Neovim
	-- {
	-- 	"nvzone/floaterm",
	-- 	dependencies = "nvzone/volt",
	-- 	cmd = "FloatermToggle",
	-- 	opts = {
	-- 		border = true,
	-- 	},
	-- },

	-- Needed terminal stuffs
	{ "akinsho/toggleterm.nvim", version = "*", cmd = "ToggleTerm", config = true },

	-- Lazydocker stuffs
	{
		"mgierada/lazydocker.nvim",
		-- dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({
				border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
			})
		end,
		-- event = "BufRead",
		keys = {
			{
				"<leader>ld",
				function()
					require("lazydocker").open()
				end,
				desc = "Open Lazydocker floating window",
			},
		},
	},

	-- Blink Completions
	{
		"saghen/blink.cmp",
		event = "InsertEnter", -- Only loads when entering insert mode
		dependencies = {
			-- { "Kaiser-Yang/blink-cmp-git" },
			{ "rafamadriz/friendly-snippets" },
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("configs.copilot")
				end,
			},
			{ "giuxtaposition/blink-cmp-copilot" },
		},
		version = "1.*",
		config = function()
			require("configs.blink")
		end,
	},
	-- Blink Colorize Suggestoins
	{
		"xzbdmw/colorful-menu.nvim",
		event = "InsertEnter",
		config = function()
			require("configs.colorful-menu")
		end,
	},

	-- Linter Stuffs
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePre" },
		config = function()
			require("configs.lint")
		end,
	},

	-- Conform Formater
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>lf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Conform format",
			},
		},
		config = function()
			require("configs.conform")
		end,
	},

	{
		"altermo/ultimate-autopair.nvim",
		event = { "VeryLazy" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},

	-- Oil File Explorer
	{
		"stevearc/oil.nvim",
		keys = {
			{
				"<space>e",
				function()
					require("oil").toggle_float()
				end,
				desc = "Oil File Explorer",
			},
		},
		config = function()
			require("configs.oil")
		end,
	},

	-- Telescope Stuffs
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	event = "VeryLazy",
	-- 	cmd = "Telescope",
	-- 	tag = "0.1.8",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		{
	-- 			"nvim-telescope/telescope-fzf-native.nvim",
	-- 			build = "make",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("configs.telescope")
	-- 	end,
	-- },

	-- Treesitter Stuffs
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" }, -- Loads only when opening a file
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},

	-- Illuminate Stuffs
	{
		"RRethy/vim-illuminate",
		event = { "VeryLazy" },
		-- event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Previous Reference" },
		},
		config = function()
			require("configs.illuminate")
		end,
	},

	-- Language Server Protocol stuffs
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("configs.lsp")
		end,
	},

	{
		"mg979/vim-visual-multi",
		keys = {
			"<C-n>", -- Start Visual Multi
		},
	},
}
