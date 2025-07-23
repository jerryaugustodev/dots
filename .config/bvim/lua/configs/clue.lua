local clue = require("mini.clue")

clue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>", desc = "Leader key" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z", desc = "Folds" },
        { mode = "x", keys = "z", desc = "Folds" },

        -- Diagnostics keys
        -- { mode = "n", keys = "", desc = "Diagnostics" },

        -- Motion prefix
        { mode = "n", keys = "]", desc = "Motion next" },
        { mode = "n", keys = "[", desc = "Motion previous" },
        { mode = "n", keys = "c", desc = "Chage trigger" },
        { mode = "n", keys = "d", desc = "Delete trigger" },
        { mode = "n", keys = "y", desc = "Yank trigger" },
        { mode = 'o', keys = 'a' },
        { mode = 'o', keys = 'i' },
        { mode = 'x', keys = 'a' },
        { mode = 'x', keys = 'i' },
    },

    clues = {
        -- Native Vim text objects
        { mode = 'o', keys = 'iw', desc = 'Inner word' },
        { mode = 'o', keys = 'aw', desc = 'Around word' },
        -- { mode = 'o', keys = 'ip', desc = 'Inner paragraph' },
        -- { mode = 'o', keys = 'ap', desc = 'Around paragraph' },
        -- Treesitter text objects
        { mode = 'o', keys = 'af', desc = 'Around function (Treesitter)' },
        { mode = 'o', keys = 'if', desc = 'Inner function (Treesitter)' },
        { mode = 'o', keys = 'ac', desc = 'Around class (Treesitter)' },
        { mode = 'o', keys = 'ic', desc = 'Inner class (Treesitter)' },
        { mode = "n", keys = "<leader>b", desc = "Buffers" },
        -- { mode = "n", keys = "<leader>c", desc = "CodeSnap" },
        { mode = "n", keys = "<leader>d", desc = "Diagnostics" },
        { mode = "n", keys = "<leader>f", desc = "Fuzzy Finder" },
        { mode = "n", keys = "<leader>g", desc = "Git" },
        { mode = "n", keys = "<leader>l", desc = "LSP" },
        -- { mode = "n", keys = "<leader>t", desc = "Test" },
        { mode = "n", keys = "<leader>T", desc = "Tabs" },
        -- { mode = "n", keys = "<leader>k", desc = "Kulala" },
        { mode = "n", keys = "<leader>s", desc = "Search" },
        { mode = "n", keys = "<leader>y", desc = "Yank" },
        { mode = "n", keys = "<leader>r", desc = "Replace" },
        { mode = "n", keys = "<leader>u", desc = "Toggles" },
        { mode = "n", keys = "<leader>p", desc = "Picker" },
        { mode = "n", keys = "da", desc = "Delete around" },
        { mode = "n", keys = "di", desc = "Delete inner" },
        { mode = "n", keys = "ca", desc = "Change around" },
        { mode = "n", keys = "ci", desc = "Change inner" },
        { mode = "n", keys = "]", desc = "Motion forward" },
        { mode = "n", keys = "[", desc = "Motion backward" },
        -- Enhance this by adding descriptions for <Leader> mapping groups
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
    },

    window = {
        delay = 500,
    },
})

