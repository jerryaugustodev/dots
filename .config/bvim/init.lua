-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "options"
require "mappings"
require "autocmds"

-- This section ensures that lazy.nvim is installed and ready to use.
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.notify("Cloning lazy.nvim...", vim.log.levels.INFO)
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    -- Kanagawa the - G O A T - colorscheme ever!
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require "configs.kanagawa"
        end,
        init = function()
            vim.cmd.colorscheme("kanagawa")
        end,
    },

    { import = "plugins" },
}, lazy_config)

-- require "configs.statusline"

if vim.g.neovide then
    require "neovide"
end

