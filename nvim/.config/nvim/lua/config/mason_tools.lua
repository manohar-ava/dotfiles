-- ================================================================================================
-- TITLE: Mason auto-install
-- ABOUT: ensures language servers, debug adapters, and efm lint/format tools are present at startup
-- NOTES: installs only what is missing, asynchronously, so it never blocks editor startup
-- ================================================================================================

local registry_ok, registry = pcall(require, "mason-registry")

if not registry_ok then
	vim.notify("mason-registry unavailable; skipping auto-install", vim.log.levels.WARN)
	return {}
end

-- Mason package names, grouped by role. These map to the servers enabled in
-- config.plugins and the adapters configured in config.dap. Binaries land in
-- stdpath('data')/mason/bin, which mason prepends to PATH.
local packages = {
	-- ---- language servers (vim.lsp.enable list) ----
	"lua-language-server", -- lua_ls
	"pyright", -- pyright
	"bash-language-server", -- bashls
	"typescript-language-server", -- ts_ls
	"gopls", -- gopls
	"clangd", -- clangd
	"angular-language-server", -- angularls
	"jdtls", -- jdtls (java / spring)
	"efm", -- efm (lint/format bridge)

	-- ---- debug adapters (config.dap) ----
	"js-debug-adapter", -- JS/TS/React/Angular + browser
	"java-debug-adapter", -- Java / Spring
	"delve", -- Go

	-- ---- test runners (config.neotest) ----
	"gotestsum", -- Go test runner (neotest-golang)

	-- ---- efm lint/format tools ----
	"stylua", -- lua formatter
	"luacheck", -- lua linter
	"black", -- python formatter
	"flake8", -- python linter
	"prettierd", -- web formatter (prettier_d)
	"eslint_d", -- web linter
	"fixjson", -- json formatter
	"shellcheck", -- sh linter
	"shfmt", -- sh formatter
	"clang-format", -- c/cpp formatter (clang_format)
	"cpplint", -- c/cpp linter
	"revive", -- go linter (go_revive)
	"gofumpt", -- go formatter
}

local function install_if_missing(pkg_name)
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if not ok or not pkg then
		vim.notify("mason: unknown package '" .. pkg_name .. "'", vim.log.levels.WARN)
		return
	end
	if not pkg:is_installed() then
		pkg:install()
	end
end

local function install_all()
	for _, pkg_name in ipairs(packages) do
		install_if_missing(pkg_name)
	end
end

-- registry.refresh is async; the callback runs once the registry is ready.
-- install() itself is async too, so nothing here blocks the UI.
if registry.refresh then
	registry.refresh(install_all)
else
	install_all()
end

return packages
