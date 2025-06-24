local kanagawa = require("kanagawa")

kanagawa.setup({
	compile = true,
	compile_path = vim.fn.stdpath("cache") .. "/kanagawa",
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	transparent = false,
	colors = {
		palette = {
			sumiInk3 = "#1F1F28", -- Wave has no default background (wtf)
			samuraiRed = "#FF9580",
			fujiGray = "#4c4c55", -- NvChad
			fujiWhite = "#C8C093",
			springViolet1 = "#9c86bf", -- Nvchad
			-- sumiInk4 = "#957FB8",
		},
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	-- overrides = function(colors)
	-- 	local theme = colors.theme
	-- 	return {
	-- 		NormalFloat = { bg = "none" },
	-- 		FloatBorder = { bg = "none" },
	-- 		FloatTitle = { bg = "none" },
	--
	-- 		-- Save an hlgroup with dark background and dimmed foreground
	-- 		-- so that you can use it where your still want darker windows.
	-- 		-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
	-- 		NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
	--
	-- 		-- Popular plugins that open floats will link to NormalFloat by default;
	-- 		-- set their background accordingly if you wish to keep them dark and borderless
	-- 		LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	-- 		MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	-- 	}
	-- end,
})
