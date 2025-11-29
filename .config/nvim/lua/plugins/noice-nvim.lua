return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify", -- optional notification backend
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true, -- enables command-line UI
				view = "cmdline_popup", -- popup style
			},
			messages = {
				enabled = true, -- enables messages UI
				view = "mini", -- compact style
			},
			lsp = {
				progress = { enabled = true },
				hover = { enabled = true },
				signature = { enabled = true },
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		})

		-- Optional: use nvim-notify as notification manager
		vim.notify = require("notify")
	end,
}
