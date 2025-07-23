local augroup = vim.api.nvim_create_augroup("MyConfig", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Floats
autocmd("ColorScheme", {
    callback = function()
        -- Standard colors for UI elements
        local kanagawa = {
            -- Kanagawa Colors
            fujiWhite     = "#DCD7BA", --- Default foreground
            oldWhite      = "#C8C093", --- Dark foreground
            sumiInk0      = "#16161D", --- Dark background (floating windows)
            sumiInk1      = "#1F1F28", --- Default background
            sumiInk2      = "#2A2A37", --- Lighter background (colorcolumn, folds)
            sumiInk3      = "#363646", --- Lighter background (cursorline)
            sumiInk4      = "#54546D", --- Darker foreground (line numbers, fold column, non-text characters), float borders
            waveBlue1     = "#223249", --- Popup background, visual selection background
            waveBlue2     = "#2D4F67", --- Popup selection background, search background
            winterGreen   = "#2B3328", --- Diff Add (background)
            winterYellow  = "#49443C", --- Diff Change (background)
            winterRed     = "#43242B", --- Diff Deleted (background)
            winterBlue    = "#252535", --- Diff Line (background)
            autumnGreen   = "#76946A", --- Git Add
            autumnRed     = "#C34043", --- Git Delete
            autumnYellow  = "#DCA561", --- Git Change
            samuraiRed    = "#E82424", --- Diagnostic Error
            roninYellow   = "#FF9E3B", --- Diagnostic Warning
            waveAqua1     = "#6A9589", --- Diagnostic Info
            dragonBlue    = "#658594", --- Diagnostic Hint
            fujiGray      = "#727169", --- Comments
            springViolet1 = "#938AA9", --- Light foreground
            oniViolet     = "#957FB8", --- Statements and Keywords
            crystalBlue   = "#7E9CD8", --- Functions and Titles
            springViolet2 = "#9CABCA", --- Brackets and punctuation
            springBlue    = "#7FB4CA", --- Specials and builtin functions
            lightBlue     = "#A3D4D5", --- Not used
            waveAqua2     = "#7AA89F", --- Types
            springGreen   = "#98BB6C", --- Strings
            boatYellow1   = "#938056", --- Not used
            boatYellow2   = "#C0A36E", --- Operators, RegEx
            carpYellow    = "#E6C384", --- Identifiers
            sakuraPink    = "#D27E99", --- Numbers
            waveRed       = "#E46876", --- Standout specials 1 (builtin variables)
            peachRed      = "#FF5D62", --- Standout specials 2 (exception handling, return)
            surimiOrange  = "#FFA066", --- Constants, imports, booleans
            katanaGray    = "#717C7C", --- Deprecated
        }

        vim.api.nvim_set_hl(0, "BlinkNormalFloat", { bg = kanagawa.sumiInk1, fg = kanagawa.oldWhite })
        vim.api.nvim_set_hl(0, "BlinkFloatBorder", { bg = kanagawa.sumiInk1, fg = kanagawa.sumiInk4 })
        -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = kanagawa.bg, fg = kanagawa.border })
        -- vim.api.nvim_set_hl(0, "FloatTitle", { bg = kanagawa.bg, fg = kanagawa.title, bold = true })
        --
        -- vim.api.nvim_set_hl(0, "Pmenu", { bg = kanagawa.bg, fg = kanagawa.fg })
        -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = kanagawa.selection, fg = kanagawa.fg, bold = true })
        -- vim.api.nvim_set_hl(0, "PmenuKind", { fg = kanagawa.accent, bg = kanagawa.bg })
        -- vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = kanagawa.accent, bg = kanagawa.selection })
        -- vim.api.nvim_set_hl(0, "PmenuExtra", { fg = kanagawa.info, bg = kanagawa.bg })
        -- vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = kanagawa.info, bg = kanagawa.selection })
        -- vim.api.nvim_set_hl(0, "PmenuThumb", { bg = kanagawa.scrollbar })
        -- vim.api.nvim_set_hl(0, "PmenuSbar", { bg = kanagawa.scrollbar })
        --
        -- vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = kanagawa.border, bg = kanagawa.bg })
        --
        -- vim.api.nvim_set_hl(0, "DiagnosticFloat", { bg = kanagawa.bg })
        -- vim.api.nvim_set_hl(0, "DiagnosticError", { fg = kanagawa.error })
        -- vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = kanagawa.warn })
        -- vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = kanagawa.info })
        -- vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = kanagawa.hint })

    end
})

-- General Settings
autocmd("BufEnter", {
    group = augroup,
    pattern = "*",
    callback = function()
        -- Disable auto-commenting on new lines
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })

        -- Disable heavy features for large files
        if vim.fn.line("$") > 10000 then
            vim.wo.cursorline = false
            vim.wo.foldmethod = "manual"
            vim.wo.relativenumber = false
            vim.cmd("syntax off")
        end
    end,
})

-- File and Buffer Management
autocmd("BufReadPost", {
    group = augroup,
    pattern = "*",
    callback = function()
        -- Clear search register
        vim.fn.setreg("/", "")
        -- vim.cmd("redrawstatus")
        vim.cmd('echo "" | redraw | redrawstatus')

        -- Restore cursor position
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
        -- Auto-create directories
        local file = vim.fn.expand("<afile>")
        local dir = vim.fn.fnamemodify(file, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter" }, {
    group = augroup,
    pattern = "*",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- UI and Highlighting
autocmd("TextYankPost", {
    group = augroup,
    pattern = "*",
    desc = "Briefly highlight yanked text",
    callback = function()
        if vim.fn.line("$") < 10000 then
            vim.highlight.on_yank({ timeout = 200 })
        end
    end,
})

-- Filetype-Specific Settings
autocmd("FileType", {
    group = augroup,
    pattern = { "typescript", "typescriptreact", "javascript", "json", "html", "css", "scss", "yaml" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})

autocmd("FileType", {
    group = augroup,
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true, desc = "Quit buffer" })
    end,
})

-- Plugin and LSP Integration

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        -- local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        local spinner = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and "" -- 
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

autocmd("BufAdd", {
    group = augroup,
    callback = function()
        local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
        if #listed_buffers > 1 and not vim.g._tabline_loaded then
            vim.g._tabline_loaded = true
            vim.cmd("Lazy load mini.tabline")
            require("mini.tabline").setup({})
            vim.opt.showtabline = 2
        end
    end,
})

autocmd("User", {
    group = augroup,
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
    end,
})

autocmd("User", {
    group = augroup,
    pattern = "MiniFilesActionRename",
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})
