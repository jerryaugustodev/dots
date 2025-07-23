-- Create a helper to define augroups with auto-clear enabled
local function augroup(name)
    return vim.api.nvim_create_augroup("MyConfig_" .. name, { clear = true })
end

-- Professional autocmd to trigger after UI is fully loaded and a real file is opened
local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

autocmd('BufReadPost', {
	callback = function()
		vim.fn.setreg('/', '')
		vim.cmd('redrawstatus')
	end,
})

-- Don't auto comment new line
autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("HighlightYank"),
    desc = "Briefly highlight yanked text",
    callback = function()
        if vim.fn.line("$") < 10000 then -- File with more than 10k lines
            vim.highlight.on_yank({ timeout = 200 })
        end
    end,
})

-- Reload file automatically when changed outside Neovim
autocmd({ "FocusGained", "BufEnter" }, {
    group = augroup("AutoRead"),
    desc = "Auto-reload files modified outside Neovim (e.g., Git switch)",
    command = "checktime",
})

-- Restore cursor to last known position on reopen
autocmd("BufReadPost", {
    group = augroup("LastCursor"),
    desc = "Restore cursor position when reopening file",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

-- Set indentation based on filetype
autocmd("FileType", {
    group = augroup("Indentation"),
    desc = "Set indentation rules for web files",
    pattern = { "typescript", "typescriptreact", "javascript", "json", "html", "css", "scss", "yaml" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})

-- Automatically remove trailing whitespace on save
autocmd("BufWritePre", {
    group = augroup("TrimWhitespace"),
    desc = "Remove trailing whitespace before saving",
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})

-- Automatically create directory when saving new file
autocmd("BufWritePre", {
    group = augroup("AutoMkdir"),
    desc = "Create parent directories automatically before saving",
    callback = function()
        local file = vim.fn.expand("<afile>")
        local dir = vim.fn.fnamemodify(file, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- Autocommand that loads mini.tabline when more than one buffer is opened
autocmd("BufAdd", {
    group = augroup("LoadTabline"),
    desc = "Load mini.tabline when more than one listed buffer exists",
    callback = function()
        -- Get the list of listed (visible) buffers
        local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })

        -- Load only if more than one buffer and not already loaded
        if #listed_buffers > 1 and not vim.g._tabline_loaded then
            vim.g._tabline_loaded = true -- Prevent duplicate loading

            -- Load the plugin manually via Lazy
            vim.cmd("Lazy load mini.tabline")

            -- Setup the plugin after load
            require("mini.tabline").setup({})

            -- Optionally force tabline to be shown now
            vim.opt.showtabline = 2
        end
    end,
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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
                notif.icon = #progress[client.id] == 0 and " " -- 
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

-- LSP-integrated file renaming with support for Oil.nvim
autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
    end,
})

-- LSP-integrated file renaming with support for mini.files
autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})

-- Don't auto comment new line
autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Automatically disables heavy functionality for large files
autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.line("$") > 10000 then -- File with more than 10k lines
            vim.wo.cursorline = false
            vim.wo.foldmethod = "manual"
            vim.wo.relativenumber = false
            vim.cmd("syntax off")
        end
    end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- LSP
local completion = vim.g.completion_mode or "blink" -- or 'native'
autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            -- Built-in completion
            if completion == "native" and client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end

            -- Inlay hints
            if client:supports_method("textDocument/inlayHints") then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        end
    end,
})

-- close some filetypes with <q>
autocmd("FileType", {
    group = augroup("close_with_q"),
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
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end)
end,
                    })
