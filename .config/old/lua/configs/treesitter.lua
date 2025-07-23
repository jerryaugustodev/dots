local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	ensure_installed = { "http", "lua", "typescript", "javascript", "html", "css", "go", "gomod", "gosum", "gowork" },
	auto_install = false,
	sync_install = false,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 24 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false, -- performance
	},
	autotag = { enabled = true },
	ignore_install = { "javascript" },
	modules = {},
	indent = { enabled = true },
	matchup = {
		enable = true,
	},
	{
		context_commentstring = {
			enable = true,
			enable_autocmd = true,
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>v",
			node_incremental = "=",
			scope_incremental = false,
			node_decremental = "-",
		},
	},
	textobjects = {
		lsp_interop = {
			enabled = true,
			border = "none",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "around a function" },
				["if"] = { query = "@function.inner", desc = "inner part of a function" },
				["ac"] = { query = "@class.outer", desc = "around a class" },
				["ic"] = { query = "@class.inner", desc = "inner part of a class" },
				["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
				["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
				["al"] = { query = "@loop.outer", desc = "around a loop" },
				["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
				["ap"] = { query = "@parameter.outer", desc = "around parameter" },
				["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@parameter.inner"] = "v", -- charwise
				["@function.outer"] = "v", -- charwise
				["@conditional.outer"] = "V", -- linewise
				["@loop.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_previous_start = {
				["[f"] = { query = "@function.outer", desc = "Previous function" },
				["[c"] = { query = "@class.outer", desc = "Previous class" },
				["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
			},
			goto_next_start = {
				["]f"] = { query = "@function.outer", desc = "Next function" },
				["]c"] = { query = "@class.outer", desc = "Next class" },
				["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, "<leader>;", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, "<leader>,", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- This repeats the last query with always previous direction and to the start of the range.
vim.keymap.set({ "n", "x", "o" }, "<home>", function()
	ts_repeat_move.repeat_last_move({ forward = false, start = true })
end)

-- This repeats the last query with always next direction and to the end of the range.
vim.keymap.set({ "n", "x", "o" }, "<end>", function()
	ts_repeat_move.repeat_last_move({ forward = true, start = false })
end)
