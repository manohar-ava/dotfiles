# Dotfiles Setup - zshenv Configuration

## Overview

This readme provides information on the changes made to the `zshenv` file during the setup of dotfiles. The purpose of these changes is to enhance the configuration and organization of the Zsh environment, particularly by adhering to the XDG Base Directory Specification.

##
install node,go,python3.XX-venv,npm,luarocks

## Changes Made

The following changes have been made to the `etc/zsh/zshenv` file:

```bash
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config/"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
fi
```

## Explanation

  XDG_CONFIG_HOME Setup:
        Checks if the environment variable $XDG_CONFIG_HOME is not set (empty).
        If not set, it assigns the value $HOME/.config/ to $XDG_CONFIG_HOME.

  ZDOTDIR Configuration:
        Checks if the directory specified by $XDG_CONFIG_HOME/zsh exists.
        If the directory exists, it sets $ZDOTDIR to $XDG_CONFIG_HOME/zsh/.
