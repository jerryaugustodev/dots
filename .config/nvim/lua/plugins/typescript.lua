---@diagnostic disable: missing-fields
return {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {
        settings = {
            -- Enable or disable specific features
            expose_as_code_action = "all",  -- options: "all", "fix_all", "organize_imports", "remove_unused", etc.
            tsserver_plugins = {},         -- Array of tsserver plugin paths if any

            -- Formatter settings
            complete_function_calls = true, -- Auto-insert function arguments on completion
            tsserver_format_options = {
                allowIncompleteCompletions = false,
                allowRenameOfImportPath = true,
            },
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
                includeCompletionsForModuleExports = true,
                includeCompletionsWithInsertText = true,
                quotePreference = "auto", -- "auto" | "double" | "single"
            },

            -- Formatter override: disable tsserver formatter if you use prettier or biome
            separate_diagnostic_server = true, -- improves diagnostics performance
            publish_diagnostic_on = "insert_leave", -- options: "change", "insert_leave"

            -- Memory and performance tweaks
            max_tsserver_memory = 4096, -- in MB
            -- Optionally specify tsserver path:
            -- tsserver_path = "/path/to/tsserver",
        },

        on_attach = function(client, bufnr)
            -- Optional: Disable formatting to delegate to an external formatter like biome
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- Optional: Define keymaps specific to typescript-tools
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", opts)
            vim.keymap.set("n", "<leader>tr", "<cmd>TSToolsRenameFile<cr>", opts)
            vim.keymap.set("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<cr>", opts)
            vim.keymap.set("n", "<leader>tm", "<cmd>TSToolsRemoveUnusedImports<cr>", opts)
        end,
    },
}
