local function lsp_status_short()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    return "" -- Return empty string when no LSP clients
  end

  local names = {}
  local copilot_active = false

  for _, client in ipairs(clients) do
    if client.name == "copilot" then
      copilot_active = true
    else
      table.insert(names, client.name)
    end
  end

  if copilot_active then
    table.insert(names, "  Copilot") -- Append Copilot icon last
  end

  return "   LSP " .. table.concat(names, ",")
end

--- Return a formatted string with active linters and formatters for the current buffer
local function active_linters_and_formatters()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype
  local items = {}

  -- Conform (Formatters)
  local conform = require("conform")
  local formatters = conform.list_formatters_for_buffer(bufnr)
  for _, f in ipairs(formatters) do
    table.insert(items, f.name)
  end

  -- nvim-lint (Linters)
  local lint = require("lint")
  local linters = lint.linters_by_ft[ft] or {}
  for _, linter in ipairs(linters) do
    table.insert(items, linter)
  end

  if #items == 0 then
    return "" -- No active tools
  end

  return "  " .. table.concat(items, ", ") -- Icon alternatives: 󰒋  
end

--- Return a summary of diagnostics in the current buffer (errors, warnings, info, hints)
local function diagnostics_summary()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local counts = { 0, 0, 0, 0 } -- ERROR, WARN, INFO, HINT
  for _, d in ipairs(diagnostics) do
    counts[d.severity] = counts[d.severity] + 1
  end

  local icons = { "󰅚", "󰀪", "󰋽", "󰌶" } -- Error, Warn, Info, Hint
  local result = {}

  for i, count in ipairs(counts) do
    if count > 0 then
      table.insert(result, string.format("%s %d", icons[i], count))
    end
  end

  return next(result) and table.concat(result, " ") or ""
end

--- Return git changes for the current file: added, changed, removed (requires gitsigns.nvim)
local function git_changes()
  local gitsigns = vim.b.gitsigns_status_dict
  if not gitsigns then
    return ""
  end

  local symbols = { added = "+", changed = "~", removed = "-" }
  local parts = {}

  if gitsigns.added and gitsigns.added > 0 then
    table.insert(parts, symbols.added .. gitsigns.added)
  end
  if gitsigns.changed and gitsigns.changed > 0 then
    table.insert(parts, symbols.changed .. gitsigns.changed)
  end
  if gitsigns.removed and gitsigns.removed > 0 then
    table.insert(parts, symbols.removed .. gitsigns.removed)
  end

  return next(parts) and table.concat(parts, " ") or ""
end

local function git_branch()
  local handle = io.popen("git branch --show-current 2>/dev/null")
  if not handle then
    return ""
  end
  local branch = handle:read("*l")
  handle:close()
  if branch and branch ~= "" then
    return "  " .. branch
  end
  return ""
end

local function git_log()
    local ok, handle = pcall(io.popen, "git log -1 --pretty=format:'%h'")
    if not ok or not handle then
        return ""
    end
    local log = handle:read("*a")
    handle:close()
    if log and log ~= "" then
        log = log:gsub("\n", "")
        return "  " .. log -- ⎇
    end
    return ""
end

-- Safe wrapper functions for statusline
local function safe_git_branch()
    local ok, result = pcall(git_branch)
    return ok and result or ""
end
local function safe_git_log()
    local ok, result = pcall(git_log)
    return ok and result or ""
end

local function safe_lsp_status()
    local ok, result = pcall(lsp_status_short)
    return ok and result or ""
end

local function safe_active_linters_and_formatters()
  local ok, result = pcall(active_linters_and_formatters)
  return ok and result or ""
end

local function safe_git_changes()
    local ok, result = pcall(git_changes)
    return ok and result or ""
end

local function safe_diagnostics_summary()
    local ok, result = pcall(diagnostics_summary)
    return ok and result or ""
end

_G.git_branch = safe_git_branch
_G.git_log = safe_git_log
_G.lsp_status = safe_lsp_status
_G.active_linters_and_formatters = safe_active_linters_and_formatters
_G.git_changes = safe_git_changes
_G.diagnostics_summary = safe_diagnostics_summary

-- THEN set the statusline
vim.opt.statusline = table.concat({
    "",
    "%{v:lua.git_branch()}", -- Git branch
    "%{v:lua.git_log()}", -- Git log
    "%{v:lua.git_changes()}", -- Git changes
    "%{v:lua.diagnostics_summary()}", -- Diagnostics
    "%f", -- File name
    "%m", -- Modified flag
    "%r", -- Readonly flag
    "%=", -- Right align
    "%{v:lua.lsp_status()}", -- LSP status
    "%{v:lua.active_linters_and_formatters()}", -- Linters n formaters
    " %l:%c", -- Line:Column
    " %p%%", -- Percentage through file
    "",
}, " ")

