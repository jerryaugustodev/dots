return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
        { "saghen/blink.cmp" },
        {
            -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },

                     -- Only load the lazyvim library when the `LazyVim` global is found
                    { path = "LazyVim", words = { "LazyVim" } },
                },
                completion = {
                    nvim_cmp = true, -- Enable completion integration with nvim-cmp or blink.cmp
                },
            },
        }
    },
    config = function()
        require "configs.lsp"
    end
}
