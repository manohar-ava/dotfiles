vim.opt.termguicolors = true

-- Custom highlights must run on ColorScheme: `:colorscheme` clears and
-- re-applies groups, so anything set before it is wiped.
local function set_custom_highlights()
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
		"NvimTreeNormal",
		"NvimTreeNormalNC",
		"NvimTreeSignColumn",
		"NvimTreeEndOfBuffer",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
	vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true }),
	callback = set_custom_highlights,
})

vim.cmd("packadd kanagawa.nvim")

require("kanagawa").setup({
	theme = "wave",
	transparent = true,
	background = {
		dark = "wave",
		light = "lotus",
	},
})

vim.cmd("colorscheme kanagawa-wave")
