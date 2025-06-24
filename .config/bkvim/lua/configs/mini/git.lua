local git = require("mini.git")

git.setup({
  integratins = {
    diff = true,
    blame = true,
    status = true,
  },
  use_icons = true,
  blame_format = "<author>, <date> - <summary>",
  mappings = {
    blame = "<leader>gb",
    diff_preview = "<leader>gd",
    pull = "<leader>gp",
    push = "<leader>gP"
  }
})
