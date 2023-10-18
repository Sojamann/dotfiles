#!/bin/bash

_session_exists() {
	_get_sessions | grep "$1"
}

_get_sessions() {
	tmux ls -F '#{session_name}' | tr '\n' ' '
}

open_real() {
	target="$(readlink -f "${1?}")"
	repo="$(find "$target" -mindepth 1 -maxdepth 1 -exec basename {} \; | fzf)"

	if ! _session_exists "$repo"; then
		tmux new-session -d -n 'SHELL' -s "$repo" -c "${target}/${repo}" bash
	fi
	tmux switch -t "$repo"
}

select_session_real() {
	name="$(tmux ls -F '#{session_name}' | fzf)"
	tmux switch -t "$name"
}

session_prev_real() {
	sessions="$(tmux ls -F '#{session_name}' | tr '\n' ' ')"
	idx=0
	for session in "${sessions}"; do
		if [[ "$session" == ]]
	done
}

case "$1" in
	# the normal command line options one should use
	open) tmux splitw "$(realpath "$0") open_real $2" ;;
	select_session) tmux splitw "$(realpath "$0") select_session_real";;

	# the commands which are within another pane
	open_real) open_real "$2" ;;
	select_session_real) select_session_real ;;

	*) echo "BAD OPTION $1" >&2; exit 1 ;;
esac



