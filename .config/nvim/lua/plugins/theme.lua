return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 999,
	config = function()
		vim.cmd("colorscheme kanagawa")
		require("kanagawa").setup({})
	end,
}