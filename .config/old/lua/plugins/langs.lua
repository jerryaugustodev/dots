return {
	-- Go Stuffs
	{
		"ray-x/go.nvim",
		-- enabled = false,
		-- event = { "CmdlineEnter" },
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			-- "neovim/nvim-lspconfig",
			-- "nvim-treesitter/nvim-treesitter",
			--
			-- "leoluz/nvim-dap-go",
		},
		config = function()
			-- require("go").setup()
			require("configs.go")
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},

	-- TypeScript Stuffs
	-- {
	-- "pmizio/typescript-tools.nvim",
	-- ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "tsx", "jsx" },
	-- dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- opts = {},
	-- config = function()
	--   require("configs.typescript")
	-- end,
	-- },
}
