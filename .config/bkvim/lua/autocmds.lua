-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copy) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[ set formatoptions-=cro ]] })

-- Automatically disables heavy functionality for large files
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.line('$') > 10000 then
      vim.wo.cursorline = false
      vim.wo.foldmethod = 'manual'
      vim.cmd('syntax off')
    end
  end,
})

-- Disables settings that cause constant redrawing on large files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.line("$") > 10000 then -- File with more than 10k lines
      vim.wo.relativenumber = false
      vim.wo.cursorline = false
    end
  end,
})

-- Restore the cursor in the previous position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line([['"]])
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
  end,
})

-- Automatically close the help window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "nnoremap <buffer> q :q<CR>",
})

-- Automatically close floating and inactive terminal windows.
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
--   pattern = { "help", "terminal", "nofile" },
--   callback = function()
--     if vim.bo.filetype == "help" or vim.bo.filetype == "terminal" then
--       vim.cmd("quit")
--     end
--   end,
-- })

-- Automatically define the type of indentation based on the file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local file_indent = vim.fn.search([[^\s*\t]], "n") > 0 and "tab" or "space"
    if file_indent == "tab" then
      vim.bo.expandtab = false
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
    else
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
    end
  end,
})

-- Automatically recharge the file if there are external changes
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
--   pattern = "*",
--   command = "checktime",
-- })

-- Automatically disable the mouse in insertion mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.mouse = ""
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.mouse = "a"
  end,
})
