local snacks = require("snacks")

local M = {}

-- vim.notify = snacks.notify

function M.info(msg, opts)
    snacks.notify(msg, vim.log.levels.INFO, opts)
end

function M.warn(msg, opts)
    snacks.notify(msg, vim.log.levels.WARN, opts)
end

function M.error(msg, opts)
    snacks.notify(msg, vim.log.levels.ERROR, opts)
end

function M.debug(msg, opts)
    snacks.notify(msg, vim.log.levels.DEBUG, opts)
end

function M.progress(title)
    local notifier = snacks.notifier()
    notifier:update(title .. " ⏳", "info")

    function notifier:update_progress(msg)
        self:update(msg .. " ⏳", "info", { replace = true })
    end

    function notifier:finish(msg, success)
        local icon = success and "✅ " or "❌ "
        local level = success and "info" or "error"
        self:update(icon .. msg, level, { replace = true })
    end

    return notifier
end

return M

