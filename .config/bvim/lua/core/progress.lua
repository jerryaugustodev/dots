local notify = require("core.notify")

local M = {}

---@type table<number, any>
local progress = {}

function M.lsp_progress()
    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if not client then return end

            local val = ev.data.params.value
            progress[client.id] = progress[client.id] or notify.progress("LSP: " .. (val.title or client.name))

            local msg = val.title or "Progress"
            if val.message then msg = msg .. " - " .. val.message end

            if val.kind == "end" then
                progress[client.id]:finish(msg, true)
            else
                progress[client.id]:update_progress(msg)
            end
        end
    })
end

return M

