return {
    "RRethy/vim-illuminate",
    event = { "VeryLazy" },
    -- event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "]]", desc = "Next Reference" },
        { "[[", desc = "Previous Reference" },
    },
    config = function()
        require("configs.illuminate")
    end,
}
