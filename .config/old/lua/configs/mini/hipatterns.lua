local hipatterns = require("mini.hipatterns")

hipatterns.setup({
  highlighters = {
    bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})

local enabled = false

vim.api.nvim_create_user_command("ToggleHipatterns", function()
  if enabled then
    hipatterns.disable()
    print("Hipatterns disabled")
  else
    hipatterns.enable()
    print("Hipatterns enabled")
  end

  enabled = not enabled
end, {})
