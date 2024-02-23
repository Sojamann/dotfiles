# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# ==========================
# ===      Aliases       ===
# ==========================
alias gl="git log"
alias gs="git status"
alias gd="git diff"
alias gh="git show HEAD"
alias gg="git pull --rebase"
alias gb="git rev-parse --symbolic-full-name --abbrev-ref HEAD"
alias gbu='git branch --set-upstream-to=origin/$(gb) $(gb)'
alias lss="ls -la --sort=time"
alias pysource="source ./venv/bin/activate"


# ==========================
# ===    Tool Setup      ===
# ==========================
eval "$(starship init bash)"

