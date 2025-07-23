local opt = vim.opt
local o = vim.o
local g = vim.g
local space = "·"
local cmd = vim.cmd

g.netrw_banner = 0
g.netrw_browser_split = 4
g.netrw_altv = 1
g.netrw_liststyle = 3
-- cmd("let g:netrw_liststyle = 3")
cmd("set path+=**")
opt.title = false
opt.syntax = "ON"

opt.tabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
opt.shiftwidth = 4
opt.softtabstop = 4

opt.cursorline = true

opt.breakindent = true
opt.showbreak = "↪"

opt.undofile = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.ruler = false
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes" -- auto

opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespaces characters in the editor
-- See `:help 'list'` and `:help 'listchars'`
opt.list = true
opt.listchars:append({
	eol = "¬",
	tab = "  ", -- :▷⋮ 󰍟 │─
	trail = " ", -- 󰄮 󰿦
	space = space,
	multispace = space,
	lead = " ",
	-- leadmultispace = space,
	extends = "󰄾",
	precedes = "󰄽",
	conceal = "─", -- 󰩽
	nbsp = "󰄮", -- 󰟾
})

-- Redraw lazily to improve performance with macros, large files
opt.lazyredraw = true
opt.redrawtime = 500

-- Avoid unintentional line breaks and weird wraps
opt.wrap = false
opt.linebreak = true

-- Use system clipboard for copy/paste (consistent between Neovide and terminal)
opt.clipboard = "unnamedplus"

opt.showmatch = true
-- opt.hlsearch = false
opt.scrolloff = 15
opt.sidescrolloff = 15
opt.compatible = false
opt.incsearch = true
opt.fileencoding = "utf-8"
opt.pumheight = 10
opt.showtabline = 4
opt.laststatus = 2
opt.showcmd = true -- BUG this bugs neovide 'cmdheight' feature
opt.cmdheight = 1
opt.guifont = "JetBrainsMono Nerd Font:h10"
opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }
opt.termguicolors = true
opt.swapfile = false
opt.backup = false
opt.signcolumn = "yes"
opt.isfname:append("@-@")
-- opt.colorcolumn = "80"

-- Automatically reload changed files
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	command = "checktime",
})

opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.updatetime = 200
opt.timeoutlen = 500
-- Folding
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.foldlevel = 99
opt.smoothscroll = true
opt.foldmethod = "expr"
opt.foldtext = ""
-- -- Diagnostic settings
-- -- local diagnostics = {
-- -- 	Error = " ", -- 
-- -- 	Warn = " ", -- 
-- -- 	Hint = " ",
-- -- 	Info = " ", -- 
-- -- }
-- -- vim.diagnostic.config({
-- -- 	underline = true,
-- -- 	update_in_insert = false,
-- -- 	virtual_text = {
-- -- 		spacing = 4,
-- -- 		source = "if_many",
-- -- 		prefix = "", -- ● 󰝤
-- -- 	},
-- -- 	severity_sort = true,
-- -- 	float = {
-- -- 		focusable = true,
-- -- 		-- style = "minimal",
-- -- 		border = "rounded",
-- -- 		source = true,
-- -- 		-- header = "",
-- -- 		-- prefix = "",
-- -- 	},
-- -- 	signs = {
-- -- 		text = {
-- -- 			[vim.diagnostic.severity.ERROR] = diagnostics.Error,
-- -- 			[vim.diagnostic.severity.WARN] = diagnostics.Warn,
-- -- 			[vim.diagnostic.severity.HINT] = diagnostics.Hint,
-- -- 			[vim.diagnostic.severity.INFO] = diagnostics.Info,
-- -- 		},
-- -- 	},
-- -- })
--
-- -- cmd [[
-- --     set path+=**
-- --     filetype plugin on
-- --     set wildmenu
-- --     command! Reload :source ~/dots/.config/nvim/init.lua
-- -- ]]
--
-- disable some default providers
-- g.loaded_node_provider = 0
-- g.loaded_python3_provider = 0
-- g.loaded_perl_provider = 0
-- g.loaded_ruby_provider = 0
vim.opt.shada = [['100,<50,s10,h]]
-- -- This bugs save cursor locale
-- --- Load shada after ui-enter
-- local shada = o.shada
-- o.shada = ""
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "VeryLazy",
-- 	callback = function()
-- 		o.shada = shada
-- 		pcall(vim.cmd.rshada, { bang = true })
-- 	end,
-- })

-- Bugs persistence undo
vim.opt.laststatus = 3 -- Always display the status line

vim.filetype.add({
	extension = {
		env = "dotenv",
		["http"] = "http",
	},
	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
		["%.env%.[%w_.-]+"] = "dotenv",
		["*.postcss.*.css"] = "postcss",
	},
})

vim.cmd([[highlight! link FloatBorder Comment]]) -- or any group that matches your UI

-- add binaries installed by mason.nvim to path
-- local is_windows = vim.fn.has("win32") ~= 0
-- local sep = is_windows and "\\" or "/"
-- local delim = is_windows and ";" or ":"
-- vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- return opts
