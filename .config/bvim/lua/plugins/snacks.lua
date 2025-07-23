return {
    "folke/snacks.nvim",
    -- priority = 1000,
    event = "VeryLazy",
    -- lazy = false,

    -- NOTE: Options
    ---@type snacks.Config
    opts = {
        -- Styling for each Item of Snacks
        styles = {
            input = {
                keys = {
                    n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                    i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                },
            },
        },
        -- Snacks Modules
        animate = { enabled = false },
        bigfile = { enabled = false },
        dashboard = {
            enabled = false,
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
                {
                    section = "terminal",
                    cmd = "ascii-image-converter ~/dots/.config/hypr/wallpapers/dota2-738-map.jpg -C -c",
                    random = 10,
                    pane = 2,
                    indent = 4,
                    height = 30,
                },
            },
        },
        explorer = { enabled = false },
        git = { enabled = false },
        gitbrowser = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        layout = { enabled = false },
        lazygit = { enabled = false },
        terminal = { enabled = false },
        quickfile = {
            enabled = true,
            exclude = { "latex" },
        },
        -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
        picker = {
            enabled = false,
            matchers = {
                frecency = true,
                cwd_bonus = false,
            },
            formatters = {
                file = {
                    filename_first = false,
                    filename_only = false,
                    icon_width = 2,
                },
            },
            layout = {
                -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                -- override picker layout in keymaps function as a param below
                -- preset = "sidebar", -- defaults to this layout unless overidden
                -- layout = { position = "bottom" },
                cycle = true,
                --- Use the default layout or vertical if the window is too narrow
                preset = function()
                    return vim.o.columns >= 120 and "default" or "vertical"
                end,
            },
            layouts = {
                select = {
                    preview = true,
                    layout = {
                        backdrop = false,
                        width = 0.6,
                        min_width = 80,
                        height = 0.4,
                        min_height = 10,
                        box = "vertical",
                        border = "rounded",
                        title = "{title}",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                    },
                },
                telescope = {
                    reverse = false, -- set to false for search bar to be on top
                    layout = {
                        box = "horizontal",
                        backdrop = false,
                        width = 0.8,
                        height = 0.9,
                        border = "none",
                        {
                            box = "vertical",
                            { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                            {
                                win = "input",
                                height = 1,
                                border = "rounded",
                                title = "{title} {live} {flags}",
                                title_pos = "center",
                            },
                        },
                        {
                            win = "preview",
                            title = "{preview:Preview}",
                            width = 0.50,
                            border = "rounded",
                            title_pos = "center",
                        },
                    },
                },
                ivy = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        width = 0,
                        height = 0.4,
                        position = "bottom",
                        border = "top",
                        title = " {title} {live} {flags}",
                        title_pos = "left",
                        { win = "input", height = 1, border = "bottom" },
                        {
                            box = "horizontal",
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                        },
                    },
                },
            },
            ---@class snacks.picker.icons
            icons = {
                files = {
                    enabled = true, -- show file icons
                    dir = "󰉋 ",
                    dir_open = "󰝰 ",
                    file = "󰈚 ", -- 󰈔
                },
                keymaps = {
                    nowait = "󰓅 ",
                },
                tree = {
                    vertical = "│ ",
                    middle = "├╴",
                    last = "└╴",
                },
                undo = {
                    saved = " ",
                },
                ui = {
                    live = "󰐰 ",
                    hidden = "h",
                    ignored = "i",
                    follow = "f",
                    selected = "● ",
                    unselected = "○ ",
                    -- selected = " ",
                },
                git = {
                    enabled = true, -- show git icons
                    commit = "󰜘 ", -- used by git log
                    staged = "●", -- staged changes. always overrides the type icons
                    added = "",
                    deleted = "",
                    ignored = " ",
                    modified = "○",
                    renamed = "",
                    unmerged = " ",
                    untracked = "?",
                },
                diagnostics = {
                    Error = "󰅚 ", -- 
                    Warn = "󰀪 ", -- 
                    Hint = "󰌶 ", -- 
                    Info = "󰋽 ", -- 
                },
                lsp = {
                    unavailable = "",
                    enabled = " ",
                    disabled = " ",
                    attached = "󰖩 ",
                },
                kinds = {
                    Array = " ",
                    Boolean = "󰨙 ",
                    Class = "󰆦 ", -- 
                    Color = "󰏘 ", -- 
                    Control = " ",
                    Collapsed = " ",
                    Constant = "󰕶 ", -- 󰏿
                    Constructor = " ", -- 
                    Copilot = " ",
                    Enum = "󰪚 ", -- 
                    EnumMember = " ", -- 
                    Event = "󰙴 ", -- 
                    Field = " ",
                    File = "󰈚 ", -- 
                    Folder = "󰉋 ", -- 
                    Function = "󰡱 ", -- 󰊕
                    Interface = "󰆩 ", -- 
                    Key = " ",
                    Keyword = "󱕵 ", -- 
                    Method = " ", -- 󰊕
                    Module = "󰜋 ", -- 
                    Namespace = "󰦮 ",
                    Null = " ",
                    Number = "󰎠 ",
                    Object = " ",
                    Operator = " ", -- 
                    Package = " ",
                    Property = "󰏫 ", -- 
                    Reference = " ", -- 
                    Snippet = "󰴹 ", -- 󱄽
                    String = " ",
                    Struct = "󰜬 ", -- 󰆼
                    Text = "󰉿 ", -- 
                    TypeParameter = "󰊄 ", -- 
                    Unit = "󰘨 ", -- 
                    Unknown = " ",
                    Value = "󰆙 ", -- 
                    Variable = "󰀫 ",
                },
            },
        },
        image = {
            enabled = false,
            -- force = true,
            doc = {
                float = false,
                inline = false, -- if you want show image on cursor hover
                -- max_width = 50,

                -- max_height = 30,
                wo = {
                    wrap = true,
                },
            },
            convert = {
                notify = true,
                command = "magick",
            },
            img_dirs = {
                "img",
                "images",
                "assets",
                "static",
                "public",
                "media",
                "attachments",
                "~/Pictures",
                "~/Downloads",
            },
        },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        notify = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        scope = { enabled = false },
        words = { enabled = false },
        util = { enabled = false },
        toggle = { enabled = false },
        profiler = { enabled = false },
        win = {
            enabled = false,
            wo = {
                -- winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC",
                cursorcolumn = false,
                cursorline = false,
                cursorlineopt = "both",
                colorcolumn = "",
                fillchars = "eob: ,lastline:…",
                list = false,
                listchars = "extends:…,tab:  ",
                number = false,
                relativenumber = false,
                signcolumn = "no",
                spell = false,
                winbar = "",
                statuscolumn = "",
                wrap = false,
                sidescrolloff = 0,
            },
        },
    },

    -- Keys
    keys = {
        {
            "<leader>Sl",
            function()
                Snacks.layout.new(opts)
            end,
        },
        {
            "<space>sp",
            function()
                Snacks.picker()
            end,
            desc = "Snacks Picker",
        },

        -- Buffers
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete",
        },
        {
            "<leader>be",
            function()
                Snacks.bufdelete.delete(opts)
            end,
            desc = "Opts delete",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other(opts)
            end,
            desc = "Delete other",
        },
        -- {
        --     "<leader>bl",
        --     function()
        --         Snacks.picker.buffers()
        --     end,
        --     desc = "Buffers",
        -- },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        -- find
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.cliphist()
            end,
            desc = "Find cliphist",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fs",
            function()
                Snacks.picker.smart()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        -- git
        {
            "<leader>gr",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gc",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git stash",
        },
        {
            "<leader>gi",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log File",
        },
        {
            "<leader>gk",
            function()
                Snacks.picker.actions.git_checkout()
            end,
            desc = "Git Checkout",
            mode = { "n", "t" },
        },
        {
            "<leader>gt",
            function()
                Snacks.picker.actions.git_stage()
            end,
            desc = "Git Stage",
            mode = { "n", "t" },
        },
        -- Grep
        {
            "<leader>sb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        -- search
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>sA",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Autocmds",
        },
        {
            "<leader>sc",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>sC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>sD",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Buffer diagnostics",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>sH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlights",
        },
        {
            "<leader>si",
            function()
                Snacks.picker.icons()
            end,
            desc = "Icons",
        },
        {
            "<leader>sj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>sl",
            function()
                Snacks.picker.loclist()
            end,
            desc = "Location List",
        },
        {
            "<leader>sM",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
        {
            "<leader>sm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>sR",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume",
        },
        {
            "<leader>sq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Quickfix List",
        },
        {
            "<leader>su",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo History",
        },
        {
            "<leader>uC",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Colorschemes",
        },
        {
            "<leader>qp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        -- LSP
        {
            "<leader>ld",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "<leader>lG",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "<leader>lR",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "<leader>li",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "<leader>ly",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
        {
            "<leader>se",
            function()
                Snacks.picker.lsp_config()
            end,
            desc = "LSP Config",
            mode = { "n", "t" },
        },
        {
            "<leader>sL",
            function()
                Snacks.picker.lazy()
            end,
            desc = "Picker lazy modules",
            mode = { "n", "t" },
        },
        {
            "<leader>sa",
            function()
                Snacks.picker.picker_actions()
            end,
            desc = "Picker Actions",
            mode = { "n", "t" },
        },

        -- Picker
        {
            "<leader>pf",
            function()
                Snacks.picker.picker_format()
            end,
            desc = "Picker formar",
            mode = { "n", "t" },
        },
        {
            "<leader>ps",
            function()
                Snacks.picker.spelling()
            end,
            desc = "Picker Spelling",
            mode = { "n", "t" },
        },
        {
            "<leader>pz",
            function()
                Snacks.picker.zoxide()
            end,
            desc = "Picker Zoxide",
            mode = { "n", "t" },
        },

        -- Zen Mode
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>Z",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Toggle Zoom",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>n",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>gf",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Current File History",
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Log (cwd)",
        },
        {
            "<leader>un",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Dismiss All Notifications",
        },
        -- Debugging
        {
            "<F1>",
            function()
                Snacks.debug()
            end,
            desc = "Debug",
        },
        {
            "<F2>",
            function()
                Snacks.debug.run(opts)
            end,
            desc = "Run the current buffer or a range of lines",
        },
        {
            "<F3>",
            function()
                Snacks.debug.backtrace()
            end,
            desc = "",
        },
        {
            "<c-/>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal",
            mode = { "t", "n", "i", "x" },
        },
        {
            "<c-_>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal",
            mode = { "t", "n", "i", "x" },
        },
        {
            "gw",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "gW",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
        {
            "<leader>N",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
            desc = "Neovim News",
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                vim.notify = require("snacks").notifier

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                -- Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                -- Snacks.toggle
                -- 	.option("background", { off = "light", on = "dark", name = "Dark Background" })
                -- 	:map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
