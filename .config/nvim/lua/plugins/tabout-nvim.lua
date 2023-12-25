return {
	"abecodes/tabout.nvim",
	lazy = false,
	config = function()
		require("tabout").setup({
			tabkey = "<Tab>",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = false,
			act_as_ctrl_tab = false,
			act_as_ctrl_shift_tab = false,
		})
	end,
}
