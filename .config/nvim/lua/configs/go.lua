local capabilities = require("blink.cmp").get_lsp_capabilities()
local go = require("go")

go.setup({
  capabilities = capabilities,
  -- lsp_on_attach = require("plugins.lsp.on_attach").on_attach,
  icons = {
    breakpoint = "",
    currentpos = "",
  },
  lsp_cfg = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = false,
          compositeLiteralFields = false,
          compositeLiteralTypes = false,
          constantValues = false,
          functionTypeParameters = false,
          parameterNames = true,
          rangeVariableTypes = false,
        },
        -- analyses = {
        --   fieldalignment = true,
        --   nilness = true,
        --   unusedparams = true,
        --   unusedwrite = true,
        --   useany = true,
        -- },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
  lsp_keymaps = false,
  lsp_codelens = true,
  -- luasnip = true,
  trouble = true,
})
