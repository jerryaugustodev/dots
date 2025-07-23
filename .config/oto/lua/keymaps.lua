-- =============================================================================
-- | keymaps.lua
-- |
-- | This file defines the core key mappings for Neovim. The philosophy is to
-- | create an ergonomic, fast, and intuitive keyboard-driven workflow.
-- | Mappings are organized by functionality and prioritize native Neovim
-- | features over plugin dependencies wherever possible.
-- =============================================================================

-- A helper function to simplify keymap creation.
local function map(mode, keys, action, desc)
	desc = desc or ""
	-- local opts = { noremap = true, remap = true, silent = true, desc = desc }
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, keys, action, opts)
end

-- =============================================================================
-- | CORE ESSENTIALS & QUALITY OF LIFE
-- =============================================================================

-- Make the current file executable.
map("n", "<leader>cx", "<cmd>!chmod +x %<cr>", "Make File Executable")

-- Select all
map("n", "<C-a>", "GVgg")
map({ "i", "v" }, "<C-a>", "<Esc>GVgg")

-- Disable arrow keys in Normal mode to enforce 'hjkl' navigation.
-- This builds better habits and keeps hands on the home row.
map({ "i", "n", "v" }, "<Left>", "<NOP>")
map({ "i", "n", "v" }, "<Down>", "<NOP>")
map({ "i", "n", "v" }, "<Up>", "<NOP>")
map({ "i", "n", "v" }, "<Right>", "<NOP>")

-- Use j/k as a faster escape sequence in Insert mode.
map("i", "jj", "<Esc>", "Exit insert mode with jj")
map("i", "jk", "<Esc>", "Exit insert mode with jk")
map("i", "kj", "<Esc>", "Exit insert mode with kj")
map("i", "kk", "<Esc>", "Exit insert mode with kk")

-- Preserve paste register when pasting over selection
map("x", "<leader>P", '"_dP', "Paste without replacing register")

-- Yank to system clipboard
map("n", "<leader>y", '"+y', "Yank to system clipboard")
map("v", "<leader>y", '"+y', "Yank to system clipboard")

-- Delete without affecting registers
map("n", "<leader>D", '"_d', "Delete to null register")
map("v", "<leader>D", '"_d', "Delete selection to null register")

-- Center the view when navigating search results.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Fast saving and quitting.
map("n", "<leader>W", "<cmd>write<cr>", "Write File")
map("n", "<leader>Q", "<cmd>quit<cr>", "Quit")
-- An better quit
map("n", "<cmd>q<cr>", "<cmd>qall!<cr>", "Better quit")

-- Clear search highlight.
map("n", "<Esc>", "<cmd>nohl<cr>", "Clear Search Highlight")

-- =============================================================================
-- | WINDOW & BUFFER NAVIGATION
-- =============================================================================

-- Use Ctrl + hjkl to navigate between window splits.
map("n", "<C-h>", "<C-w>h", "Navigate Left Window")
map("n", "<C-l>", "<C-w>l", "Navigate Right Window")
map("n", "<C-j>", "<C-w>j", "Navigate Down Window")
map("n", "<C-k>", "<C-w>k", "Navigate Up Window")

-- Resize splits using Ctrl + hjkl keys.
map("n", "<C-S-h>", "<cmd>vertical resize +1<cr>", "Resizes vertical split +")
map("n", "<C-S-l>", "<cmd>vertical resize -1<cr>", "Resizes vertical split -")
map("n", "<C-S-k>", "<cmd>horizontal resize +1<cr>", "Resizes horizontal split +")
map("n", "<C-S-j>", "<cmd>horizontal resize -1<cr>", "Resizes horizontal split -")
-- Equalize window sizes
map("n", "<leader>=", "<C-w>=", "Equalize splits")

-- Buffer navigation.
map("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<s-Tab>", "<cmd>bprev<CR>", "Previous buffer")
map("n", "<leader>bd", "<cmd>bdelete<cr>", "Delete buffer")
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", "Close all other buffers")
map("n", "<leader>bl", "<cmd>ls<cr>:b<Space>", "List active buffers")
map("n", "<leader>bq", "<C-w>o", "Close all windows except the focusd one")

-- =============================================================================
-- | EDITING ENHANCEMENTS
-- =============================================================================

-- VSCode-like 'alt+k/j' Move selected line / block of text in visual mode
map("n", "<M-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move down")
map("i", "<C-M-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
map("v", "<M-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move down")
-- map("v", "<M-j>", ":m '>+1<CR>gv=gv")
map("n", "<M-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move up")
map("i", "<C-M-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
map("v", "<M-k>", ":<C-u>execute \"'<,'>move '>-\" . (v:count1 + 1)<cr>gv=gv", "Move up")
-- map("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Keep the cursor in place when joining lines.
map("n", "J", "mzJ`z")

-- Preserve the yank buffer when pasting over a selection in Visual mode.
-- This prevents the selected text from overwriting your yanked text.
map("v", "P", '"_dP')
map("v", "p", '"_dp')

-- Indent without leaving visual mode.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- =============================================================================
-- | NATIVE GIT WORKFLOW (Plugin-Free)
-- | These mappings use Neovim's built-in terminal to interact with Git,
-- | providing a fast and lightweight integration without heavy plugins.
-- =============================================================================

-- Git status in a terminal split
map("n", "<leader>Gs", "<cmd>split | terminal git status<cr>", "Git status")

-- Git log
map("n", "<leader>Gl", ":!git log --oneline<CR>", "Native Git log")
-- map("n", "<leader>GL", "<cmd>split | terminal git log --oneline --graph --decorate", "Native Git log")
map("n", "<leader>GL", ":vertical Git log --oneline --graph --decorate<CR>", "Native Git log")

-- Git blame current file
map("n", "<leader>gb", "<cmd>split | terminal git blame %<CR>", "Git blame current file")

-- Git diff
map("n", "<leader>Gd", ":vertical Git diff<CR>", "Native Git diff")

-- new file
map("n", "<C-S-n>", "<cmd>enew<cr>", "New file")

-- map("n", "q", "<nop>", "Desabling q macro key")
-- map("n", "<S-q>", "q", "Remaping macro key to Q")

-- Show current diagnostic in a float
-- map("n", "gl", vim.diagnostic.open_float, "Show Diagnostic")

-- Highlights under cursor
map("n", "<leader>cp", vim.show_pos, "Cursor position")
map("n", "<leader>iT", "<cmd>InspectTree<cr>", "Inspect tree")

-- Jump buffer based on their window number <leader>number
-- for i = 1, 6 do
-- 	local keys = "<leader>" .. i
-- 	local target = i .. "<C-w>w"
-- 	map("n", keys, target, "Jump to window " .. i)
-- end

-- Simple move
-- map("i", "<C-h>", "<left>", "Move cursor to the left")
map("i", "<M-h>", "<left>", "Move cursor to the left")
map("i", "<C-h>", "<left>", "Move cursor to the left")
-- map("i", "<C-l>", "<right>", "Move cursor to the right")
map("i", "<M-l>", "<right>", "Move cursor to the right")
map("i", "<C-l>", "<right>", "Move cursor to the right")
-- Move
map("i", "<M-k>", "<Up>", "Move cursor up")
map("i", "<C-k>", "<Up>", "Move cursor up")
map("i", "<M-j>", "<Down>", "Move cursor down")
map("i", "<C-j>", "<Down>", "Move cursor down")

-- Copy/paste interation
map("n", "<C-c>", "yy", "Paste current line down")
map("i", "<C-c>", "<esc>yya", "Paste current line down")
map("n", "<C-p>", "yyp", "Paste current line down")
map("i", "<C-p>", "<esc>yyp", "Paste current line down")
map("n", "<C-S-p>", "yyP", "Paste current line down")
map("i", "<C-S-p>", "<esc>yyP", "Paste current line down")

-- Duplicate a line and comment out the first line
-- map("n", "yc", "yygccp", "Duplicate a line and comment out the first line")

-- Reload management
-- map("n", "<leader><leader>r", "<cmd>source %<cr>", "Reload current file")
-- map("n", "<leader>R", ":.lua<cr>", "Reload lua file")
-- map("v", "<leader>R", ":lua<cr>", "Reload selected excerpt")
-- map("n", "<C-s>", "<cmd>update<CR>", "Update file")

-- Replaces all instances of highlightes words
map("n", "<C-S-s>", 'viw"hy:%s/<C-r>h//g<left><left>', "Replace all instances of highlighted words")
map("v", "<C-S-s>", '"hy:%s/<C-r>h//g<left><left>', "Replace all instances of highlighted words")

map("v", "<C-M-s>", "<cmd>sort<cr>", "Sort highlighted text in visual mode")

-- Tab bindings
map("n", "<leader>Tt", "<cmd>tabnew<cr>", "Creates new tab")
map("n", "<leader>Tx", "<cmd>tabclose<cr>", "Closes current  tab")
map("n", "<leader>Tn", "<cmd>tabnext<cr>", "Moves to next tab")
map("n", "<leader>Tp", "<cmd>tabprevious", "Moves to previous tab")

-- Errors navigate
-- map("n", "<M-j>", "<cmd>cnext<cr>", "Goto next error")
-- map("n", "<M-k>", "<cmd>cprevious<cr>", "Goto previous error")

-- Slipt bindings
-- map("n", "<leader>sv", "<cmd>vsplit<cr>", "Creates a vertical split")
-- map("n", "<leader>sh", "<cmd>split<cr>", "Create a horizontal split")
-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", "Increment number")
map("n", "<leader>-", "<C-x>", "Decrement number")

-- Move line on the screen rather than by line in the file
map("n", "j", "gj")
map("n", "k", "gk")

-- Command mode up/down remap
map("c", "<C-j>", "<Up>")
map("c", "<C-k>", "<Down>")

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^")
map({ "n", "x", "o" }, "L", "g_")

-- select line within its extension limits
map("n", "<leader>V", "^vg_", "Select line-only")

-- Avoid x and s to override the clipboard
map("n", "x", '"_x')
map("n", "X", '"_X')
-- map("n", "s", '"_s')

-- Replace a word with yanked text
map("n", "rw", "viwpyiw")

-- Replace till the end of line with yanked text
map("n", "rl", 'Pl"_D')

-- Toggle capitalise
map("n", "<leader>w", "g~iw", "Toggle capitalise")
map("v", "<leader>w", "~", "Toggle capitalise")

-- Copy file name
-- map("n", "<leader>yf", function()
-- 	local filename = vim.api.nvim_buf_getname(0)
-- 	vim.fn.setreg("+", filename)
-- 	print("copied " .. filename)
-- end, "Copy file name to clipboard")

-- Map enter to ciw in normal mode
map("i", "<C-BS>", "<Esc>ciw", "Delete a word") -- Ctrl + backspace delete a word
map("n", "<C-BS>", "diw", "Delete a word")
map("n", "<CR>", "ciw")
map("n", "<BS>", "ci")

-- redo
map("n", "U", "<C-r>", "Redo with S-u")

-- map("n", "s", "<Plug>(leap)")
-- map("n", "S", "<Plug>(leap-from-window)")
-- map({ "x", "o" }, "s", "<Plug>(leap-forward)")
-- map({ "x", "o" }, "S", "<Plug>(leap-backward)")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer

-- =================
-- Neovide-Specific Keybindings
-- =================
if vim.g.neovide then
	-- Increase font size
	map("n", "<C-=>", function()
		local font = vim.o.guifont
		local name, size = font:match("^(.-):h(%d+)")
		size = tonumber(size) + 1
		vim.o.guifont = string.format("%s:h%d", name, size)
	end, "Increase font size (Neovide)")

	-- Decrease font size
	map("n", "<C-->", function()
		local font = vim.o.guifont
		local name, size = font:match("^(.-):h(%d+)")
		size = tonumber(size) - 1
		vim.o.guifont = string.format("%s:h%d", name, size)
	end, "Decrease font size (Neovide)")
end
-- MISCS

-- Toggle Numbering
-- map("n", "<leader>n", function()
-- 	local cmds = { "nu!", "rnu!", "nonu!" }
-- 	local current_index = 1
--
-- 	current_index = current_index % #cmds + 1
-- 	vim.cmd("set " .. cmds[current_index])
-- 	local signcolumn_setting = "auto"
-- 	if cmds[current_index] == "nonu!" then
-- 		signcolumn_setting = "yes:4"
-- 	end
-- 	vim.opt.signcolumn = signcolumn_setting
-- end, "Toggle line numbering")

-- Toggle inlay hints
-- map("n", "<leader>ti", function()
-- 	local is_enabled = vim.lsp.inlay_hint.is_enabled()
-- 	vim.lsp.inlay_hint.enable(not is_enabled)
-- end, "Toggle inlay hints")

-- Toggle flow state mode, Disable most of the unnecessary plugins :oOc
-- map("n", "<leader>fl", function()
-- 	local state = 0
-- 	if state == 0 then
-- 		vim.o.relativenumber = false
-- 		vim.o.number = false
-- 		vim.opt.signcolumn = "yes:4"
-- 		vim.o.winbar = ""
-- 		state = 1
-- 	else
-- 		vim.o.relativenumber = true
-- 		vim.o.number = true
-- 		vim.opt.signcolumn = "auto"
-- 		vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
-- 		state = 0
-- 	end
-- end, "Toogle flow")
