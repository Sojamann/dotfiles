

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# ==========================
# ===       Path         ===
# ==========================
pathadd () {
	case ":${PATH}:" in
		*:"$1":*)
			;;
		*)
			PATH=$PATH:$1
			;;
	esac
}
pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/local/go/bin"
export PATH
unset -f pathadd


# ==========================
# ===      Aliases       ===
# ==========================
# -> git
alias gl="git log"
alias gs="git status"
alias gd="git diff"
alias gh="git show HEAD"
alias gg="git pull --rebase"
alias gb="git rev-parse --symbolic-full-name --abbrev-ref HEAD"
alias gbu='git branch --set-upstream-to=origin/$(gb) $(gb)'
# -> ls
alias lss="ls -la --sort=time"
# -> python
alias pysource="source ./venv/bin/activate"


# ==========================
# ===    Tool Setup      ===
# ==========================

type -P starship &>/dev/null && eval "$(starship init bash)"
type -P helm &>/dev/null && eval "$(helm completion bash)"
type -P kubectl &>/dev/null && eval "$(kubectl completion bash)"


