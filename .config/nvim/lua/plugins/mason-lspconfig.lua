local opts = {
	ensure_installed = {
		"efm",
		"bashls",
		"tsserver",
		"lua_ls",
		"emmet_ls",
		"jsonls",
		"clangd",
		"zls",
		"rust_analyzer",
		"ols",
	},

	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
