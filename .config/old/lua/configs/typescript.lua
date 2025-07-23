local tstools = require("typescript-tools")
local capabilities = require("blink.cmp").get_lsp_capabilities()

tstools.setup({
  capabilities = capabilities,
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    separate_diagnostic_server = true,
    expose_as_code_action = "all",
    tsserver_max_memory = "auto",
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    code_lens = "all",
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
      -- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
    },
    jsx_close_tag = {
      enable = true,
      filetypes = { "javascript", "typescript" },
    },
  },
})
