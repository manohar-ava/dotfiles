return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2 -- Diff panel on the right
		vim.g.undotree_SetFocusWhenToggle = 1 -- Focus the window when opened
		vim.g.undotree_ShortIndicators = 1 -- Short branch indicators
		vim.g.undotree_DiffpanelHeight = 10
		vim.g.undotree_SplitWidth = 30
	end,
}
