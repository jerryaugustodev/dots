local telescope = require("telescope")

telescope.setup {
  pickers = {
    find_files = {
      theme = "ivy"
    }
  },
  extensions = {
    fzf = {}
  }
}

require("telescope").load_extension("fzf")
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)

-- Explore nvim files
vim.keymap.set("n", "<leader>en", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath("config")
  }
end)

vim.keymap.set("n", "<leader>ep", function()
  require("telescope.builtin").find_files {
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  }
end)
