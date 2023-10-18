#!/bin/bash

_get_session_name() {
	tmux display-message -p '#S'
}

_get_sessions() {
	tmux ls -F '#{session_name}' 
}

open_real() {
	target="$(readlink -f "${1?}")"
	repo="$(find "$target" -mindepth 1 -maxdepth 1 -exec basename {} \; | fzf)"

	if ! tmux has-session -t "$repo" &>/dev/null; then
		tmux new-session -d -n 'SHELL' -s "$repo" -c "${target}/${repo}" bash
	fi
	tmux switch -t "$repo"
}

select_session_real() {
	name="$(tmux ls -F '#{session_name}' | fzf)"
	tmux switch -t "$name"
}

session_cycle() {
	curr_session="$(_get_session_name)"
	readarray -t sessions <<<"$(_get_sessions)"
	idx=0
	for session in ${sessions[@]}; do
		# found
		if [[ "$session" == "$curr_session" ]]; then
			desired=$(((idx+$1)%${#sessions[@]}))		
			tmux switch -t "${sessions[$desired]}"
			break
		fi
		idx=$((idx+1))
	done
}

case "$1" in
	# the normal command line options one should use
	session-open) tmux splitw "$(realpath "$0") open_real $2" ;;
	session-select) tmux splitw "$(realpath "$0") select_session_real";;
	session-prev) session_cycle -1 ;;
	session-next) session_cycle 1 ;;

	# the commands which are within another pane
	open_real) open_real "$2" ;;
	select_session_real) select_session_real ;;

	*) echo "BAD OPTION $1" >&2; exit 1 ;;
esac



