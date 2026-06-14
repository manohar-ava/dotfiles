# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repo, migrating from Ubuntu (i3/picom) to macOS tiling WM stack: **AeroSpace** + **SketchyBar** + **JankyBorders**. Each top-level directory mirrors the XDG `~/.config/` structure — symlink into `$XDG_CONFIG_HOME` to deploy.

## Design Language

- **Theme**: Kanagawa Wave everywhere (Ghostty, tmux-ukiyo, VSCode, borders)
- **Font**: Mononoki Nerd Font
- **Mod key**: `Alt` (AeroSpace), `Mod4/Super` was used on i3 — do not reintroduce Super
- **Navigation**: hjkl-centric across all tools (vim, tmux, AeroSpace)
- **Shell**: zsh with powerlevel10k, vi-mode, manual plugin loader (no oh-my-zsh)

## Config Architecture

```
aerospace/.aerospace.toml     # Tiling WM — starts sketchybar + borders on launch
sketchybar/.config/sketchybar/ # Status bar (EMPTY — needs creation)
borders/.config/borders/bordersrc  # Window border highlights
ghostty/.config/ghostty/config     # Primary terminal on macOS
tmux/.config/tmux/tmux.conf        # Prefix C-a, vim splits, kanagawa theme
nvim/.config/nvim/                 # Lazy.nvim, modular lua/config/ structure
zsh/.config/zsh/                   # .zshrc sources aliasrc, optionrc, pluginrc
i3/.config/i3/config               # Legacy i3 config (reference for keybinding parity)
```

AeroSpace launches SketchyBar and JankyBorders via `after-startup-command`. Workspace changes are forwarded to SketchyBar via `exec-on-workspace-change`.

## Key Conventions

- **No compile step or tests** — this is declarative config. Validate by symlinking and restarting the relevant service.
- When adding macOS TWM configs, mirror the i3 keybinding philosophy: `Alt+hjkl` focus, `Alt+Shift+hjkl` move, `Alt+1-8` workspaces, `Alt+Shift+1-8` move-to-workspace.
- SketchyBar items should respond to the `aerospace_workspace_change` trigger event.
- Borders config uses the `borders` CLI with options passed as array.
- zsh pluginrc clones plugins to `/etc/zsh/plugins/` with a manual `apply()` function — follow this pattern, don't introduce a plugin manager.

## Deployment

Config directories are designed to be symlinked into `$XDG_CONFIG_HOME`:
```bash
# Example pattern (not automated in this repo)
ln -sf ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml
ln -sf ~/dotfiles/ghostty/.config/ghostty ~/.config/ghostty
```

After editing AeroSpace config: `aerospace reload-config`
After editing SketchyBar: `sketchybar --reload`
After editing borders: restart the borders process
After editing tmux: `tmux source-file ~/.config/tmux/tmux.conf`
