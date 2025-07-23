return {
    "echasnovski/mini.diff",
    version = "*",
    event = { "VeryLazy" },
    cond = function()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        return git_root and vim.fn.systemlist("git ls-files --errorunmatch" .. vim.fn.expand("%:p"))[1] ~= nil
    end,
    config = function()
        require("configs.diff")
    end,
}
