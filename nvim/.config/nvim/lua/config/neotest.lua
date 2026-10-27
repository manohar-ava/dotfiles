-- ================================================================================================
-- TITLE: Neotest (test runner)
-- ABOUT: adapters + setup for Jest/Vitest (React/Angular/JS/TS), Go, and Java/Spring
-- NOTES: lazy-loaded via the load_neotest() guard in config.plugins
--        nvim-nio is already present as a nvim-dap-ui dependency, so it is reused here.
-- ================================================================================================

local ok, neotest = pcall(require, "neotest")
if not ok then
	vim.notify("neotest unavailable", vim.log.levels.WARN)
	return { configured = false }
end

local adapters = {}

-- ----------------------------------------------------------------------------
-- JS / TS / React / Angular  (jest + vitest)
-- ----------------------------------------------------------------------------
-- Both adapters are callable tables; calling them returns the adapter with opts applied.
local ok_jest, neotest_jest = pcall(require, "neotest-jest")
if ok_jest then
	table.insert(
		adapters,
		neotest_jest({
			jestCommand = "npm test --",
			jestConfigFile = function()
				local cwd = vim.fn.getcwd()
				if vim.fn.filereadable(cwd .. "/jest.config.js") == 1 then
					return "jest.config.js"
				elseif vim.fn.filereadable(cwd .. "/jest.config.ts") == 1 then
					return "jest.config.ts"
				end
				return "jest.config.js"
			end,
			env = { CI = true },
			cwd = function()
				return vim.fn.getcwd()
			end,
		})
	)
end

local ok_vitest, neotest_vitest = pcall(require, "neotest-vitest")
if ok_vitest then
	table.insert(
		adapters,
		neotest_vitest({
			vitestCommand = "npx vitest",
			env = { CI = true },
			cwd = function()
				return vim.fn.getcwd()
			end,
		})
	)
end

-- ----------------------------------------------------------------------------
-- GO  (neotest-golang)
-- ----------------------------------------------------------------------------
-- tree-sitter-go is required (already in ensure_installed). gotestsum is the
-- recommended runner and is installed via mason. `dap_mode = "manual"` reuses
-- the delve adapter already configured in config.dap rather than nvim-dap-go.
local ok_go, neotest_golang = pcall(require, "neotest-golang")
if ok_go then
	table.insert(
		adapters,
		neotest_golang({
			runner = "gotestsum",
			dap_mode = "manual",
		})
	)
end

-- ----------------------------------------------------------------------------
-- JAVA / SPRING  (neotest-java)
-- ----------------------------------------------------------------------------
-- Talks to JDTLS over the standard vim.lsp.Client API, so the jdtls enabled in
-- config.plugins is sufficient -- nvim-jdtls is not required. Needs the java
-- tree-sitter parser (added to ensure_installed) and, after first setup, the
-- JUnit JAR via :NeotestJava setup or the plugin's JAR management.
local ok_java, neotest_java = pcall(require, "neotest-java")
if ok_java then
	table.insert(
		adapters,
		neotest_java({})
	)
end

-- ----------------------------------------------------------------------------
-- treesitter filetype -> lang registration for the parser subprocess
-- ----------------------------------------------------------------------------
-- neotest parses test files in a child nvim started with `-u NONE`, so that child
-- never loads nvim-treesitter's plugin/filetypes.lua -- the file that maps
-- `typescriptreact` -> `tsx` (and `javascriptreact` -> `javascript`). Without it
-- the child asks for a parser literally named "typescriptreact", fails with
-- "No parser for language", and discovery returns nothing for any .tsx file.
-- neotest already sources plugin/filetypes.lua after setting the child's rtp;
-- all that is missing is the nvim-treesitter root on that rtp. The parent is
-- unaffected -- it resolves get_lang() correctly on its own.
local ts_root
for _, path in ipairs(vim.api.nvim_get_runtime_file("plugin/filetypes.lua", true)) do
	if path:find("nvim%-treesitter", 1, false) then
		ts_root = vim.fs.dirname(vim.fs.dirname(path))
		break
	end
end

if ts_root then
	local ok_sub, subprocess = pcall(require, "neotest.lib.subprocess")
	if ok_sub and subprocess.add_paths_to_rtp then
		local add_paths = subprocess.add_paths_to_rtp
		subprocess.add_paths_to_rtp = function(paths)
			add_paths(vim.list_extend(vim.deepcopy(paths or {}), { ts_root }))
		end
	end
end

neotest.setup({
	adapters = adapters,
	-- discovery walks the whole project looking for tests; keep it on but bounded
	discovery = {
		enabled = true,
		concurrent = true,
		-- without this, discovery parses every file under node_modules / target /
		-- dist. That is slow and it makes adapters try their test queries against
		-- library code. Prune at the directory level so those trees are never
		-- entered.
		filter_dir = function(name, rel_path, root)
			local skip = {
				node_modules = true,
				dist = true,
				build = true,
				out = true,
				coverage = true,
				target = true, -- maven / rust
				vendor = true, -- go modules
				[".git"] = true,
				[".next"] = true,
				[".angular"] = true,
				[".venv"] = true,
				["__pycache__"] = true,
			}
			if skip[name] then
				return false
			end
			-- also skip dot-directories and build output dirs generically
			if name:sub(1, 1) == "." then
				return false
			end
			return true
		end,
	},
	running = {
		concurrent = true,
	},
	summary = {
		animated = true,
	},
	output = {
		open_on_run = true,
	},
})

return {
	configured = true,
	adapter_count = #adapters,
}
