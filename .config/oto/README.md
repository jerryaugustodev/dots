# Neovim Configuration

A modern, modular, and fast Neovim configuration written in Lua, built around `lazy.nvim` for plugin management.

## Features

*   **Fast Startup:** Optimized for speed with lazy-loading of plugins.
*   **Modern UI:** A clean and functional user interface with a status line, tab line, and icons.
*   **Enhanced Editing:** Advanced editing features like auto-pairing, bracket management, and code formatting.
*   **Powerful Tooling:** Integration with the Language Server Protocol (LSP), linters, and formatters.
*   **Fuzzy Finding:** Fast file and text searching with Telescope.
*   **Git Integration:** Seamless Git integration within Neovim.

## Language Support

This configuration provides rich, language-specific support for the following languages using the Language Server Protocol (LSP):

*   Biome
*   CSS
*   Docker
*   Go
*   HTML
*   Lua
*   Markdown
*   PostgreSQL
*   Prisma
*   ReScript
*   SQL
*   TailwindCSS
*   Terraform
*   TypeScript
*   YAML

## Keybindings

Here are some of the keybindings configured:

| Keys          | Description                               |
| ------------- | ----------------------------------------- |
| `jj`, `jk`    | Exit insert mode                          |
| `<Esc>`       | Clear search highlight                    |
| `<C-S-n>`     | New file                                  |
| `<leader>cp`  | Show cursor position                      |
| `<Tab>`       | Next buffer                               |
| `<S-Tab>`     | Previous buffer                           |
| `<leader>bd`  | Delete buffer                             |
| `<leader>sv`  | Create a vertical split                   |
| `<leader>sh`  | Create a horizontal split                 |
| `<C-h/j/k/l>` | Navigate splits                           |
| `<C-a>`       | Select all                                |
| `<M-j/k>`     | Move selected line/block up/down          |

## Installation

1.  Clone this repository to your Neovim configuration directory:
    ```bash
    git clone <repository-url> ~/.config/nvim
    ```
2.  Start Neovim. The plugins will be automatically installed on the first run.

## Plugins

This configuration uses the following plugins:

*   [blink-cmp-copilot](https://github.com/blink-contrib/blink-cmp-copilot)
*   [blink.cmp](https://github.com/blink-contrib/blink.cmp)
*   [colorful-menu.nvim](https://github.com/emanuelduss/colorful-menu.nvim)
*   [conform.nvim](https://github.com/stevearc/conform.nvim)
*   [copilot.lua](https://github.com/zbirenbaum/copilot.lua)
*   [edgy.nvim](https://github.com/folke/edgy.nvim)
*   [flash.nvim](https://github.com/folke/flash.nvim)
*   [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
*   [go.nvim](https://github.com/ray-x/go.nvim)
*   [guihua.lua](https://github.com/ray-x/guihua.lua)
*   [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
*   [kulala.nvim](https://github.com/mistweaverco/kulala.nvim)
*   [lazy.nvim](https://github.com/folke/lazy.nvim)
*   [lazydev.nvim](https://github.com/folke/lazydev.nvim)
*   [lazydocker.nvim](https://github.com/Seanstoppable/lazydocker.nvim)
*   [mini-git](https://github.com/echasnovski/mini-git)
*   [mini.bracketed](https://github.com/echasnovski/mini.bracketed)
*   [mini.clue](https://github.com/echasnovski/mini.clue)
*   [mini.diff](https://github.com/echasnovski/mini.diff)
*   [mini.files](https://github.com/echasnovski/mini.files)
*   [mini.fuzzy](https://github.com/echasnovski/mini.fuzzy)
*   [mini.hipatterns](https://github.com/echasnovski/mini.hipatterns)
*   [mini.icons](https://github.com/echasnovski/mini.icons)
*   [mini.statusline](https://github.com/echasnovski/mini.statusline)
*   [mini.tabline](https://github.com/echasnovski/mini.tabline)
*   [nvim-lint](https://github.com/mfussenegger/nvim-lint)
*   [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
*   [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar)
*   [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
*   [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
*   [oil.nvim](https://github.com/stevearc/oil.nvim)
*   [snacks.nvim](https://github.com/mrded/snacks.nvim)
*   [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
*   [ultimate-autopair.nvim](https://github.com/altermo/ultimate-autopair.nvim)
*   [vim-illuminate](https://github.com/RRethy/vim-illuminate)
*   [vim-visual-multi](https://github.com/mg979/vim-visual-multi)
