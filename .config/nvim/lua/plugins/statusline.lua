return {
    "echasnovski/mini.statusline",
    version = "*",
    event = "BufWinEnter",
    -- lazy = false,
    dependencies = {
        { "echasnovski/mini.ai" },
        { "echasnovski/mini.surround" },
    },
    config = function()
        require("configs.statusline")
        -- require("mini.statusline").setup()
    end,
}
