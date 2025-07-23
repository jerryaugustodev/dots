---@meta
-- This file configures `blink.cmp`, a Neovim completion engine.
-- The setup includes keymaps, UI customization for the completion menu,
-- source providers (LSP, snippets, Copilot), and appearance settings.
-- Extensive LuaDoc annotations are provided for compatibility with `emmylua-ls`.

local blink = require "blink.cmp"
require "blink-cmp-copilot"

---@alias Cmp.Instance blink.cmp.Instance The completion instance object.
---@alias Cmp.Context blink.cmp.Context The context object for a completion item.
---@alias Cmp.Item nvim.lsp.CompletionItem A single completion item.

--- Checks if there is a non-whitespace character before the cursor.
-- @return boolean `true` if there is a word character immediately before the cursor.
local function has_words_before()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

---@module 'blink.cmp'
---@type blink.cmp.Config
blink.setup({
    --- Enables Blink based on buffer type and a buffer-local variable.
    -- @return boolean True if completion should be enabled.
    enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
    end,

    --- Enable completion for command-line mode.
    cmdline = {
        completion = { menu = { auto_show = true } },
    },

    --- Defines key mappings for completion interactions.
    ---@type table<string, table|string|function>
    keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
        -- ["<Tab>"] = {
            --- Inserts the next suggestion if a word is before the cursor.
            -- @param cmp Cmp.Instance
            -- function(cmp)
            --     if has_words_before() then
            --         return cmp.insert_next()
            --     end
            -- end,
            -- "fallback",
        -- },
        -- Na
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        -- Meta keys for accepting completion items by index.
        ["<M-1>"] = {
            function(cmp)
                cmp.accept({ index = 1 })
            end,
        },
        ["<M-2>"] = {
            function(cmp)
                cmp.accept({ index = 2 })
            end,
        },
        ["<M-3>"] = {
            function(cmp)
                cmp.accept({ index = 3 })
            end,
        },
        ["<M-4>"] = {
            function(cmp)
                cmp.accept({ index = 4 })
            end,
        },
        ["<M-5>"] = {
            function(cmp)
                cmp.accept({ index = 5 })
            end,
        },
        ["<M-6>"] = {
            function(cmp)
                cmp.accept({ index = 6 })
            end,
        },
        ["<M-7>"] = {
            function(cmp)
                cmp.accept({ index = 7 })
            end,
        },
        ["<M-8>"] = {
            function(cmp)
                cmp.accept({ index = 8 })
            end,
        },
        ["<M-9>"] = {
            function(cmp)
                cmp.accept({ index = 9 })
            end,
        },
        ["<M-0>"] = {
            function(cmp)
                cmp.accept({ index = 10 })
            end,
        },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        trigger = {
            show_on_keyword = true,
            show_on_insert_on_trigger_character = false,
        },
        keyword = { range = "full" },

        menu = {
            border = "solid", -- none | single | double | rounded | solid | shadow
            winhighlight = "Normal:BlinkNormalFloat,FloatBorder:BlinkNormalFloat,Search:None",
            min_width = vim.o.pumwidth,
            max_height = 30,
            winblend = vim.o.pumblend,
            scrollbar = false,

            cmdline_position = function()
                if vim.g.ui_cmdline_pos ~= nil then
                    local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                    return { pos[1] - 1, pos[2] }
                end
                local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                return { vim.o.lines - height, 0 }
            end,

            draw = {
                columns = {
                    { "item_idx" },
                    { "label",    "label_description", gap = 1 },
                    { "kind_icon" },
                    { "kind" },
                },
                components = {
                    kind_icon = {
                        ---@param ctx Cmp.Context
                        text = function(ctx)
                            -- default kind icon
                            local icon = ctx.kind_icon
                            -- if LSP source, check for color derived from documentation
                            if ctx.item.source_name == "LSP" then
                                local color_item =
                                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                if color_item and color_item.abbr ~= "" then
                                    icon = color_item.abbr
                                end
                            end
                            return icon .. ctx.icon_gap
                        end,
                        ---@param ctx Cmp.Context
                        highlight = function(ctx)
                            -- default highlight group
                            local highlight = "BlinkCmpKind" .. ctx.kind
                            -- if LSP source, check for color derived from documentation
                            if ctx.item.source_name == "LSP" then
                                local color_item =
                                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                if color_item and color_item.abbr_hl_group then
                                    highlight = color_item.abbr_hl_group
                                end
                            end
                            return highlight
                        end,
                    },
                    item_idx = {
                        ---@param ctx Cmp.Context
                        text = function(ctx)
                            return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                        end,
                        highlight = "BlinkCmpGhostText", -- optional, only if you want to change its color
                    },
                    label = {
                        text = require("colorful-menu").blink_components_text,
                        highlight = require("colorful-menu").blink_components_highlight,
                    },
                },
            },
        },
        list = { selection = { preselect = false }, cycle = { from_top = false } },

        documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = true,
            window = {
                min_width = 15,
                max_width = 120,
                max_height = 40,
                winblend = vim.o.pumblend,
                border = "rounded",
                winhighlight = "Normal:BlinkNormalFloat,FloatBorder:BlinkFloatBorder,Search:None",
            },
        },
    },

    signature = {
        enabled = false,
        -- window = {
        --     min_width = 1,
        --     max_width = 100,
        --     max_height = 10,
        --     winblend = vim.o.pumblend,
        --     border = "solid",
        --     winhighlight = "Normal:BlinkNormalFloat,FloatBorder:BlinkNormalFloat,Search:None",
        -- },
    },

    sources = {
        --- Dynamically provides completion sources based on context.
        -- @param ctx Cmp.Context
        default = function(ctx)
            local success, node = pcall(vim.treesitter.get_node)
            if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                return { "buffer" }
            elseif vim.bo.filetype == "lua" then
                return { "lazydev", "lsp", "path" }
            else
                return { "lsp", "path", "snippets", "buffer" }
            end
        end,

        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
            copilot = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
                --- Transforms Copilot items to assign a custom kind.
                -- @param ctx Cmp.Context The completion context.
                -- @param items Cmp.Item[] The list of completion items from Copilot.
                -- @return Cmp.Item[] The transformed items.
                transform_items = function(ctx, items)
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1
                    CompletionItemKind[kind_idx] = "Copilot"
                    for _, item in ipairs(items) do
                        item.kind = kind_idx
                    end
                    return items
                end,
            },
            snippets = {
                min_keyword_length = 3,
            },
        },
    },

    appearance = {
        use_nvim_cmp_as_default = true, -- required for custom color-types
        nerd_font_variant = "normal",   -- "normal" for nerd fonts

        kind_icons = {
            Copilot = "", --  
            Text = "󰉿",
            Method = "", -- 󰊕
            Function = "󰡱", -- 󰊕
            Constructor = "", -- 󰒓

            Field = "󰜢",
            Variable = "󰏫", -- 󰆦 󰏫 
            Property = "󰀫", -- 󰖷 󰀫 󱐋

            Class = "󰆦", -- 󱡠
            Interface = "󰆩", -- 󱡠
            Struct = "󰜬", -- 󱡠
            Module = "󰜋", -- 󰅩

            Unit = "󰘨", -- 󰪚
            Value = "󰆙", -- 󰦨
            Enum = "󰪚", -- 󰦨
            EnumMember = "", -- 󰦨

            Keyword = "󱕵", -- 󰻾
            Constant = "󰕶", -- 󰏿

            Snippet = "󰴹", -- 󱄽
            Color = "󱓻", -- 󰏘
            File = "󰈚", -- 󰈔
            Reference = "", -- 󰬲
            Folder = "󰉋", -- 󰉋
            Event = "󰙴", -- 󱐋
            Operator = "", -- 󰪚
            TypeParameter = "󰊄", -- 󰬛
        },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
            "exact",
            --- Custom sort function to place items starting with '_' last.
            -- @param a Cmp.Item
            -- @param b Cmp.Item
            function(a, b)
                if a.label:sub(1, 1) == "_" ~= a.label:sub(1, 1) == "_" then
                    return not a.label:sub(1, 1) == "_"
                end
            end,
            -- default sorts
            "score",
            "sort_text",
        },
    },

    opts_extend = { "sources.default" },
})
