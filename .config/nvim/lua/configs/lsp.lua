---@meta
-- This file orchestrates the Neovim LSP client configuration.
-- It defines global diagnostic settings, keymaps via `on_attach`,
-- custom user commands for LSP interaction, and other related autocmds.
-- The annotations are optimized for the EmmyLua-ls language server.

---@alias Lsp.Client vim.lsp.Client The LSP client object.
---@alias Lsp.BufNr number The buffer number.

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "LSP Info" })
end

vim.lsp.enable({
    "biome",
    "css-modules",
    "css-variables",
    "cssls",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "emmylua-ls",
    "emmet-language-server",
    "golangci-lint-ls",
    "gopls",
    "html",
    -- "lua-ls",
    "marksman",
    "oxc-language-server",
    "postgres-lsp",
    "prismals",
    "rescriptls",
    "sqruff",
    "tailwindcss",
    "terraform-ls",
    -- "vtsls",
    "yaml-language-server",
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "", -- Empty, since we'll provide the icon via format
        format = function(diagnostic)
            local icons = {
                [vim.diagnostic.severity.ERROR] = "󰅚 ", -- 
                [vim.diagnostic.severity.WARN] = "󰀪 ", -- 
                [vim.diagnostic.severity.INFO] = "󰋽 ", -- 
                [vim.diagnostic.severity.HINT] = "󰌶 ", -- 
            }
            return icons[diagnostic.severity] or ""
        end,
        spacing = 4,
        source = "if_many",
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        border = "rounded",
        source = "if_many",
        prefix = " ", -- ●  󰙎
        title = { { " Diagnostics ", "@comment" } },
        title_pos = "right"
    },
    signs = false,
})

---@param client vim.lsp.Client The LSP client object that has attached.
---@param bufnr integer The buffer number the client has attached to.
local function on_attach(client, bufnr)
    -- Keymaps
    local function map(mode, keys, action, desc)
        vim.keymap.set(mode, keys, action, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    map("n", "K", function()
        vim.lsp.buf.hover {
            focus = false,
            silent = true,
            max_height = 10,
            border = "rounded", -- opções: "none", "single", "double", "rounded", "solid", "shadow"
            -- title = { { " Signature Help ", "@comment" } },
            title = {
                { " Hover ", "@comment" },
                -- { " ", "@comment" },
                -- { " [LSP]", "@comment" }
            },
            winhighlight = "Normal:BlinkNormalFloat,FloatBorder:BlinkNormalFloat,Search:None",
            -- title_pos = "right",
        }
    end, "Hover")
    map("n", "<C-k>", function()
        vim.lsp.buf.signature_help {
            focus = false,
            silent = true,
            max_height = 10,
            border = "rounded", -- opções: "none", "single", "double", "rounded", "solid", "shadow"
            -- title = { { " Signature Help ", "@comment" } },
            title = {
                { " Signature Help ", "@comment" },
                -- { "  ",           "Title" }
            },
            -- title_pos = "right",
        }
    end, "Signature Help")
    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("n", "go", vim.lsp.buf.type_definition, "Go to Type Definition")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")

    -- Diagnostics
    map("n", "[d", function()
        vim.diagnostic.goto_prev({ float = true })
    end, "Previous Diagnostic")
    map("n", "]d", function()
        vim.diagnostic.goto_next({ float = true })
    end, "Next Diagnostic")
    -- map("n", "df", vim.diagnostic.open_float, "Open Diagnostics")
    map("n", "df", function()
        vim.diagnostic.open_float()
    end, "Open diagnostics float ")

    local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
            go({ severity = severity })
        end
    end
    -- Rreplaced by snacks.nvim
    -- map("n", "<leader>ds", vim.diagnostic.setloclist, "Add buffer diagnostics to the location list.")
    map("n", "]e", diagnostic_goto(true, "ERROR"), "Goto next error")
    map("n", "[e", diagnostic_goto(false, "ERROR"), "Goto previous error")
    map("n", "]w", diagnostic_goto(true, "WARN"), "Goto next warning")
    map("n", "[w", diagnostic_goto(false, "WARN"), "Goto previous warning")
    map("n", "]h", diagnostic_goto(false, "HINT"), "Goto next hint")
    map("n", "[h", diagnostic_goto(false, "HINT"), "Goto previous hint")

    local function rename_symbol()
        local lsp = vim.lsp
        local api = vim.api

        local function get_symbol(cb)
            local cword = vim.fn.expand("<cword>")
            local clients = lsp.get_clients({ bufnr = 0, method = "textDocument/rename" })
            if #clients == 0 then
                cb(cword)
                return
            end

            local client = clients[1] -- Prioriza o primeiro cliente
            if client.supports_method("textDocument/prepareRename") then
                local params = lsp.util.make_position_params()
                client.request("textDocument/prepareRename", params, function(err, result)
                    if err or not result then
                        cb(cword)
                        return
                    end

                    if result.placeholder then
                        cb(result.placeholder)
                    elseif result.range then
                        cb(
                            vim.api.nvim_buf_get_text(
                                0,
                                result.range.start.line,
                                result.range.start.character,
                                result.range["end"].line,
                                result.range["end"].character,
                                {}
                            )[1]
                        )
                    else
                        cb(cword)
                    end
                end)
            else
                cb(cword)
            end
        end

        get_symbol(function(symbol)
            local buf = api.nvim_create_buf(false, true)
            local opts = {
                relative = "cursor",
                width = #symbol + 10,
                height = 1,
                row = 1,
                col = 1,
                border = "rounded",
                -- style = "minimal",
            }
            local win = api.nvim_open_win(buf, true, opts)
            api.nvim_buf_set_lines(buf, 0, -1, false, { symbol })
            vim.bo[buf].buftype = "prompt"
            vim.fn.prompt_setprompt(buf, "")

            vim.fn.prompt_setcallback(buf, function(input)
                api.nvim_buf_delete(buf, { force = true })
                if input and input ~= symbol then
                    local params = lsp.util.make_position_params()
                    params.newName = input
                    lsp.buf_request(0, "textDocument/rename", params)
                end
            end)

            api.nvim_input("A") -- Move para o final do input

            vim.keymap.set({ "n", "i" }, "<Esc>", function()
                api.nvim_buf_delete(buf, { force = true })
            end, { buffer = buf })
        end)
    end
    map("n", "<leader>lr", rename_symbol, "Lsp rename with prompt")

    -- Formatting
    if client.supports_method("textDocument/formatting") then
        map("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, "Format Native")
    end

    -- Inlay hints
    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

-- Autocmd
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    ---@param ev table The autocommand event data.
    ---@field data { client_id: integer }
    callback = function(ev)
        on_attach(vim.lsp.get_client_by_id(ev.data.client_id), ev.buf)

        local function check_trigger_chars(trigger_chars)
            local cur_line = vim.api.nvim_get_current_line()
            local pos = vim.api.nvim_win_get_cursor(0)[2]
            local prev_char = cur_line:sub(pos - 1, pos - 1)
            local cur_char = cur_line:sub(pos, pos)

            for _, char in ipairs(trigger_chars) do
                if cur_char == char or prev_char == char then
                    return true
                end
            end
        end

        local function setup_signature_autocmd(client, bufnr)
            if not client.server_capabilities.signatureHelpProvider then
                return
            end

            local group = vim.api.nvim_create_augroup("LspSignatureHelp", { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

            local trigger_chars = client.server_capabilities.signatureHelpProvider.triggerCharacters

            vim.api.nvim_create_autocmd("TextChangedI", {
                group = group,
                buffer = bufnr,
                callback = function()
                    if check_trigger_chars(trigger_chars) then
                        vim.lsp.buf.signature_help({ focus = false, silent = true, max_height = 7, border = "rounded" })
                    end
                end,
            })
        end
        setup_signature_autocmd(vim.lsp.get_client_by_id(ev.data.client_id), ev.buf)
    end,
})

-- User Commands
local function lsp_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients == 0 then
        return notify("No LSP clients attached", vim.log.levels.WARN)
    end
    -- ... (rest of the function remains the same)
end

vim.api.nvim_create_user_command("LspInfo", lsp_info, { desc = "Show comprehensive LSP information" })

-- Extras
local function restart_lsp(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local clients
    if vim.lsp.get_clients then
        clients = vim.lsp.get_clients({ bufnr = bufnr })
    else
        ---@diagnostic disable-next-line: deprecated
        clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    end

    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end

    vim.defer_fn(function()
        vim.cmd("edit")
    end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
    restart_lsp()
end, {})

local function lsp_status()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
        or vim.lsp.get_active_clients({ bufnr = bufnr })

    if #clients == 0 then
        notify("󰅚 No LSP clients attached", vim.log.levels.WARN)
        return
    end

    for i, client in ipairs(clients) do
        local details = {
            string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id),
            "  Root: " .. (client.config.root_dir or "N/A"),
            "  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "),
        }

        local caps = client.server_capabilities
        local features = {}
        if caps.completionProvider then
            table.insert(features, "completion")
        end
        if caps.hoverProvider then
            table.insert(features, "hover")
        end
        if caps.definitionProvider then
            table.insert(features, "definition")
        end
        if caps.referencesProvider then
            table.insert(features, "references")
        end
        if caps.renameProvider then
            table.insert(features, "rename")
        end
        if caps.codeActionProvider then
            table.insert(features, "code_action")
        end
        if caps.documentFormattingProvider then
            table.insert(features, "formatting")
        end

        table.insert(details, "  Features: " .. table.concat(features, ", "))
        notify(table.concat(details, "\n"))
    end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
        or vim.lsp.get_active_clients({ bufnr = bufnr })

    if #clients == 0 then
        notify(" No LSP clients attached")
        return
    end

    for _, client in ipairs(clients) do
        notify(" Capabilities for " .. client.name .. ":")
        local caps = client.server_capabilities

        local capability_list = {
            { "Completion",                caps.completionProvider },
            { "Hover",                     caps.hoverProvider },
            { "Signature Help",            caps.signatureHelpProvider },
            { "Go to Definition",          caps.definitionProvider },
            { "Go to Declaration",         caps.declarationProvider },
            { "Go to Implementation",      caps.implementationProvider },
            { "Go to Type Definition",     caps.typeDefinitionProvider },
            { "Find References",           caps.referencesProvider },
            { "Document Highlight",        caps.documentHighlightProvider },
            { "Document Symbol",           caps.documentSymbolProvider },
            { "Workspace Symbol",          caps.workspaceSymbolProvider },
            { "Code Action",               caps.codeActionProvider },
            { "Code Lens",                 caps.codeLensProvider },
            { "Document Formatting",       caps.documentFormattingProvider },
            { "Document Range Formatting", caps.documentRangeFormattingProvider },
            { "Rename",                    caps.renameProvider },
            { "Folding Range",             caps.foldingRangeProvider },
            { "Selection Range",           caps.selectionRangeProvider },
        }

        for _, cap in ipairs(capability_list) do
            local status = cap[2] and "✓" or "✗"
            notify(string.format("  %s %s", status, cap[1]))
        end
        notify("")
    end
end

vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)

    if vim.tbl_isempty(diagnostics) then
        notify("󰄬 No diagnostics in current buffer", vim.log.levels.INFO)
        return
    end

    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diagnostic.severity]
        if counts[severity] ~= nil then
            counts[severity] = counts[severity] + 1
        end
    end

    local summary = {
        "󰒡 Diagnostics for current buffer:",
        "  Errors:   " .. counts.ERROR,
        "  Warnings: " .. counts.WARN,
        "  Info:     " .. counts.INFO,
        "  Hints:    " .. counts.HINT,
        "  Total:    " .. #diagnostics,
    }

    notify(table.concat(summary, "\n"))
end

vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })

local function lsp_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
        or vim.lsp.get_active_clients({ bufnr = bufnr })

    local info = {
        "═══════════════════════════════════",
        "           LSP INFORMATION         ",
        "═══════════════════════════════════",
        "",
        "󰈚 Language client log: " .. vim.lsp.get_log_path(), -- 󰈙
        "󰈚 Detected filetype: " .. vim.bo.filetype,
        "󰈚 Buffer: " .. bufnr, -- 󰈮
        "󰈚 Root directory: " .. (vim.fn.getcwd() or "N/A"),
        "",
    }

    if #clients == 0 then
        table.insert(info, "󰅚 No LSP clients attached to buffer " .. bufnr)
        table.insert(info, "")
        table.insert(info, "Possible reasons:")
        table.insert(info, "  • No language server installed for " .. vim.bo.filetype)
        table.insert(info, "  • Language server not configured")
        table.insert(info, "  • Not in a project root directory")
        table.insert(info, "  • File type not recognized")
        notify(table.concat(info, "\n"))
        return
    end

    table.insert(info, "󰒋 LSP clients attached to buffer " .. bufnr .. ":")
    table.insert(
        info,
        "─────────────────────────────────"
    )

    for i, client in ipairs(clients) do
        table.insert(info, string.format("󰌘 Client %d: %s", i, client.name))
        table.insert(info, "  ID: " .. client.id)
        table.insert(info, "  Root dir: " .. (client.config.root_dir or "Not set"))
        table.insert(info, "  Command: " .. table.concat(client.config.cmd or {}, " "))
        table.insert(info, "  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

        table.insert(info, "  Status: " .. (client.is_stopped() and "󰅚 Stopped" or "󰄬 Running"))

        if client.workspace_folders and #client.workspace_folders > 0 then
            table.insert(info, "  Workspace folders:")
            for _, folder in ipairs(client.workspace_folders) do
                table.insert(info, "    • " .. folder.name)
            end
        end

        local attached_buffers = vim.tbl_keys(client.attached_buffers or {})
        table.insert(info, "  Attached buffers: " .. #attached_buffers)

        local caps = client.server_capabilities
        local key_features = {}
        if caps.completionProvider then
            table.insert(key_features, "completion")
        end
        if caps.hoverProvider then
            table.insert(key_features, "hover")
        end
        if caps.definitionProvider then
            table.insert(key_features, "definition")
        end
        if caps.documentFormattingProvider then
            table.insert(key_features, "formatting")
        end
        if caps.codeActionProvider then
            table.insert(key_features, "code_action")
        end

        if #key_features > 0 then
            table.insert(info, "  Key features: " .. table.concat(key_features, ", "))
        end

        table.insert(info, "")
    end

    local diagnostics = vim.diagnostic.get(bufnr)
    if #diagnostics > 0 then
        local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }
        for _, diagnostic in ipairs(diagnostics) do
            local severity = vim.diagnostic.severity[diagnostic.severity]
            counts[severity] = counts[severity] + 1
        end

        table.insert(info, "󰒡 Diagnostics Summary:")
        table.insert(info, " 󰅚 Errors: " .. counts.ERROR)
        table.insert(info, " 󰀪 Warnings: " .. counts.WARN)
        table.insert(info, " 󰋽 Info: " .. counts.INFO)
        table.insert(info, " 󰌶 Hints: " .. counts.HINT)
        table.insert(info, "  Total: " .. #diagnostics)
    else
        table.insert(info, "󰄬 No diagnostics")
    end

    table.insert(info, "")
    table.insert(info, "Use :LspLog to view detailed logs")
    table.insert(info, "Use :LspCapabilities for full capability list")

    notify(table.concat(info, "\n"))
end

-- Create command
vim.api.nvim_create_user_command("LspInfo", lsp_info, { desc = "Show comprehensive LSP information" })
