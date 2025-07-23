local opt = vim.opt
-- local o = vim.o
local g = vim.g

-- Set to false if you don't have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Netrw configuration for a cleaner, more structured, and user-friendly file browsing experience
vim.g.netrw_banner = 0 -- Disable the top banner in Netrw to reduce visual clutter.
vim.g.netrw_browser_split = 4 -- Open Netrw in the previously used window instead of creating a new split.
vim.g.netrw_altv = 1 -- Ensure vertical splits opened by Netrw appear on the right side of the window.
vim.g.netrw_liststyle = 3 -- Set Netrw to display files in a tree-style hierarchical view.

-- ▶ General and UI
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers for motions
opt.cursorline = true -- Highlight the current line
opt.scrolloff = 14 -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8                  -- Minimal horizontal space to keep when scrolling
opt.mouse = 'a' -- Enable mouse support in all modes
opt.title = true                       -- Set terminal title to the file name
opt.splitbelow = true                  -- New horizontal splits open below
opt.splitright = true                  -- New vertical splits open to the right
opt.showtabline = 0 -- Esconde por padrão
-- Enable true color support for terminals that support it
if vim.fn.has("termguicolors") == 1 then
    opt.termguicolors = true -- Enable 24-bit RGB colors
end
-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true


-- ▶ Indentation and Tabs
-- Configure indentation rules. This block enforces the use of soft tabs (spaces)
-- instead of hard tab characters, sets the width for all indentation operations
-- to 4 spaces, and enables smart, context-aware auto-indenting.
opt.tabstop = 4                        -- Number of spaces that a <Tab> in the file counts for
opt.shiftwidth = 4                     -- Number of spaces to use for each step of (auto)indent
opt.softtabstop = 4                    -- Number of spaces that a <Tab> counts for while performing editing operations
opt.expandtab = true                   -- Use spaces instead of tabs
opt.smarttab = true
opt.smartindent = true                 -- Smart autoindenting on new lines
opt.breakindent = true                -- Preserve indentation in wrapped lines

-- ▶ Searching
opt.ignorecase = true                  -- Ignore case when searching
opt.smartcase = true                   -- Override ignorecase if search pattern contains uppercase
opt.hlsearch = true                    -- Highlight search results
opt.incsearch = true                   -- Show search matches while typing
opt.showmatch = true                   -- Briefly jump to matching bracket
opt.inccommand = 'split' -- Preview substitutions live, as you type!

-- ▶ Files, Buffers and Backup
opt.hidden = true -- Allow buffers to be hidden without being saved
opt.undofile = true -- Enable persistent undo history
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Directory to store undo history
opt.swapfile = false -- Disable swapfile creation
opt.backup = false -- Disable file backups
-- Defines the parameters for session data storage, including command history, marks, and search history.
-- '100      → Save 100 command lines.
-- <50      → Save marks for files less than 50 lines long.
-- s10      → Limit storage file size to 10 KiB.
-- h        → Disable the recording of `hlsearch` highlighting.
opt.shada = [['100,<50,s10,h]] -- Save command and search history across sessions

-- ▶ Clipboard and Interaction
opt.showcmd = true -- Show (partial) command in the last line of the screen
opt.showmode = false -- Don't show the mode, since it's already in the status line
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options for better UX with cmp
opt.updatetime = 300 -- Faster triggering of CursorHold, swap writes
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    opt.clipboard = 'unnamedplus' -- Use system clipboard by default
end)
-- Set the command line height based on the execution environment.
if vim.g.neovide then
    opt.cmdheight = 1
else
    opt.cmdheight = 0
end

-- ▶ Git, Diff and Performance
opt.lazyredraw = true                  -- Don't redraw while executing macros (improves performance)
opt.redrawtime = 500                   -- Time limit for syntax highlighting
opt.foldmethod = "expr"                -- Use expression-based folding
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use Tree-sitter for folding
opt.foldenable = false                            -- Do not fold by default when opening files
opt.foldlevel = 99                                -- Open all folds initially
opt.foldlevelstart = 99                           -- Initial fold level when opening a buffer
-- Decrease mapped sequence wait time
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.synmaxcol = 120
opt.fileformats = { 'unix', 'mac', 'dos' } -- Line endings support
-- vim.opt.foldcolumn = "1"  -- Show 1-character wide fold column
-- vim.opt.fillchars:append({
--   foldopen = "",  -- Icon when fold is open
--   foldclose = "", -- Icon when fold is closed
--   foldsep = " ",   -- No separator
-- })
-- vim.keymap.set("n", "zR", "zR", { desc = "Open all folds" })
-- vim.keymap.set("n", "zM", "zM", { desc = "Close all folds" })

-- ▶ Display and Smooth Experience (esp. Neovide)
opt.showbreak = "↪" -- Show this symbol at wrapped line start | ↪
opt.linebreak = true -- Wrap lines at convenient points
-- opt.smoothscroll = true                -- Enable smooth scrolling (Neovim 0.12+)

-- ▶ Reduce noise and improve feedback
opt.shortmess:append("cI")              -- Remove intro message and completion menu messages
opt.fillchars:append({ eob = " " })     -- Hide ~ at end of buffer

-- ▶ Providers (disable if unused)
g.loaded_node_provider = 0        -- Disable Node.js provider if not needed
g.loaded_python3_provider = 0     -- Disable Python3 provider if not needed
g.loaded_perl_provider = 0        -- Disable Perl provider
g.loaded_ruby_provider = 0        -- Disable Ruby provider

-- Disable modeline for security
opt.modeline = false

-- ▶ Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
opt.list = true
opt.listchars = {
    eol = "¬", -- Character to display at end of line
    tab = " 󰍟 ", -- Character to display for a tab | :▷⋮ 󰍟 │─
    trail = " ", -- Character for trailing spaces | 󰄮 󰿦
    space = "·", -- Character to display for space
    multispace = "·", -- Character for multiple consecutive spaces
    lead = " ", -- Character for leading spaces
    -- leadmultispace = space,
    extends = "󰄾", -- Character to show when line extends beyond window
    precedes = "󰄽", -- Character to show when line precedes window
    conceal = "─", -- Character to represent concealed text | 󰩽 ┊
    nbsp = "␣", -- Character for non-breaking space | 󰟾 󰄮
}

-- ▶ Registers custom filetype detection rules for Neovim.

-- Enable Lua-based filetype detection for better performance and accuracy
vim.g.do_filetype_lua = 1             -- Use the Lua implementation of filetype detection

-- BUG INFERNAL
-- vim.g.did_load_filetypes = 0          -- Prevent loading the legacy Vimscript filetype detection

-- Extend filetype detection with custom definitions
vim.filetype.add({
    extension = {
        -- env = "dotenv",
        ["http"] = "http",
        templ = "templ",                  -- .templ files for templating engines
        env = "sh",                       -- .env files treated as shell scripts
        tf = "terraform",                 -- .tf files as Terraform
        tfvars = "terraform",             -- .tfvars files as Terraform
        yml = "yaml",                     -- .yml as YAML (alias)
        yaml = "yaml",                    -- .yaml as YAML
        toml = "toml",                    -- .toml files
        jsonc = "jsonc",                  -- JSON with comments
        mdx = "markdown",                 -- .mdx as Markdown
        zsh = "zsh",                      -- .zsh files as Zsh scripts
    },
    filename = {
        [".env"] = "dotenv",
        ["env"] = "dotenv",
        ["Jenkinsfile"] = "groovy",        -- Jenkins pipeline files as Groovy
        ["Dockerfile"] = "dockerfile",     -- Dockerfile as dockerfile
        ["docker-compose.yml"] = "yaml",  -- Docker Compose files as YAML
        [".bashrc"] = "sh",                -- Bash configuration
        [".zshrc"] = "zsh",                -- Zsh configuration
        [".gitconfig"] = "gitconfig",      -- Git configuration
        ["Makefile"] = "make",             -- Makefile as Make
        ["Caddyfile"] = "caddyfile",       -- Caddy server config
    },
    pattern = {
        ["[jt]sconfig.*.json"] = "jsonc",
        ["%.env%.[%w_.-]+"] = "dotenv",
        ["*.postcss.*.css"] = "postcss",
        [".*%.env%..+"] = "sh",             -- Any file like .env.production as shell script
        [".*%.service"] = "systemd",        -- Systemd service files
        [".*%.conf"] = "conf",              -- .conf files
        [".*%.git/config"] = "gitconfig",   -- Git config files
    },
})

-- ▶ Links the FloatBorder highlight group to the Comment group
vim.cmd([[highlight! link FloatBorder Comment]]) -- or any group that matches your UI
