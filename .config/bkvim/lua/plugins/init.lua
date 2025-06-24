-- Native terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

local job_id = 0
vim.keymap.set("n", "<leader>th", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

vim.keymap.set("n", "<space>tgr", function()
	vim.fn.chansend(job_id, { "go run *.go\r\n" })
end)
vim.keymap.set("n", "<space>tgb", function()
	vim.fn.chansend(job_id, { "go build\r\n" })
end)

-- Float terminal
local state = {
	floating = {
		buf = 1,
		win = 1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create u buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n><c-w>q")
vim.keymap.set({ "n", "t" }, "<space>tf", toggle_terminal)

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

	-- Blink Completions
	{
		"saghen/blink.cmp",
		event = "InsertEnter", -- Only loads when entering insert mode
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("configs.copilot")
				end,
			},
			{ "giuxtaposition/blink-cmp-copilot" },
		},
		version = "*",
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
			{ "]w", desc = "Next Reference" },
			{ "[w", desc = "Previous Reference" },
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
}
