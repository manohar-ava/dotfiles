return {
	"MagicDuck/grug-far.nvim",
	keys = {
		-- Project
		{ "<leader>sp", "<cmd>GrugFar<cr>", desc = "Search/Replace in Project" },

		-- Current file
		{
			"<leader>sf",
			function()
				require("grug-far").open({
					prefills = { paths = vim.fn.expand("%") },
				})
			end,
			desc = "Search/Replace in File",
		},

		-- Visual selection
		{ "<leader>ss", "<cmd>GrugFarWithin<cr>", mode = "x", desc = "Search/Replace in Selection" },
	},
}
