local ui = require("configs.ui")
local blink = require("blink.cmp")
require("blink-cmp-copilot")

blink.setup({
	enabled = function()
		return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
			and vim.bo.buftype ~= "prompt"
			and vim.b.completion ~= false
	end,

	cmdline = {
		keymap = {
			preset = "default",
		},
	},

	keymap = {
		preset = "default",

		-- NOTE This is required to use Enter only once to select
		["<CR>"] = { "accept", "fallback" },
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

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },

		-- ['<CR>'] = { 'select_and_accept', 'fallback' },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		trigger = {
			show_on_keyword = true,
			show_on_insert_on_trigger_character = false,
		},
		keyword = { range = "full" },
		menu = {
			border = ui.border("", "WarningMsg", "FloatBorder"), -- 󰷼 󱐋
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
					kind_icon = {
						-- highlight = "BlinkCmpKind",
						ellipsis = false,
					},
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
			winhighlight = "Normal:MeuNormalFloat,FloatBorder:MinhaBordaFloat,CursorLine:MinhaCursorLineFloat,Search:MeuLineNrFloat,LineNr:MeuLineNrFloat,LspReferenceText:MyLspReferenceText",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			treesitter_highlighting = true,
			window = {
				min_width = 15,
				max_width = 120,
				max_height = 40,
				winblend = vim.o.pumblend,
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				winhighlight = "Normal:MeuNormalFloat,FloatBorder:MinhaBordaFloat,CursorLine:MinhaCursorLineFloat,Search:MeuLineNrFloat,LineNr:MeuLineNrFloat,LspReferenceText:MyLspReferenceText",
				-- winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC",
				-- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- winhighlight = "Normal:Comment,CursorLine:Search,Search:PmenuSel,FloatBorder:Comment", -- NvChad personal
				-- winhighlight = "Normal:Normal,CursorLine:CursorLine,Search:Search,FloatBorder:Comment", -- NvChad personal
				-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
				border = ui.border("󰧭", "", "FloatBorder"), -- 󰓼 󰈚 󰧭
			},
		},
		-- list = {
		-- 	selection = function(ctx)
		-- 		return ctx.mode == "cmdline" and "auto_insert" or "preselect"
		-- 	end,
		-- },
	},

	signature = {
		enabled = true,
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			winblend = vim.o.pumblend,
			border = ui.border("", "", "FloatBorder"), --  
			-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			winhighlight = "Normal:MeuNormalFloat,FloatBorder:MinhaBordaFloat,CursorLine:MinhaCursorLineFloat,Search:MeuLineNrFloat,LineNr:MeuLineNrFloat,LspReferenceText:MyLspReferenceText",
			-- winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC",
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
			Variable = "󰀫", -- 󰆦 󰏫 
			Property = "󰏫", -- 󰖷 󰀫 󱐋

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
			Color = "󰏘",
			File = "󰈚", -- 󰈔
			Reference = "", -- 󰬲
			Folder = "󰉋",
			Event = "󰙴", -- 󱐋
			Operator = "", -- 󰪚
			TypeParameter = "󰊄", -- 󰬛
		},
	},
})

vim.api.nvim_set_hl(0, "MeuNormalFloat", { fg = "#C8C093", bg = "#16161D", bold = false }) -- Texto branco, fundo escuro
vim.api.nvim_set_hl(0, "MinhaBordaFloat", { fg = "#54546D", bg = "#16161D", bold = false }) -- Borda azul clara, negrito
vim.api.nvim_set_hl(0, "MinhaCursorLineFloat", { bg = "#54546D", underline = false, bold = true }) -- Fundo cinza escuro, sublinhado
vim.api.nvim_set_hl(0, "MeuLineNrFloat", { fg = "#2D4F67", bg = "#16161D", italic = true }) -- Números azuis, itálico
vim.api.nvim_set_hl(0, "MyLspReferenceText", { fg = "#16161D", bg = "#C8C093", underline = true, italic = true }) -- Números azuis, itálico
