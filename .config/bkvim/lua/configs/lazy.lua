-- local uicons = require("ui")

return {
  -- rocks = { enabled = false },
  concurrency = 4,
  defaults = {
    lazy = true,
  },
  install = {
    missing = true,
    colorscheme = { "kanagawa" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  dev = {
    path = vim.env.NVIM_DEV,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "tar",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "osc52",
        "parser",
        "health",
        "man",
        "matchit",
        "tarPlugin",
        "shadafile",
        "spellfile",
        "editorconfig",
      },
    },
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  ui = {
    -- border = uicons.border.default("FloatBorder"),
    -- title = "lazy.nvim",
    -- size = { width = 0.8, height = 0.8 },
    icons = {
      cmd = " ", -- 
      config = " ",
      event = " ", -- 
      favorite = " ", -- 
      ft = "󰈚 ", --  
      init = "󰙵 ", -- 
      import = "󰶮 ", -- 
      keys = " ", -- 
      lazy = "󰂠 ", -- 󰒲
      loaded = " ", --  ●
      not_loaded = " ", --  ○
      plugin = "󰏗 ", --  󰏓
      runtime = " ",
      require = "󰗖 ", -- 󰢱 
      source = " ", --      
      start = " ",
      task = " ", -- ✔ 
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
}
