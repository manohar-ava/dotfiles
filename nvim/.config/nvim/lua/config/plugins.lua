-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/rebelot/kanagawa.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- Language Server Protocols
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/folke/zen-mode.nvim",
	"https://github.com/MagicDuck/grug-far.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		branch = "harpoon2",
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/m4xshen/hardtime.nvim",
	"https://github.com/jiaoshijie/undotree",
	-- Test runners (lazy-loaded via load_neotest(); see config.neotest)
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/neotest-jest",
	"https://github.com/marilari88/neotest-vitest",
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/rcasia/neotest-java",
	-- Motion drills + challenges (lazy: only loaded on keypress)
	"https://github.com/ThePrimeagen/vim-be-good",
	"https://github.com/kawre/leetcode.nvim",
	-- Text editing quality
	"https://github.com/chrisgrieser/nvim-spider",
	"https://github.com/gbprod/yanky.nvim",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end

packadd("nvim-web-devicons")
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("nvim-tree.lua")
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")
packadd("which-key.nvim")
packadd("vim-tmux-navigator")
packadd("lualine.nvim")
packadd("smear-cursor.nvim")
packadd("plenary.nvim")
packadd("harpoon")
packadd("hardtime.nvim")
packadd("nui.nvim")
packadd("noice.nvim")
packadd("undotree")
packadd("nvim-spider")
packadd("yanky.nvim")
-- vim-be-good and leetcode.nvim are intentionally NOT packadd'd here. They load
-- on first keypress: <leader>vg packadds vim-be-good inline, <leader>l runs
-- load_leetcode() below.

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"go",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"tsx",
		"java",
		"vue",
		"svelte",
		"bash",
	}

	-- install() already skips parsers that are present, so no manual diffing.
	treesitter.install(ensure_installed)

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

require("nvim-tree").setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
	renderer = {
		group_empty = true,
	},
	update_focused_file = {
		enable = true,
		update_root = false,
	},
})

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▐
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ▐
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

require("mason").setup({})
require("config.mason_tools")

vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

--which key
local wk = require("which-key")

wk.setup({})

-- Named groups so <leader> reads as a menu instead of a flat list.
wk.add({
	{ "<leader>1", group = "Harpoon file 1" },
	{ "<leader>2", group = "Harpoon file 2" },
	{ "<leader>3", group = "Harpoon file 3" },
	{ "<leader>4", group = "Harpoon file 4" },
	{ "<leader>a", group = "Harpoon" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>c", group = "Clear search" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>e", group = "Explorer" },
	{ "<leader>f", group = "Find (fzf)" },
	{ "<leader>g", group = "Goto / LSP" },
	{ "<leader>h", group = "Git hunks" },
	{ "<leader>H", group = "Harpoon menu" },
	{ "<leader>m", group = "Focus explorer" },
	{ "<leader>p", group = "Path / copy" },
	{ "<leader>q", group = "Diagnostics" },
	{ "<leader>s", group = "Splits / search" },
	{ "<leader>t", group = "Toggles" },
	{ "<leader>T", group = "Test" },
	{ "<leader>u", group = "Undo tree" },
	{ "<leader>l", group = "LeetCode" },
	{ "<leader>v", group = "Practice" },
	{ "<leader>w", group = "Save" },
	{ "<leader>x", group = "Delete / Trouble" },
	{ "<leader>z", group = "Zen mode" },
	{ "<leader>?", group = "Buffer keymaps" },
	{ "<leader>h", group = "Git hunks", mode = "x" },
	{ "<leader>p", group = "Paste", mode = "x" },
	{ "<leader>x", group = "Delete", mode = "x" },
})

vim.keymap.set("n", "<leader>?", function()
	wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

--trouble
local trouble_loaded = false
local function load_trouble()
	if not trouble_loaded then
		require("trouble").setup({})
		trouble_loaded = true
	end
end
vim.keymap.set("n", "<leader>xx", function()
	load_trouble()
	vim.cmd("Trouble diagnostics toggle")
end, { desc = "Toggle Trouble diagnostics" })

--dap-ui
local dap_loaded = false
local function load_dap()
	if dap_loaded then
		return
	end

	-- adapters, configs, UI, and signs live in config.dap
	require("config.dap")
	dap_loaded = true
end

local function dap_cmd(fn)
	return function()
		load_dap()
		fn()
	end
end

vim.keymap.set("n", "<leader>du", dap_cmd(function()
	require("dapui").toggle()
end), { desc = "Toggle DAP UI" })

vim.keymap.set("n", "<leader>db", dap_cmd(function()
	require("dap").toggle_breakpoint()
end), { desc = "Toggle breakpoint" })

vim.keymap.set("n", "<leader>dB", dap_cmd(function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end), { desc = "Conditional breakpoint" })

vim.keymap.set("n", "<leader>dc", dap_cmd(function()
	require("dap").continue()
end), { desc = "Debug continue / start" })

vim.keymap.set("n", "<leader>di", dap_cmd(function()
	require("dap").step_into()
end), { desc = "Debug step into" })

vim.keymap.set("n", "<leader>do", dap_cmd(function()
	require("dap").step_over()
end), { desc = "Debug step over" })

vim.keymap.set("n", "<leader>dO", dap_cmd(function()
	require("dap").step_out()
end), { desc = "Debug step out" })

vim.keymap.set("n", "<leader>dr", dap_cmd(function()
	require("dap").repl.open()
end), { desc = "Debug REPL" })

vim.keymap.set("n", "<leader>dR", dap_cmd(function()
	require("dap").run_last()
end), { desc = "Debug run last" })

vim.keymap.set("n", "<leader>dq", dap_cmd(function()
	require("dap").terminate()
	require("dapui").close()
end), { desc = "Debug stop / quit" })

vim.keymap.set("n", "<leader>dh", dap_cmd(function()
	require("dap.ui.widgets").hover()
end), { desc = "Debug hover value" })

vim.keymap.set("n", "<leader>dp", dap_cmd(function()
	require("dap.ui.widgets").preview()
end), { desc = "Debug preview" })

--neotest
local neotest_loaded = false
local function load_neotest()
	if neotest_loaded then
		return
	end

	-- adapters, setup, and UI live in config.neotest
	require("config.neotest")
	neotest_loaded = true
end

local function test_cmd(fn)
	return function()
		load_neotest()
		fn()
	end
end

vim.keymap.set("n", "<leader>Tr", test_cmd(function()
	require("neotest").run.run()
end), { desc = "Run nearest test" })

vim.keymap.set("n", "<leader>Tf", test_cmd(function()
	require("neotest").run.run(vim.fn.expand("%"))
end), { desc = "Run current file" })

vim.keymap.set("n", "<leader>Ta", test_cmd(function()
	require("neotest").run.run(vim.fn.getcwd())
end), { desc = "Run all tests" })

vim.keymap.set("n", "<leader>Td", test_cmd(function()
	require("neotest").run.run({ strategy = "dap" })
end), { desc = "Debug nearest test" })

vim.keymap.set("n", "<leader>Tl", test_cmd(function()
	require("neotest").run.run_last()
end), { desc = "Re-run last test" })

vim.keymap.set("n", "<leader>Ts", test_cmd(function()
	require("neotest").summary.toggle()
end), { desc = "Toggle test summary" })

vim.keymap.set("n", "<leader>To", test_cmd(function()
	require("neotest").output.open({ enter = true })
end), { desc = "Show test output" })

vim.keymap.set("n", "<leader>TO", test_cmd(function()
	require("neotest").output_panel.toggle()
end), { desc = "Toggle output panel" })

vim.keymap.set("n", "<leader>Tw", test_cmd(function()
	require("neotest").watch.toggle(vim.fn.expand("%"))
end), { desc = "Toggle test watch" })

vim.keymap.set("n", "<leader>Tx", test_cmd(function()
	require("neotest").run.stop()
end), { desc = "Stop running tests" })

-- ----------------------------------------------------------------------------
-- vim-be-good: motion drills (lazy)
-- ----------------------------------------------------------------------------
-- Games: words, ci{, relative, hjkl, whackamole, snake, random.
-- Difficulty ramps noob -> easy -> medium -> hard -> nightmare -> tpope.
-- You delete a line from the menu buffer to pick a game, then again to pick
-- difficulty. Kept lazy -- it is a training toy, not something at startup.
vim.keymap.set("n", "<leader>vg", function()
	vim.cmd("packadd vim-be-good")
	vim.cmd("VimBeGood")
end, { desc = "Vim-Be-Good (motion drills)" })

-- ----------------------------------------------------------------------------
-- leetcode.nvim: coding challenges (lazy)
-- ----------------------------------------------------------------------------
-- Uses fzf-lua as its picker (first in leetcode's provider_order that you
-- have installed). plenary + nui are already present as other plugins' deps,
-- and html treesitter is in ensure_installed for question formatting.
local leetcode_loaded = false
local function load_leetcode()
	if leetcode_loaded then
		return
	end
	vim.cmd("packadd leetcode.nvim")
	require("leetcode").setup({
		-- fzf-lua is auto-detected; lang is set for you but you can change it
		-- from the dashboard.
	})
	leetcode_loaded = true
end

vim.keymap.set("n", "<leader>l", function()
	load_leetcode()
	vim.cmd("Leet")
end, { desc = "LeetCode dashboard" })

--zenmode
local zen_loaded = false
local function load_zen()
	if zen_loaded then
		return
	end

	require("zen-mode").setup({
		window = {
			width = 90,
		},
	})

	zen_loaded = true
end

vim.keymap.set("n", "<leader>z", function()
	load_zen()
	require("zen-mode").toggle()
end, { desc = "Zen Mode" })

--grug-far
local grug_loaded = false
local function load_grug()
	if grug_loaded then
		return
	end

	require("grug-far").setup({})
	grug_loaded = true
end

vim.keymap.set("n", "<leader>sr", function()
	load_grug()
	require("grug-far").open()
end, { desc = "Search & Replace (Project)" })

vim.keymap.set("n", "<leader>sf", function()
	load_grug()
	require("grug-far").open({
		scope = "current",
	})
end, { desc = "Search & Replace (File)" })

-- ----------------------------------------------------------------------------
-- Text editing quality
-- ----------------------------------------------------------------------------
-- nvim-spider: camelCase-aware w/e/b/ge. Plain `w` treats `getUserName` as one
-- word; spider steps through get | User | Name. Only the motions are rebound --
-- `cw`/`dw`/`yw` and friends all inherit them for free via operator-pending.
for key, fn in pairs({
	w = function() require("spider").motion("w") end,
	e = function() require("spider").motion("e") end,
	b = function() require("spider").motion("b") end,
}) do
	vim.keymap.set({ "n", "o", "x" }, key, fn, { desc = "Spider: camelCase-aware " .. key })
end
-- Direction comes from the KEY argument ("w"/"e" forward, "b"/"ge" back), not
-- from an opts table -- spider has no `backward` field, so passing one is
-- silently ignored and `ge` would just duplicate `e`.
vim.keymap.set({ "n", "o", "x" }, "ge", function()
	require("spider").motion("ge")
end, { desc = "Spider: camelCase-aware ge" })

-- yanky.nvim: yank ring. Every delete/yank is remembered, so `p` then <C-p>
-- cycles back through older yanks instead of overwriting the register.
-- Also re-yanks with the correct indent when pasting over a selection.
require("yanky").setup({
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 150,
	},
	ring = {
		history_length = 50,
		storage = "shada", -- survives across sessions
		sync_with_numbered_registers = true,
	},
	preserve_cursor_position = {
		enabled = true,
	},
})

-- p / P keep their meaning but now pull from the ring.
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after (yank ring)" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before (yank ring)" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put after, cursor after" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put before, cursor after" })
-- Cycle the ring. These two are why hardtime no longer restricts <C-n>/<C-p>.
vim.keymap.set("n", "<C-p>", "<Plug>(YankyPreviousEntry)", { desc = "Previous yank in ring" })
vim.keymap.set("n", "<C-n>", "<Plug>(YankyNextEntry)", { desc = "Next yank in ring" })
-- <leader>p in visual already does "replace without clobbering the register";
-- yanky makes that redundant, so it is left as-is (still works) but is no longer
-- the recommended way -- just use `p`.

--lualine
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
	},
})

--noice
require("noice").setup({
	cmdline = {
		enabled = false,
	},
	messages = {
		enabled = false,
	},
	lsp = {
		progress = { enabled = true },
		hover = { enabled = true },
		signature = { enabled = true },
	},
})

----smear_cursor
require("smear_cursor").setup({})

--harpoon
local harpoon = require("harpoon")
harpoon.setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon Add File" })
vim.keymap.set("n", "<leader>H", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon File 1" })
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon File 2" })
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon File 3" })
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon File 4" })

--hardtime
-- Retuned: the hjkl family is intentional nav here (see CLAUDE.md "hjkl-centric",
-- and keymaps.lua maps j/k to wrap-aware gj/gk), so restricting it only produced
-- constant hints. Kept it on for genuinely-redundant motions instead.
require("hardtime").setup({
	enabled = true,
	disable_mouse = false,
	hint = true,
	restriction_mode = "hint", -- shows hint instead of blocking
	restricted_keys = {
		-- hjkl + wrapped variants are intentional nav here (CLAUDE.md "hjkl-centric",
		-- and keymaps.lua maps j/k to gj/gk). hardtime deep-merges with its defaults,
		-- so these must be set false explicitly to stop the constant hints.
		["h"] = false,
		["j"] = false,
		["k"] = false,
		["l"] = false,
		["gj"] = false,
		["gk"] = false,
		-- kept restricted: genuinely-redundant motions
		["-"] = { "n", "x" },
		["+"] = { "n", "x" },
		["<CR>"] = { "n", "x" },
		["<C-M>"] = { "n", "x" },
		-- <C-N>/<C-P> used to be here. yanky.nvim now binds them to yank-ring
		-- cycling, so they are load-bearing rather than redundant.
	},
})

--================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
	callback = lsp_on_attach,
})

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { menu = { auto_show = true } },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("angularls", {
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		"",
		"--ngProbeLocations",
		"",
	},
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
	root_markers = { "angular.json", "project.json" },
})
-- jdtls (java / spring): lspconfig's lsp/jdtls.lua already handles the tricky
-- per-project `-data` workspace dir via its cmd factory, so no custom cmd needed.
-- Extra JVM args (e.g. lombok) can be passed via the JDTLS_JVM_ARGS env var.
--
-- `bundles` is what makes Java debugging work: java-debug-adapter is not a
-- standalone server binary, it is an OSGi plugin that jdtls loads here. Once it
-- is loaded, jdtls answers `vscode.java.startDebugSession` and hands nvim-dap a
-- real TCP port (see config/dap.lua).
do
	local java_debug_jars = vim.fn.glob(
		vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/*.jar",
		false,
		true
	)
	vim.lsp.config("jdtls", {
		init_options = {
			bundles = java_debug_jars,
		},
	})
end
do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local cpplint = require("efmls-configs.linters.cpplint")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local go_revive = require("efmls-configs.linters.go_revive")
	local gofumpt = require("efmls-configs.formatters.gofumpt")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				c = { clangfmt, cpplint },
				go = { gofumpt, go_revive },
				cpp = { clangfmt, cpplint },
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
			},
		},
	})
end

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"clangd",
	"efm",
	"angularls",
	"jdtls",
})
