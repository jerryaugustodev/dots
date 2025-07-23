local pairs = require("mini.pairs")

pairs.setup({
	mappings = {
		["<"] = { action = "closeopen", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },
	},
})
