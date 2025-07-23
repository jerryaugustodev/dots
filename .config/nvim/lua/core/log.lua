local notify = require("core.notify")

local M = {}

function M.startup(msg)
    notify.info("[Startup] " .. msg)
end

function M.config(msg)
    notify.debug("[Config] " .. msg)
end

function M.plugin(msg)
    notify.info("[Plugin] " .. msg)
end

function M.error(msg)
    notify.error("[Error] " .. msg)
end

function M.lsp(msg)
    notify.info("[LSP] " .. msg)
end

return M

