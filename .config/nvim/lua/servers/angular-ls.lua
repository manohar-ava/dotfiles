-- ================================================================================================
-- TITLE : angularls (Angular Language Server) LSP Setup
-- LINKS :
--   > npm: https://www.npmjs.com/package/@angular/language-server
--   > github: https://github.com/angular/vscode-ng-language-service
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("angularls", { -- Note: The server name is typically 'angularls' in lspconfig
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"html", -- For template files
			"json", -- For tsconfig/package.json/angular.json
		},
		-- The Angular Language Server can have additional settings.
		-- You might need to adjust the 'cmd' if your server is installed globally or via a package manager like Mason.
		-- For a local project install of @angular/language-server, you might not need to set 'cmd' explicitly
		-- if 'lspconfig' can find it, but it's often needed for Neovim.
		-- The settings below are common, but check the server's documentation for all options.
		settings = {
			angular = {
				-- Common setting to enable diagnostic checks in templates
				suggestOnNavigate = false,
				enableTildePathCompletions = true,
			},
			typescript = {
				indentStyle = "space",
				indentSize = 2,
			},
		},
	})
end
