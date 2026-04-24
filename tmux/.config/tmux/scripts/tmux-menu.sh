#!/bin/bash

# Build the list
list=$(
	{
		tmux list-sessions -F '#S' | grep -v '^_popup_' | while read -r session; do
			echo "SESSION:$session"
			tmux list-windows -t "$session" -F 'WINDOW:#S:#I #W'
		done
	} | sed 's/^SESSION:/▼ /' | sed 's/^WINDOW:/  ⦿ /'
)

# Add actions at the top
actions=$(printf "  ＋ [new session]\n  ✕ [delete session]\n  ⟳ [rename session]")

selected=$(printf "%s\n%s" "$actions" "$list" | fzf --reverse)

case "$selected" in
"  ＋ [new session]")
	read -rp "New session name: " name
	[ -n "$name" ] && tmux new-session -ds "$name" && tmux switch-client -t "$name"
	;;
"  ✕ [delete session]")
	session=$(tmux list-sessions -F '#S' | grep -v '^_popup_' | fzf --reverse --prompt="Delete: ")
	if [ -n "$session" ]; then
		read -rp "Delete '$session'? (y/n): " confirm
		[ "$confirm" = "y" ] && tmux kill-session -t "$session"
	fi
	;;
"  ⟳ [rename session]")
	session=$(tmux list-sessions -F '#S' | grep -v '^_popup_' | fzf --reverse --prompt="Rename: ")
	if [ -n "$session" ]; then
		read -rp "New name: " newname
		[ -n "$newname" ] && tmux rename-session -t "$session" "$newname"
	fi
	;;
*)
	# Original switch logic
	echo "$selected" | awk '{
            if ($1 == "▼") print $2
            else if ($1 == "⦿") print $2
        }' | xargs -r tmux switch-client -t
	;;
esac
