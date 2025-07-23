local statusline = require("mini.statusline")

statusline.setup({
	content = {
		active = function()
			local MiniStatusline = require("mini.statusline")
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 1000 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local filename = MiniStatusline.section_filename({ trunc_width = 20 })
			local diagnostics = MiniStatusline.section_diagnostics({ icon = "󰓙", trunc_width = 75 })
			local lint_progress = function()
				local linters = require("lint").get_running()
				if not #linters == 0 then
					return "󱉶" .. table.concat(linters, ", ")
				end

				return "󰦕 " .. table.concat(linters, ", ")
			end
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode:upper() } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, " " .. lint_progress() } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{
					hl = "MiniStatuslineFileinfo",
					strings = {
						vim.bo.filetype ~= ""
							and require("mini.icons").get("filetype", vim.bo.filetype) .. " " .. vim.bo.filetype,
					},
				},
				{ hl = mode_hl, strings = { "%l:%v" } },
			})
		end,
		inactive = statusline.inactive,
	},
	set_vim_settings = true,
})
