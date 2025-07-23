---@meta
-- Provides a standardized wrapper around the `snacks.nvim` notifier for consistent
-- logging and feedback across the configuration.
-- It offers leveled notifications (info, warn, error, debug) and a progress indicator.

local snacks = require "snacks"

---@class Core.Notify
-- The main module table for the notification utility.
local M = {}

-- vim.notify = snacks.notify

---@alias Core.Notify.Opts table<string, any> Options passed to the underlying notifier.

--- Displays an informational message.
-- @param msg string The message content to display.
-- @param opts? Core.Notify.Opts Optional notification configuration.
function M.info(msg, opts)
    snacks.notify(msg, vim.log.levels.INFO, opts)
end

--- Displays a warning message.
-- @param msg string The message content to display.
-- @param opts? Core.Notify.Opts Optional notification configuration.
function M.warn(msg, opts)
    snacks.notify(msg, vim.log.levels.WARN, opts)
end

--- Displays an error message.
-- @param msg string The message content to display.
-- @param opts? Core.Notify.Opts Optional notification configuration.
function M.error(msg, opts)
    snacks.notify(msg, vim.log.levels.ERROR, opts)
end

--- Displays a debug message.
-- @param msg string The message content to display.
-- @param opts? Core.Notify.Opts Optional notification configuration.
function M.debug(msg, opts)
    snacks.notify(msg, vim.log.levels.DEBUG, opts)
end

---@class Core.Notify.Progress
---@field update_progress fun(self: Core.Notify.Progress, msg: string) Updates the progress message.
---@field finish fun(self: Core.Notify.Progress, msg: string, success: boolean) Concludes the progress notification.
local Progress = {}

--- Creates and displays an interactive progress notification.
-- This returns a notifier object that can be updated and finished.
-- @param title string The initial title for the progress notification.
-- @return Core.Notify.Progress The progress notifier instance.
function M.progress(title)
    local notifier = snacks.notifier()
    notifier:update(title .. " ⏳", "info")

    --- Updates the message of the ongoing progress notification.
    -- @param msg string The new message to display.
    function notifier:update_progress(msg)
        self:update(msg .. " ⏳", "info", { replace = true })
    end

    --- Finishes the progress notification with a final message and status.
    -- @param msg string The final message.
    -- @param success boolean Determines if the success or failure icon is shown.
    function notifier:finish(msg, success)
        local icon = success and "✅ " or "❌ "
        local level = success and "info" or "error"
        self:update(icon .. msg, level, { replace = true })
    end

    return notifier
end

return M

