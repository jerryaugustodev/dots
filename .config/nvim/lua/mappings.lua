--- A helper function to simplify and standardize keymap creation.
-- This function abstracts the boilerplate of `vim.keymap.set` and enforces
-- `noremap` and `silent` by default for a better user experience.
--
-- @param mode string | table The mode(s) for the keymap (e.g., "n", "v", { "n", "i" }).
-- @param keys string The key sequence to map (e.g., "<leader>w").
-- @param action string | function The command or Lua function to execute.
-- @param desc? string An optional description for the keymap, used by plugins like `mini.clue`.
local function map(mode, keys, action, desc)
    desc = desc or ""
    ---@type table
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, keys, action, opts)
end

-- =============================================================================
-- | CORE ESSENTIALS & QUALITY OF LIFE
-- =============================================================================

-- Fast saving and quitting
map("n", "<leader>w", "<cmd>write<cr>", "Write File")
map("n", "<leader>q", "<cmd>quit<cr>", "Quit")
map("n", "<leader>Q", "<cmd>qall!<cr>", "Quit All")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohl<cr>", "Clear Search Highlight")

-- Make the current file executable
map("n", "<leader>cx", "<cmd>!chmod +x %<cr>", "Make File Executable")

-- Center the view when navigating search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Keep the cursor in place when joining lines
map("n", "J", "mzJ`z")

-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", "Increment number")
map("n", "<leader>-", "<C-x>", "Decrement number")

-- Move line on the screen rather than by line in the file
map("n", "j", "gj")
map("n", "k", "gk")

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^")
map({ "n", "x", "o" }, "L", "g_")

-- redo
map("n", "U", "<C-r>", "Redo with U")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- =============================================================================
-- | Editing
-- =============================================================================

-- Indent
map("n", "<leader>I", "gg=G''", "Native Indent")
map("v", "<", "<gv", "Indent Left")
map("v", ">", ">gv", "Indent Right")

-- Yank/Paste/Delete
map("n", "<leader>yy", "<cmd>%y+<cr>", "Yank whole file")
map("x", "<leader>p", '"_dP', "Paste without yanking")
map("n", "<leader>d", '"_d', "Delete to null register")
map("v", "<leader>d", '"_d', "Delete selection to null register")
map("n", "x", '"_x')
map("n", "X", '"_X')

-- Replace
map("n", "<leader>rw", "viwpyiw", "Replace word with yanked text")
map("n", "<leader>rl", 'Pl"_D', "Replace until end of line with yanked text")
map("n", "<C-S-s>", 'viw"hy:%s/<C-r>h//g<left><left>', "Replace all instances of highlighted words")
map("v", "<C-S-s>", '"hy:%s/<C-r>h//g<left><left>', "Replace all instances of highlighted words")

-- Move selected line / block of text
map("n", "<M-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move down")
map("i", "<C-M-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
-- map("v", "<M-j>", ":<C-u>execute "'<,'>move '>+" . v:count1<cr>gv=gv", "Move down")
map("n", "<M-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move up")
map("i", "<C-M-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
-- map("v", "<M-k>", ":<C-u>execute "'<,'>move '>-" . (v:count1 + 1)<cr>gv=gv", "Move up")

-- Toggle capitalise
map("n", "<leader>w", "g~iw", "Toggle capitalise")
map("v", "<leader>w", "~", "Toggle capitalise")

-- =============================================================================
-- | Insert Mode
-- =============================================================================

-- Fast exit
map("i", "jj", "<Esc>", "Exit insert mode with jj")
map("i", "jk", "<Esc>", "Exit insert mode with jk")
map("i", "kj", "<Esc>", "Exit insert mode with kj")
map("i", "kk", "<Esc>", "Exit insert mode with kk")

-- Move
map("i", "<C-b>", "<ESC>^i", "Move to beginning of line")
map("i", "<C-e>", "<End>", "Move end of line")
map("i", "<M-h>", "<left>", "Move cursor to the left")
map("i", "<C-h>", "<left>", "Move cursor to the left")
map("i", "<M-l>", "<right>", "Move cursor to the right")
map("i", "<C-l>", "<right>", "Move cursor to the right")
map("i", "<M-k>", "<Up>", "Move cursor up")
map("i", "<C-k>", "<Up>", "Move cursor up")
map("i", "<M-j>", "<Down>", "Move cursor down")
map("i", "<C-j>", "<Down>", "Move cursor down")

-- Map enter to ciw in normal mode
map("i", "<C-BS>", "<Esc>ciw", "Delete a word")
map("n", "<C-BS>", "diw", "Delete a word")
map("n", "<CR>", "ciw")
map("n", "<BS>", "ci")

-- =============================================================================
-- | Visual Mode
-- =============================================================================

-- Select all
map("n", "<C-a>", "GVgg")
map({ "i", "v" }, "<C-a>", "<Esc>GVgg")

-- select line within its extension limits
map("n", "<leader>V", "^vg_", "Select line-only")

-- Sort highlighted text
map("v", "<C-M-s>", "<cmd>sort<cr>", "Sort highlighted text in visual mode")

-- Help
map("v", "??", 'y:h <C-R>"<cr>') -- Show vim help
map("v", "?/", 'y:/ <C-R>"<cr>') -- Search across the buffer

-- =============================================================================
-- | Command Mode
-- =============================================================================

map("c", "<C-j>", "<Up>")
map("c", "<C-k>", "<Down>")

-- =============================================================================
-- | WINDOW & BUFFER & TAB NAVIGATION
-- =============================================================================

-- Windows
map("n", "<C-h>", "<C-w>h", "Navigate Left Window")
map("n", "<C-l>", "<C-w>l", "Navigate Right Window")
map("n", "<C-j>", "<C-w>j", "Navigate Down Window")
map("n", "<C-k>", "<C-w>k", "Navigate Up Window")
map("n", "<C-S-h>", "<cmd>vertical resize +1<cr>", "Resizes vertical split +")
map("n", "<C-S-l>", "<cmd>vertical resize -1<cr>", "Resizes vertical split -")
map("n", "<C-S-k>", "<cmd>horizontal resize +1<cr>", "Resizes horizontal split +")
map("n", "<C-S-j>", "<cmd>horizontal resize -1<cr>", "Resizes horizontal split -")
map("n", "<leader>=", "<C-w>=", "Equalize splits")

-- Buffers
map("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<s-Tab>", "<cmd>bprev<CR>", "Previous buffer")
map("n", "<leader>bq", "<cmd>%bd|e#|bd#<cr>", "Close all other buffers")

-- Tabs
map("n", "<leader>Tt", "<cmd>tabnew<cr>", "Creates new tab")
map("n", "<leader>Tx", "<cmd>tabclose<cr>", "Closes current  tab")
map("n", "<leader>Tn", "<cmd>tabnext<cr>", "Moves to next tab")
map("n", "<leader>Tp", "<cmd>tabprevious", "Moves to previous tab")

-- =============================================================================
-- | NATIVE GIT WORKFLOW (Plugin-Free)
-- =============================================================================

map("n", "<leader>Gs", "<cmd>split | terminal git status<cr>", "Git status")
map("n", "<leader>Gl", ":!git log --oneline<CR>", "Native Git log")
map("n", "<leader>GL", ":vertical Git log --oneline --graph --decorate<CR>", "Native Git log")
map("n", "<leader>gb", "<cmd>split | terminal git blame %<CR>", "Git blame current file")
map("n", "<leader>Gd", ":vertical Git diff<CR>", "Native Git diff")

-- =============================================================================
-- | UTILITIES
-- =============================================================================

-- New file
map("n", "<C-S-n>", "<cmd>enew<cr>", "New file")

-- Highlights under cursor
map("n", "<leader>cp", vim.show_pos, "Cursor position")
map("n", "<leader>iT", "<cmd>InspectTree<cr>", "Inspect tree")

-- Copy filepath/filename
map("n", "<leader>yn", function()
  local filepath = vim.fn.expand('%')
  if filepath == '' then
    vim.notify('No file name to copy.', vim.log.levels.WARN)
    return
  end
  vim.fn.setreg('+', filepath)
  vim.notify('Filename copied to clipboard: ' .. filepath, vim.log.levels.INFO)
end, "Copy filepath to clipbeard")

map("n", "<leader>yp", function()
  local filename = vim.fn.expand('%:t')
  if filename == '' then
    vim.notify('No file name to copy.', vim.log.levels.WARN)
    return
  end
  vim.fn.setreg('+', filename)
  vim.notify('Filename copied to clipboard: ' .. filename, vim.log.levels.INFO)
end, "Copy filename to clipbeard")

-- =============================================================================
-- | Neovide-Specific Keybindings
-- =============================================================================
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
