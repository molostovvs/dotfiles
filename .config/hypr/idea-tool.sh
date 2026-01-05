#!/bin/bash
NOTES_DIR="$HOME/notes"
FILE="$NOTES_DIR/ideas.md"
mkdir -p "$NOTES_DIR"

case "$1" in
add)
	idea=$(rofi -dmenu -p "📝 Quick Capture")
	if [ -n "$idea" ]; then
		echo "- [ ] $(date '+%Y-%m-%d %H:%M') | $idea" >>"$FILE"
	fi
	;;

check)
	# 1. Filter only lines that have [ ] (unchecked)
	# 2. Use 'tac' so newest tasks are at the top
	# 3. Use 'grep' to show only incomplete tasks
	selected=$(grep "\[ \]" "$FILE" | tac | rofi -dmenu -i -p "✔️ Mark Done")

	if [ -n "$selected" ]; then
		# Escape special characters for sed
		escaped_selected=$(echo "$selected" | sed 's/[^^]/[&]/g; s/\^/\\^/g')
		# Replace the first instance of [ ] with [x] for that specific line
		sed -i "/$escaped_selected/s/\[ \]/\[x\]/" "$FILE"
		notify-send "Task Completed" "Checked off: $selected"
	fi
	;;

view)
	selected=$(tac "$FILE" | rofi -dmenu -i -p "🔍 Search All")
	if [ -n "$selected" ]; then
		ghostty -e nvim "$FILE"
	fi
	;;
esac
