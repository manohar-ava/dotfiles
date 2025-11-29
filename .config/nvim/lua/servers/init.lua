local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.gopls")(capabilities)
require("servers.json-ls")(capabilities)
require("servers.ts-ls")(capabilities)
require("servers.bash-ls")(capabilities)
require("servers.clangd")(capabilities)
require("servers.docker-ls")(capabilities)
require("servers.emmet-ls")(capabilities)
require("servers.yaml-ls")(capabilities)
require("servers.tailwindcss")(capabilities)

-- Linters & Formatters
require("servers.emf-ls")(capabilities)

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"gopls",
	"jsonls",
	"ts_ls",
	"bashls",
	"clangd",
	"dockerls",
	"emmet_ls",
	"yamlls",
	"tailwindcss",
	"solidity_ls_nomicfoundation",
	"efm",
})
