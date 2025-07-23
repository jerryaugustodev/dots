local kanagawa = require("kanagawa")
local is_neovide = not vim.g.neovide

kanagawa.setup({
    compile = true,
    compile_path = vim.fn.stdpath("cache") .. "/kanagawa",
    commentStyle = { italic = false },
    -- functionStyle = { bold = true },
    keywordStyle = { italic = false },
    transparent = is_neovide and true or false,
    -- transparent = false,
    -- typeStyle = { bold = true },
    dimInactive = true,
    colors = {
        palette = {
            sumiInk3 = "#16161D", -- Wave has no default background (wtf)
            samuraiRed = "#FF9580",
            -- fujiGray = "#4c4c55", -- NvChad
            fujiWhite = "#C8C093",
            -- springViolet1 = "#9c86bf", -- Nvchad
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
    overrides = function(colors)
        local theme = colors.theme
        return {
            -- Custom highlight mappings for specific Tree-sitter Markdown captures.
            -- This configuration enhances the visual distinction of various markdown elements,
            -- such as links, labels, inline code, lists, quotes, and task states, by associating
            -- each capture group with an appropriate Neovim highlight group.
            -- ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- Inline markdown URLs (e.g., (url))
            -- ["markdownLink"] = { link = "Special" }, -- Inline markdown URLs (e.g., (url))
            -- ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- Markdown link labels (e.g., [label])
            -- ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- Italic text in markdown (e.g., *italic*)
            -- ["@markup.raw.markdown_inline"] = { link = "String" }, -- Inline code blocks in markdown (e.g., `code`)
            -- ["@markup.list.markdown"] = { link = "Function" }, -- List items in markdown (e.g., + list)
            -- ["@markup.quote.markdown"] = { link = "Error" }, -- Blockquotes in markdown (e.g., > blockquote)
            -- ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- Checked list items in markdown (e.g., - [x] checked)

            -- Transparent background
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Credit to https://github.com/rebelot/kanagawa.nvim/pull/268
            -- SnacksDashboard
            SnacksDashboardHeader = { fg = theme.vcs.removed },
            SnacksDashboardFooter = { fg = theme.syn.comment },
            SnacksDashboardDesc = { fg = theme.syn.identifier },
            SnacksDashboardIcon = { fg = theme.ui.special },
            SnacksDashboardKey = { fg = theme.syn.special1 },
            SnacksDashboardSpecial = { fg = theme.syn.comment },
            SnacksDashboardDir = { fg = theme.syn.identifier },
            -- SnacksNotifier
            SnacksNotifierBorderError = { link = "DiagnosticError" },
            SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
            SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
            SnacksNotifierBorderDebug = { link = "Debug" },
            SnacksNotifierBorderTrace = { link = "Comment" },
            SnacksNotifierIconError = { link = "DiagnosticError" },
            SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
            SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
            SnacksNotifierIconDebug = { link = "Debug" },
            SnacksNotifierIconTrace = { link = "Comment" },
            SnacksNotifierTitleError = { link = "DiagnosticError" },
            SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
            SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
            SnacksNotifierTitleDebug = { link = "Debug" },
            SnacksNotifierTitleTrace = { link = "Comment" },
            SnacksNotifierError = { link = "DiagnosticError" },
            SnacksNotifierWarn = { link = "DiagnosticWarn" },
            SnacksNotifierInfo = { link = "DiagnosticInfo" },
            SnacksNotifierDebug = { link = "Debug" },
            SnacksNotifierTrace = { link = "Comment" },
            -- SnacksProfiler
            SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
            SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
            SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
            SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
            SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
            SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
            SnacksZenIcon = { fg = theme.syn.statement },
            SnacksInputIcon = { fg = theme.ui.pmenu.bg },
            SnacksInputBorder = { fg = theme.syn.identifier },
            SnacksInputTitle = { fg = theme.syn.identifier },
            -- SnacksPicker
            SnacksPickerInputBorder = { fg = theme.syn.constant },
            SnacksPickerInputTitle = { fg = theme.syn.constant },
            SnacksPickerBoxTitle = { fg = theme.syn.constant },
            SnacksPickerSelected = { fg = theme.syn.number },
            SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
            SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
            SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
        }
    end,
})
