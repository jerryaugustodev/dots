local statusline = require("mini.statusline")
local _ = require("configs.nativeline")

statusline.setup({
	content = {
		active = function()
			local MiniStatusline = require("mini.statusline")
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 1000 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			-- local filename = MiniStatusline.section_filename({ trunc_width = 20 })
			local filename = vim.fn.expand("%:~:.")
			-- local diagnostics = MiniStatusline.section_diagnostics({ icon = "󰓙", trunc_width = 75 })
			local diagnostics = _G.diagnostics_summary()
			local git_branch = _G.git_branch()
			local diff = statusline.section_diff({ trunc_width = 75 })
			local git_log = _G.git_log()
			local git_changes = _G.git_changes()
			local lsp = _G.lsp_status()
			local linters = _G.active_linters_and_formatters()
			local search = statusline.section_searchcount({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode:upper() } },
				{ hl = "MiniStatuslineDevinfo", strings = { git_branch, git_log, git_changes, diff } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { diagnostics, filename } },
				"%=", -- End left alignment
				{
					hl = "MiniStatuslineFileinfo",
					strings = {
						lsp,
						linters,
						vim.bo.filetype ~= ""
							and require("mini.icons").get("filetype", vim.bo.filetype) .. " " .. vim.bo.filetype,
						search,
					},
				},
				{ hl = mode_hl, strings = { "%l:%v" } },
			})
		end,
		inactive = statusline.inactive,
	},
	set_vim_settings = true,
})
