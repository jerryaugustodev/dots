return {
    "echasnovski/mini.clue",
    -- event = { "CmdlineEnter", "CursorHold", "CursorHoldI" },
    keys = {
        { "c" },
        { "d" },
        { "g" },
        { "y" },
        { "z" },
        { "]" },
        { "[" },
        { "<leader>" },
    },
    config = function()
        require("configs.clue")
    end,
}
