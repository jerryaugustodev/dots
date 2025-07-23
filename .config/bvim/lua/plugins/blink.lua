return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            -- { "Kaiser-Yang/blink-cmp-git" },
            { "rafamadriz/friendly-snippets" },
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("configs.copilot")
                end,
            },
            { "giuxtaposition/blink-cmp-copilot" },
        },
        config = function()
            require("configs.blink")
        end,
    },
    -- Blink Colorize Suggestoins
    {
        "xzbdmw/colorful-menu.nvim",
        event = "InsertEnter",
        config = function()
            require("configs.colorful-menu")
        end,
    }
}
