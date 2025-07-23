local notify = require("mini.notify")

notify.setup({
	window = {
		blend = 10,
		winblend = 10,
	},
	timeout = 3000,
	auto_hide = true,
})

-- vim.notify = notify
