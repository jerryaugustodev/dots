---@meta
-- Language Server configuration for golangci-lint-langserver.
-- This server provides diagnostics by wrapping the golangci-lint tool.
--
-- Documentation: https://github.com/nametake/golangci-lint-langserver

local blink = require "blink.cmp"

return {
    -- The command to start the language server.
    cmd = { "golangci-lint-langserver" },

    -- The filetypes this server should attach to.
    filetypes = { "go", "gomod" },

    init_options = {
        command = { 'golangci-lint', 'run', '--output.json.path=stdout', '--show-stats=false' },
    },

    -- Root directory markers. It will activate in any Go module or git repository.
    root_markers = {
        '.golangci.yml',
        '.golangci.yaml',
        '.golangci.toml',
        '.golangci.json',
        'go.work',
        'go.mod',
        '.git',
    },
    -- root_markers = { ".golangci.yml", ".golangci.yaml", "go.mod", ".git" },

    before_init = function(_, config)
        -- Add support for golangci-lint V1 (in V2 `--out-format=json` was replaced by
        -- `--output.json.path=stdout`).
        local v1
        -- PERF: `golangci-lint version` is very slow (about 0.1 sec) so let's find
        -- version using `go version -m $(which golangci-lint) | grep '^\smod'`.
        if vim.fn.executable 'go' == 1 then
            local exe = vim.fn.exepath 'golangci-lint'
            local version = vim.system({ 'go', 'version', '-m', exe }):wait()
            v1 = string.match(version.stdout, '\tmod\tgithub.com/golangci/golangci%-lint\t')
        else
            local version = vim.system({ 'golangci-lint', 'version' }):wait()
            v1 = string.match(version.stdout, 'version v?1%.')
        end
        if v1 then
            config.init_options.command = { 'golangci-lint', 'run', '--out-format', 'json' }
        end
    end,

    -- We merge our custom capabilities with the defaults.
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
