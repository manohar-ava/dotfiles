vim.opt.termguicolors = true

local function set_transparent() -- set UI component to transparent
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
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

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
