local yanky = require("yanky")

yanky.setup({
	textobj = {
		enabled = true,
	},
})

vim.keymap.set({ "o", "x" }, "iy", function()
	require("yanky.textobj").last_put()
end, {})
