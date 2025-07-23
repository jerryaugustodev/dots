local notify = require("core.notify")
local snacks = require("snacks")

local M = {}

-- Lazy plugin events
function M.lazy_notify()
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function(data)
            notify.info("Lazy plugin loaded: " .. data.data)
        end
    })
end

-- Notify Git branch on entering any buffer
function M.git_branch_notify()
    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
            if branch ~= "" then
                notify.info("Git Branch: " .. branch)
            end
        end
    })
end

-- Notify file reloaded externally
function M.file_sync_notify()
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
        callback = function()
            vim.cmd("checktime")
            notify.debug("Checked for file changes")
        end
    })
end

-- Notify running Docker containers on VimEnter
function M.docker_notify()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            local containers = vim.fn.systemlist("docker ps --format '{{.Names}}'")
            local msg = #containers > 0 and
                "Docker containers running:\n" .. table.concat(containers, "\n")
                or "No Docker containers running"
            notify.info(msg)
        end
    })
end

-- Oil rename notifications
function M.oil_notify()
    vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(ev)
            local action = ev.data.actions
            local msg = action.type == "delete" and ("Deleted: " .. action.src_url)
                or ("Moved: " .. action.src_url .. " → " .. action.dest_url)
            notify.info(msg)
        end
    })
end

-- Project Build
function M.build_project()
    local notifier = notify.progress("Building project...")
    vim.fn.jobstart("npm run build", {
        on_exit = function(_, code)
            notifier:finish("Build completed " .. (code == 0 and "successfully" or "with errors"), code == 0)
        end
    })
end

-- Dev server
function M.run_dev_server()
    local notifier = notify.progress("Starting Dev Server")
    vim.fn.jobstart("npm run dev", {
        on_exit = function(_, code)
            notifier:finish("Dev Server exited with code " .. code, code == 0)
        end
    })
end

-- Docker action picker
function M.docker_picker()
    local actions = { "Start", "Stop", "Logs" }
    snacks.picker(actions, {
        prompt = "Docker Actions",
        on_submit = function(choice)
            local cmd = ({
                Start = "docker start my_container",
                Stop = "docker stop my_container",
                Logs = "docker logs my_container",
            })[choice]

            if cmd then
                vim.fn.jobstart(cmd, {
                    on_exit = function(_, code)
                        notify.info("Docker action '" .. choice .. "' exited with code " .. code, vim.log.levels.INFO)
                    end
                })
            end
        end
    })
end

-- Snacks.picker integration for simple pickers
function M.show_picker(items, opts)
    snacks.picker(items, opts)
end

return M

