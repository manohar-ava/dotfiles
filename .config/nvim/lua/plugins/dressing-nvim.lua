return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			input = {
				enabled = true,
				insert_only = false,
				win_options = {
					winblend = 10,
				},
			},
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "builtin" },
			},
		})
	end,
}
