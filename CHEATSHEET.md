# Cheat Sheet

One-page lookup for the whole stack: **Neovim · tmux · AeroSpace · Ghostty**.

Leader is **Space** (both `mapleader` and `maplocalleader`). Mod key for the WM is **Alt** — never Super.

Theme is Kanagawa Wave everywhere. Font is Mononoki Nerd Font.

---

## Neovim

### Everyday

| Keys | Action |
|---|---|
| `<leader>w` | Save |
| `<leader>c` | Clear search highlights |
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>m` | Focus file explorer |
| `<leader>u` | Undo tree |
| `<leader>pa` | Copy full file path |
| `<leader>x` | Delete without yanking (normal + visual) |
| `<leader>p` | Paste over selection without yanking (visual) |
| `jj` | Exit insert mode |
| `J` | Join lines, cursor stays put |
| `K` | LSP hover |

### Yank ring (yanky.nvim)

Every yank/delete is remembered, so pasting no longer overwrites what you copied.

| Keys | Action |
|---|---|
| `p` / `P` | Put after / before (now from the ring) |
| `gp` / `gP` | Put after / before, cursor ends after the text |
| `<C-p>` / `<C-n>` | Cycle to previous / next older yank |

Cycle **immediately after** `p` — the ring resets once you move the cursor or edit.
History is stored in shada, so it survives across sessions (50 entries).

### Movement

| Keys | Action |
|---|---|
| `j` / `k` | Down / up (wrap-aware: `gj`/`gk`) |
| `w` / `e` / `b` / `ge` | **CamelCase-aware** word motions (nvim-spider) |
| `n` / `N` | Next / previous search match (centred) |
| `<C-d>` / `<C-u>` | Half page down / up (centred) |
| `<C-h/j/k/l>` | Move between windows — crosses tmux panes too |
| `<A-j>` / `<A-k>` | Move line (or selection) down / up |
| `<` / `>` | Indent, stays reselected |

`w`/`e`/`b`/`ge` step through subwords, so `getUserNameFromApi` is `get | User | Name | From | Api`
instead of one lump. Because they're normal-mode motions, `dw`, `cw`, `yw` all inherit the same behaviour.

### Windows & buffers

| Keys | Action |
|---|---|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<C-Up/Down/Left/Right>` | Resize window |
| `<leader>bn` / `<leader>bp` | Next / previous buffer |
| `<leader>1..4` | Jump to Harpoon file 1–4 |
| `<leader>a` | Harpoon — add file |
| `<leader>H` | Harpoon — menu |

### Find (fzf-lua)

| Keys | Action |
|---|---|
| `<leader>ff` | Files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fx` / `<leader>fX` | Diagnostics — document / workspace |

### Git (gitsigns)

| Keys | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` / `<leader>hB` | Blame line / toggle inline blame |
| `<leader>hd` | Diff this |

### Search & replace (grug-far)

| Keys | Action |
|---|---|
| `<leader>sr` | Search & replace — project |
| `<leader>sf` | Search & replace — current file |

### Toggles

| Keys | Action |
|---|---|
| `<leader>td` | Toggle diagnostics |
| `<leader>tf` | Toggle format-on-save |
| `<leader>z` | Zen mode |
| `<leader>xx` | Trouble — diagnostics list |
| `<leader>?` | which-key — buffer-local keymaps |

### LSP

Buffer-local, active after a server attaches.

| Keys | Action |
|---|---|
| `<leader>gd` | Go to definition (fzf picker) |
| `<leader>gD` | Go to definition (native) |
| `<leader>gS` | Go to definition in a vsplit |
| `<leader>fr` | References |
| `<leader>fi` | Implementations |
| `<leader>ft` | Type definitions |
| `<leader>fs` / `<leader>fw` | Symbols — document / workspace |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>oi` | Organise imports + format |
| `K` | Hover |
| `<leader>d` | Diagnostics at cursor |
| `<leader>D` / `<leader>dl` | Diagnostics for the line |
| `<leader>nd` / `<leader>pd` | Next / previous diagnostic |
| `<leader>q` | Diagnostic list (location list) |

### Debug (nvim-dap)

Lazy-loaded on first use.

| Keys | Action |
|---|---|
| `<leader>dc` | Continue / start |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | REPL |
| `<leader>dR` | Run last |
| `<leader>dh` | Hover value |
| `<leader>dp` | Preview |
| `<leader>du` | Toggle DAP UI |
| `<leader>dq` | Stop / quit debug session |

### Tests (neotest)

`<leader>T…` — capital T. Lazy-loaded on first use.

| Keys | Action |
|---|---|
| `<leader>Tr` | Run nearest test |
| `<leader>Tf` | Run current file |
| `<leader>Ta` | Run all tests |
| `<leader>Td` | Debug nearest test |
| `<leader>Tl` | Re-run last |
| `<leader>Ts` | Toggle summary |
| `<leader>To` | Show output |
| `<leader>TO` | Toggle output panel |
| `<leader>Tw` | Toggle watch (re-run on save) |
| `<leader>Tx` | Stop running tests |

### Completion (blink.cmp)

| Keys | Action |
|---|---|
| `<C-Space>` | Show / hide menu |
| `<CR>` | Accept |
| `<C-j>` / `<C-k>` | Next / previous item |
| `<Tab>` / `<S-Tab>` | Snippet forward / backward |

### Practice & challenges

| Keys | Action |
|---|---|
| `<leader>vg` | **Vim-Be-Good** — motion drills |
| `<leader>l` | **LeetCode** dashboard |

**Vim-Be-Good** — a menu of timed drills. Delete a line from the menu to pick a game,
then again to pick difficulty.

- **Games:** `words`, `ci{`, `relative`, `hjkl`, `whackamole`, `snake`, `random`
- **Difficulty:** `noob` → `easy` → `medium` → `hard` → `nightmare` → `tpope`
- `relative` and `ci{` are the two that transfer to real work.

**LeetCode** — `:Leet` opens the dashboard (uses fzf-lua as its picker). Useful subcommands:

| Command | What |
|---|---|
| `:Leet` | Dashboard |
| `:Leet daily` | Today's question |
| `:Leet list` | Browse problems |
| `:Leet random` | Random question |
| `:Leet run` / `:Leet test` | Run your solution |
| `:Leet submit` | Submit |
| `:Leet lang` | Change language |
| `:Leet console` | Open console |
| `:Leet restore` | Restore last attempt |

---

## tmux

Prefix is **`C-a`**.

| Keys | Action |
|---|---|
| `C-a C-a` | Send a literal `C-a` |
| `C-a \|` | Split horizontally |
| `C-a -` | Split vertically |
| `C-a c` | New window (keeps cwd) |
| `C-a r` | Reload config |
| `C-a h/j/k/l` | Resize pane (repeatable) |
| `C-a m` | Zoom pane |
| `C-a g` | LazyGit popup |
| `C-a w` | Session/window menu popup |
| `v` / `y` | Copy-mode: begin selection / copy |

`C-h/j/k/l` navigates between **vim splits and tmux panes** interchangeably.

---

## AeroSpace (macOS tiling WM)

**Alt** is the mod key.

### Windows

| Keys | Action |
|---|---|
| `Alt-h/j/k/l` | Focus left / down / up / right |
| `Alt-Shift-h/j/k/l` | Move window left / down / up / right |
| `Alt--` / `Alt-=` | Resize smaller / larger |
| `Alt-slash` | Toggle tiles layout |
| `Alt-comma` | Toggle accordion layout |

### Workspaces

| Keys | Action |
|---|---|
| `Alt-1..6` | Switch to workspace |
| `Alt-Shift-1..6` | Move window to workspace |
| `Alt-Tab` | Back and forth |
| `Alt-Shift-Tab` | Move workspace to next monitor |

### Apps & modes

| Keys | Action |
|---|---|
| `Alt-Enter` | Ghostty terminal |
| `Alt-b` | Google Chrome |
| `Alt-Shift-;` | Service mode |

In **service mode**: `Alt-Shift-h/j/k/l` joins the focused window with a neighbour.

---

## Language support

| Language | LSP | Lint | Format | Debug | Test |
|---|---|---|---|---|---|
| TypeScript / React / Angular | `ts_ls`, `angularls` | `eslint_d` | `prettier_d` | js-debug-adapter | vitest / jest |
| JavaScript | `ts_ls` | `eslint_d` | `prettier_d` | js-debug-adapter | vitest / jest |
| HTML / CSS | — | — | `prettier_d` | js-debug-adapter | — |
| Java / Spring | `jdtls` | — | — | java-debug-adapter | JUnit 5 |
| Go | `gopls` | `revive` | `gofumpt` | delve | gotestsum |
| Lua | `lua_ls` | `luacheck` | `stylua` | — | — |
| Python | `pyright` | `flake8` | `black` | — | — |
| C / C++ | `clangd` | `cpplint` | `clang-format` | — | — |
| Bash | `bashls` | `shellcheck` | `shfmt` | — | — |
| JSON | — | `eslint_d` | `fixjson` | — | — |
| Markdown / Vue / Svelte | — | `eslint_d` | `prettier_d` | — | — |

Everything in the Lint / Format columns is wired through **efm**; format-on-save runs efm only.
All binaries are installed automatically by mason at startup (see `lua/config/mason_tools.lua`).

### Treesitter parsers

`vim` `vimdoc` `rust` `c` `cpp` `go` `html` `css` `javascript` `json` `lua` `markdown` `python` `typescript` `tsx` `java` `vue` `svelte` `bash`

---

## Plugins

Managed natively by `vim.pack` (Neovim 0.12) — no plugin manager. Lockfile: `nvim-pack-lock.json`.

| Plugin | For |
|---|---|
| gitsigns.nvim | Git signs, hunks, blame |
| mini.nvim | ai, comment, surround, cursorword, indentscope, pairs, trailspace, bufremove |
| fzf-lua | Fuzzy pickers |
| nvim-tree.lua | File explorer |
| kanagawa.nvim | Theme |
| nvim-treesitter (main) | Syntax, folding, test parsing |
| nvim-lspconfig | LSP configs |
| mason.nvim | Tool installer |
| efmls-configs-nvim | Lint/format presets for efm |
| blink.cmp | Completion |
| LuaSnip | Snippet expansion for blink |
| which-key.nvim | Keymap hints |
| vim-tmux-navigator | Seamless vim ↔ tmux nav |
| trouble.nvim | Diagnostics list |
| nvim-dap + nvim-dap-ui + nvim-nio | Debugging |
| neotest + jest / vitest / golang / java adapters | Tests |
| zen-mode.nvim | Distraction-free |
| grug-far.nvim | Project search & replace |
| lualine.nvim | Statusline |
| nvim-web-devicons | Icons |
| noice.nvim | LSP hover / signature / progress UI |
| nui.nvim | UI primitives (noice dependency) |
| smear-cursor.nvim | Smooth cursor motion |
| harpoon (harpoon2) | Fast file marks |
| hardtime.nvim | Hints for redundant motions |
| undotree | Undo history |
| nvim-spider | CamelCase-aware word motions |
| yanky.nvim | Yank ring + better paste |
| vim-be-good | Motion drills (lazy) |
| leetcode.nvim | Coding challenges (lazy) |
| plenary.nvim | Utility library (dependency) |

---

## Gotchas

- **`w`/`e`/`b` are not vanilla.** They're camelCase-aware (nvim-spider). If you ever want a plain word jump, use `W`/`E`/`B` — those are untouched.
- **Yank cycling is immediate-only.** `<C-p>`/`<C-n>` work right after `p`. Move the cursor or type anything and the ring resets to the top. This is by design, not a bug.
- **`<C-p>` is now yank-cycling, not "previous in list".** hardtime used to hint on it; that restriction was removed for this reason.
- **`<leader>d` is overloaded.** On its own it opens diagnostics at the cursor; `<leader>d` + `b/c/i/o…` are the debug keys. which-key labels the prefix "Debug", which is slightly misleading. If it ever feels ambiguous, wait for the popup or use `<leader>dl` for line diagnostics.
- **`<leader>td` vs `<leader>Td`** — lowercase toggles diagnostics, capital D debugs a test.
- **Format-on-save uses efm only.** If a file isn't formatted on save, efm has no formatter listed for that filetype (Java has none).
- **Node 14 breaks JS tooling.** vitest, `ts_ls`, `eslint_d` and js-debug-adapter all need Node 15+. Check `node --version` before debugging a JS "it just doesn't run" problem.
- **Java tests need a one-time setup**: `:NeotestJava setup` downloads the JUnit console JAR into `~/.local/share/nvim/neotest-java/`. Without it, runs start and never report.
- **Java debugging needs jdtls attached.** `java-debug-adapter` is an OSGi plugin jdtls loads, not a standalone server. Open a Java file and wait for jdtls to attach before `<leader>dc`.
- **AeroSpace uses Alt, not Super.** This is deliberate — don't reintroduce Super bindings.
- **flash.nvim was deliberately not installed.** Its `s`/`S` label-jump collides with mini.surround's `sa`/`sd`/`sr`/`sf`/`sh` prefix. Swapping surround to tpope-style `ys`/`ds`/`cs` would free `s` — say the word if you want that trade.

---

## Reload / restart

| Config | Command |
|---|---|
| Neovim | `:source $MYVIMRC` or just restart |
| AeroSpace | `aerospace reload-config` |
| SketchyBar | `sketchybar --reload` |
| Borders | restart the borders process |
| tmux | `tmux source-file ~/.config/tmux/tmux.conf` |

---

## Deploy

Config dirs are symlinked into `$XDG_CONFIG_HOME` with **GNU Stow** (v2.4.1) from the repo root.
Each package dir mirrors the target path under `~`, so `nvim/.config/nvim` lands at `~/.config/nvim`.

Currently stowed:

```bash
stow nvim tmux zsh ghostty
```

Packages present but **not** stowed: `aerospace`, `borders`, `alacritty`, `i3`, `i3status`, `picom`, `ubuntu-tweaks`.
(Legacy Ubuntu packages and the macOS WM configs still need wiring.)

Two dangling links in `~/.config` point at packages that were removed from the repo — safe to delete:

```bash
rm ~/.config/.DS_Store ~/.config/tmuxinator   # both resolve into deleted dotfiles paths
```
