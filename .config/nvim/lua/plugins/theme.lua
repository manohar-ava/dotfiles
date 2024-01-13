return {
	{
		"ellisonleao/gruvbox.nvim",
		-- name = "gruvbox",
		-- lazy = false,
		-- priority = 999,
		-- config = function()
		-- 	vim.cmd("colorscheme gruvbox")
		-- 	require("gruvbox").setup({})
		-- end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false,
		priority = 999,
		config = function()
			vim.cmd("colorscheme kanagawa")
			require("kanagawa").setup({})
		end,
	},
	{
		"rose-pine/neovim",
		-- name = "rose-pine",
		-- lazy = false,
		-- priority = 999,
		-- config = function()
		-- 	vim.cmd("colorscheme rose-pine")
		-- 	require("rose-pine").setup({})
		-- end,
	},
}
