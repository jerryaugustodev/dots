local opt = vim.opt
local o = vim.o
local g = vim.g
local space = "·"
local cmd = vim.cmd

g.mapleader = " "
g.maplocalleader = "\\"

g.netrw_banner = 0
g.netrw_browser_split = 4
g.netrw_altv = 1
g.netrw_liststyle = 3
-- cmd("let g:netrw_liststyle = 3")
opt.title = false
cmd("set path+=**")
opt.syntax = "ON"
opt.compatible = false
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
-- opt.hlsearch = false
opt.incsearch = true
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.fileencoding = "utf-8"
opt.pumheight = 10
opt.showtabline = 2
opt.laststatus = 2
opt.signcolumn = "auto"
opt.expandtab = true
opt.smartindent = true
-- opt.showcmd = true BUG this bugs neovide 'cmdheight' feature
opt.cmdheight = 0
opt.showmode = false
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.guifont = "JetBrainsMono Nerd Font:h10"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect" }
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.swapfile = false
opt.undofile = true
opt.signcolumn = "yes"
opt.isfname:append("@-@")
-- opt.colorcolumn = "80"
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.updatetime = 300
opt.showbreak = "↪"
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

-- cmd [[
--     set path+=**
--     filetype plugin on
--     set wildmenu
--     command! Reload :source ~/dots/.config/nvim/init.lua
-- ]]

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

--- Load shada after ui-enter
local shada = o.shada
o.shada = ""
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		o.shada = shada
		pcall(vim.cmd.rshada, { bang = true })
	end,
})

vim.opt.laststatus = 0 -- Always display the status line

vim.filetype.add({
	extension = {
		env = "dotenv",
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

-- add binaries installed by mason.nvim to path
-- local is_windows = vim.fn.has "win32" ~= 0
-- local sep = is_windows and "\\" or "/"
-- local delim = is_windows and ";" or ":"
-- vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- return opts
