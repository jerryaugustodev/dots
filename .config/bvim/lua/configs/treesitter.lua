local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {
        "bash",
        "comment",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "editorconfig",
        "fish",
        "git_config",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "gpg",
        "html",
        "http",
        "hyprlang",
        "javascript",
        "jq",
        "json",
        "json5",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "norg",
        "passwd",
        "printf",
        "prisma",
        "proto",
        "query",
        "regex",
        "scheme",
        "scss",
        "sql",
        "ssh_config",
        "styled",
        "svelte",
        "terraform",
        "textproto",
        "tmux",
        "todotxt",
        "toml",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "xresources",
        "yaml",
    },
    auto_install = false,
    sync_install = false,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 24 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        use_languagetree = true,
        additional_vim_regex_highlighting = false, -- performance
    },
    autotag = { enabled = true },
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    ignore_install = { "javascript" },
    modules = {},
    indent = { enabled = true },
    matchup = {
        enable = true,
    },
    {
        context_commentstring = {
            enable = true,
            enable_autocmd = true,
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<leader>v",
            node_incremental = "=",
            scope_incremental = false,
            node_decremental = "-",
        },
    },
    textobjects = {
        lsp_interop = {
            enabled = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = "Around a function" },
                ["if"] = { query = "@function.inner", desc = "Inner a function" },
                ["aC"] = { query = "@class.outer", desc = "Around a class" },
                ["iC"] = { query = "@class.inner", desc = "Inner a class" },
                ["ai"] = { query = "@conditional.outer", desc = "Around an if statement" },
                ["ii"] = { query = "@conditional.inner", desc = "Inner an if statement" },
                ["al"] = { query = "@loop.outer", desc = "Around a loop" },
                ["il"] = { query = "@loop.inner", desc = "Inner a loop" },
                ["ap"] = { query = "@parameter.outer", desc = "Around parameter" },
                ["ip"] = { query = "@parameter.inner", desc = "Inside a parameter" },
                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                ["ac"] = { query = "@comment.outer", desc = "Around a comment" },
                ["ic"] = { query = "@comment.inner", desc = "Inside a comment" },
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@parameter.inner"] = "v", -- charwise
                ["@function.outer"] = "v", -- charwise
                ["@conditional.outer"] = "V", -- linewise
                ["@loop.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = false,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Previous function" },
                ["[c"] = { query = "@class.outer", desc = "Previous class" },
                ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
                ["[r"] = { query = "@return.outer", desc = "Previous return" },
                ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next function" },
                ["]c"] = { query = "@class.outer", desc = "Next class" },
                ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
                ["]r"] = { query = "@return.outer", desc = "Next return" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "Last function" },
                ["]X"] = { query = "@regex.outer", desc = "Last regex" },
                ["]R"] = { query = "@return.outer", desc = "Last return" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner", desc = "Swap next parameter",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner", desc = "Swap previous parameter",
            },
        },
    },
})

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, "<leader>;", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, "<leader>,", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- This repeats the last query with always previous direction and to the start of the range.
vim.keymap.set({ "n", "x", "o" }, "<home>", function()
    ts_repeat_move.repeat_last_move({ forward = false, start = true })
end)

-- This repeats the last query with always next direction and to the end of the range.
vim.keymap.set({ "n", "x", "o" }, "<end>", function()
ts_repeat_move.repeat_last_move({ forward = true, start = false })
end)

