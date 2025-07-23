return {
    "nvim-treesitter/nvim-treesitter",
    -- lazy = false,
    event = { "BufReadPost", "BufNewFile" }, -- Loads only when opening a file
    branch = 'master',
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        require "configs.treesitter"
    end,
}
