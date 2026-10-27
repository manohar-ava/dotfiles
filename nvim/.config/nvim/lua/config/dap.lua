-- ================================================================================================
-- TITLE: DAP (Debug Adapter Protocol)
-- ABOUT: adapters + launch configs for Go, JS/TS/React/Angular, HTML/CSS, and Java/Spring
-- NOTES: lazy-loaded via the load_dap() guard in config.plugins
-- ================================================================================================

local dap = require("dap")
local dapui = require("dapui")

-- ----------------------------------------------------------------------------
-- Mason-managed debug adapters
-- ----------------------------------------------------------------------------
-- Installation is handled centrally in config.mason_tools (js-debug-adapter,
-- java-debug-adapter, delve). Here we only reference mason's bin dir.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

-- ----------------------------------------------------------------------------
-- UI + auto-open/close
-- ----------------------------------------------------------------------------
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- ----------------------------------------------------------------------------
-- Signs
-- ----------------------------------------------------------------------------
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint", linehl = "", numhl = "" })

-- ----------------------------------------------------------------------------
-- GO  (delve)
-- ----------------------------------------------------------------------------
dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_bin .. "/dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug file",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test (file)",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test (package)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
	{
		type = "delve",
		name = "Debug package",
		request = "launch",
		program = "./${relativeFileDirname}",
	},
	{
		type = "delve",
		name = "Attach to process",
		request = "attach",
		mode = "local",
		processId = require("dap.utils").pick_process,
	},
}

-- ----------------------------------------------------------------------------
-- JS / TS / React / Angular / HTML / CSS  (vscode-js-debug)
-- ----------------------------------------------------------------------------
-- One adapter server backs all pwa-* launch types. HTML/CSS debugging happens
-- through the browser (pwa-chrome), which is what these frontends need.
local js_debug = mason_bin .. "/js-debug-adapter"

if vim.fn.executable("node") == 1 and vim.fn.filereadable(js_debug) == 1 then
	for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }) do
		dap.adapters[adapter] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}
	end
end

local function js_configs(host)
	return {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file (Node)",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch via package.json (Node)",
			cwd = "${workspaceFolder}",
			runtimeArgs = { "--inspect-brk" },
			runtimeExecutable = "npm",
			args = { "run", "start" },
			resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome (" .. host .. ")",
			url = "http://" .. host,
			webRoot = "${workspaceFolder}",
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-msedge",
			request = "launch",
			name = "Launch Edge (" .. host .. ")",
			url = "http://" .. host,
			webRoot = "${workspaceFolder}",
			sourceMaps = true,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest tests",
			runtimeExecutable = "node",
			runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest tests",
			runtimeExecutable = "node",
			runtimeArgs = { "./node_modules/vitest/vitest.mjs", "--run" },
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end

for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[lang] = js_configs("localhost:3000")
end

dap.configurations.html = js_configs("localhost:3000")
dap.configurations.css = js_configs("localhost:3000")

-- ----------------------------------------------------------------------------
-- JAVA / SPRING  (java-debug-adapter, loaded as a jdtls bundle)
-- ----------------------------------------------------------------------------
-- java-debug-adapter ships only an OSGi jar -- there is no executable in
-- mason/bin for it, so this adapter cannot spawn anything. jdtls loads the jar
-- via `init_options.bundles` (see config/plugins.lua) and then acts as the DAP
-- server: `vscode.java.startDebugSession` returns a TCP port to hand to nvim-dap.
--
-- Requirements: jdtls must be attached to the buffer (it is in vim.lsp.enable),
-- and the java-debug jar must be present (mason auto-installs it).
dap.adapters.java = function(callback)
	local client = vim.lsp.get_clients({ name = "jdtls", bufnr = 0 })[1]
	if not client then
		vim.notify("Java debugging needs jdtls attached to this buffer", vim.log.levels.ERROR)
		return
	end
	client:exec_cmd({ command = "vscode.java.startDebugSession" }, {}, function(err, port)
		if err or type(port) ~= "number" then
			vim.notify(
				"Could not start Java debug session: " .. tostring(err or port),
				vim.log.levels.ERROR
			)
			return
		end
		callback({ type = "server", host = "127.0.0.1", port = port })
	end)
end

-- NOTE: nvim-dap core only expands ${file}/${workspaceFolder}/${env:...}. The
-- vscode-style `${input:...}` placeholder is NOT supported outside launch.json,
-- so values that must be typed are functions -- nvim-dap calls them at launch.
local function ask(prompt, default)
	return function()
		local v = vim.fn.input(prompt, default or "")
		if v == "" then
			return nil
		end
		return v
	end
end

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Launch current file",
		-- java-debug infers the main class from the active file. Deliberately no
		-- `program` field -- that is the pwa-* convention and is ignored here.
	},
	{
		type = "java",
		request = "launch",
		name = "Launch class (mainClass)",
		mainClass = ask("mainClass: "),
		projectName = ask("projectName (blank = auto): "),
	},
	{
		type = "java",
		request = "attach",
		name = "Attach to remote JVM",
		hostName = ask("host: ", "127.0.0.1"),
		port = function()
			return tonumber(vim.fn.input("port: ", "5005")) or 5005
		end,
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Spring Boot",
		mainClass = ask("mainClass: ", "your.Application"),
		projectName = ask("projectName (blank = auto): "),
		args = ask("args: ", "--spring.profiles.active=dev"),
	},
}

return {
	configured = true,
}
