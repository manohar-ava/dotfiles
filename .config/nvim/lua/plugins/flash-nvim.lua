return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		label = { style = "overlay", uppercase = true },
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash: jump anywhere",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash: treesitter jump",
		},
		{
			"r",
			mode = { "o" },
			function()
				require("flash").remote()
			end,
			desc = "Flash: remote jump",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Flash: treesitter search",
		},
		-- add more if you like, e.g. toggle search with ctrl‑s:
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Flash: toggle search",
		},
	},
}
