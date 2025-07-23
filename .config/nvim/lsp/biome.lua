---@brief
--- https://biomejs.dev
---
--- Toolchain of the web. [Successor of Rome](https://biomejs.dev/blog/annoucing-biome).
---
--- ```sh
--- npm install [-g] @biomejs/biome
--- ```

-- local util = require("configs.lspconfig.util")
local util = require "lspconfig.util"
local blink = require "blink.cmp"

return {
    -- cmd = { "biome", "lsp-proxy" },
    cmd = function(dispatchers, config)
        local cmd = 'biome'
        local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/biome'
        if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
        end
        return vim.lsp.rpc.start({ cmd, 'lsp-proxy' }, dispatchers)
    end,
    filetypes = {
        "astro",
        "css",
        "graphql",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
    },
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_files = { "biome.json", "biome.jsonc" }
        root_files = util.insert_package_json(root_files, "biome", fname)
        local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
        on_dir(root_dir)
    end,

    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities(),
        {
            fileOperations = {
                didRename = true,
                willRename = true,
            },
        }
    ),
}
