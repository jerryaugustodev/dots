local blink = require("blink.cmp")
require("blink-cmp-copilot")

blink.setup({
	enabled = function()
		return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
			and vim.bo.buftype ~= "prompt"
			and vim.b.completion ~= false
	end,

    cmdline = { enabled = true },
	-- cmdline = {
	-- 	keymap = {
	-- 		preset = "default",
	-- 	},
	-- },

	keymap = {
		preset = "default",

		-- NOTE This is required to use Enter only once to select
		["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },

		["<M-1>"] = {
			function(cmp)
				cmp.accept({ index = 1 })
			end,
		},
		["<M-2>"] = {
			function(cmp)
				cmp.accept({ index = 2 })
			end,
		},
		["<M-3>"] = {
			function(cmp)
				cmp.accept({ index = 3 })
			end,
		},
		["<M-4>"] = {
			function(cmp)
				cmp.accept({ index = 4 })
			end,
		},
		["<M-5>"] = {
			function(cmp)
				cmp.accept({ index = 5 })
			end,
		},
		["<M-6>"] = {
			function(cmp)
				cmp.accept({ index = 6 })
			end,
		},
		["<M-7>"] = {
			function(cmp)
				cmp.accept({ index = 7 })
			end,
		},
		["<M-8>"] = {
			function(cmp)
				cmp.accept({ index = 8 })
			end,
		},
		["<M-9>"] = {
			function(cmp)
				cmp.accept({ index = 9 })
			end,
		},
		["<M-0>"] = {
			function(cmp)
				cmp.accept({ index = 10 })
			end,
		},

		-- ['<CR>'] = { 'select_and_accept', 'fallback' },
		-- ["<Tab>"] = { "select_next", "fallback" },
		-- ["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		trigger = {
			show_on_keyword = true,
			show_on_insert_on_trigger_character = false,
		},
		keyword = { range = "full" },
		menu = {
			-- border = border(""), -- 
            -- border = "single",
			min_width = vim.o.pumwidth,
			max_height = 30,
			winblend = vim.o.pumblend,
			scrollbar = false,

			-- cmdline_position = function()
			-- 	if vim.g.ui_cmdline_pos ~= nil then
			-- 		local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
			-- 		return { pos[1] - 1, pos[2] }
			-- 	end
			-- 	local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
			-- 	return { vim.o.lines - height, 0 }
			-- end,

			draw = {
				columns = {
					{ "item_idx" },
					{ "label", "label_description", gap = 1 },
					{ "kind_icon" },
					{ "kind" },
				},
				components = {
					-- customize the drawing of kind icons
					kind_icon = {
						text = function(ctx)
						  -- default kind icon
						  local icon = ctx.kind_icon
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == "LSP" then
								local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr ~= "" then
								  icon = color_item.abbr
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							-- default highlight group
							local highlight = "BlinkCmpKind" .. ctx.kind
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == "LSP" then
								local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr_hl_group then
								  highlight = color_item.abbr_hl_group
								end
							end
							return highlight
						end,
					},
					-- kind_icon = {
					-- 	-- highlight = "BlinkCmpKind",
					-- 	ellipsis = false,
					-- },
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpGhostText", -- optional, only if you want to change its color
					},
					label = {
						text = require("colorful-menu").blink_components_text,
						highlight = require("colorful-menu").blink_components_highlight,
					},
					-- label_description = { highlight = "BlinkCmpLabelDescription" },
				},
			},
			-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			-- winhighlight = "Normal:Normal,CursorLine:CursorLine,Search:Search,FloatBorder:Comment", -- NvChad personal
			-- winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC",
			-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			-- treesitter_highlighting = true,
			window = {
				min_width = 15,
				max_width = 120,
				max_height = 40,
				winblend = vim.o.pumblend,
                -- border = "single",
				-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
				-- winhighlight = "Normal:Normal,CursorLine:CursorLine,Search:Search,FloatBorder:Comment", -- NvChad personal
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
				-- border = border("󰧭"), -- 󰓼 󰈚
			},
		},
		-- list = {
		-- 	selection = function(ctx)
		-- 		return ctx.mode == "cmdline" and "auto_insert" or "preselect"
		-- 	end,
		-- },
	},

	signature = {
		enabled = false,
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			winblend = vim.o.pumblend,
            -- border = "single",
			-- border = border(""), -- 󰷼 󱐋
			-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			-- winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
			-- winhighlight = "Normal:Normal,CursorLine:CursorLine,Search:Search,FloatBorder:Comment", -- NvChad personal
			-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
		},
	},

	sources = {
		-- Dynamically picking providers by treesitter node/filetype
		default = function()
			local success, node = pcall(vim.treesitter.get_node)
			if vim.bo.filetype == "lua" then
				return { "lsp", "path", "copilot" }
			elseif
				success
				and node
				and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
			then
				return { "buffer" }
			else
				return { "lsp", "path", "buffer", "copilot", "snippets" }
			end
		end,
		-- cmdline = {},
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
				transform_items = function(_, items)
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1
					CompletionItemKind[kind_idx] = "Copilot"
					for _, item in ipairs(items) do
						item.kind = kind_idx
					end
					return items
				end,
			},
			snippets = {
				min_keyword_length = 3,
			},
		},
	},

	appearance = {
		use_nvim_cmp_as_default = true, -- required for custom color-types
		nerd_font_variant = "normal", -- "normal" for nerd fonts

		kind_icons = {
			Copilot = "", --  
			Text = "󰉿",
			Method = "", -- 󰊕
			Function = "󰡱", -- 󰊕
			Constructor = "", -- 󰒓

			Field = "󰜢",
			Variable = "󰏫", -- 󰆦 󰏫 
			Property = "󰀫", -- 󰖷 󰀫 󱐋

			Class = "󰆦", -- 󱡠
			Interface = "󰆩", -- 󱡠
			Struct = "󰜬", -- 󱡠
			Module = "󰜋", -- 󰅩

			Unit = "󰘨", -- 󰪚
			Value = "󰆙", -- 󰦨
			Enum = "󰪚", -- 󰦨
			EnumMember = "", -- 󰦨

			Keyword = "󱕵", -- 󰻾
			Constant = "󰕶", -- 󰏿

			Snippet = "󰴹", -- 󱄽
			Color = "󱓻", -- 󰏘
			File = "󰈚", -- 󰈔
			Reference = "", -- 󰬲
			Folder = "󰉋", -- 󰉋
			Event = "󰙴", -- 󱐋
			Operator = "", -- 󰪚
			TypeParameter = "󰊄", -- 󰬛
		},
	},
    fuzzy = { implementation = "prefer_rust" },
})
