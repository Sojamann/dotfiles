

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
pathadd "/usr/local/go/bin"
export PATH
unset -f pathadd

# ==========================
# ===     NVM/Node       ===
# ==========================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# ==========================
# ===      Aliases       ===
# ==========================
# -> editor
alias v='nvim'
alias vd='nvim -d'
# -> git
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gh='git show HEAD'
alias gg='git pull --rebase'
alias gb='git rev-parse --symbolic-full-name --abbrev-ref HEAD'
alias gbu='git branch --set-upstream-to=origin/$(gb) $(gb)'
# -> ls
alias lss='ls -la --sort=time'
# -> python
alias pysource='source ./venv/bin/activate'
# -> kubernetes
alias k='kubectl'
alias kuse='kubectl config use-context'

# ==========================
# ===    Completions     ===
# ==========================

type -P starship &>/dev/null && eval "$(starship init bash)"
type -P helm &>/dev/null && eval "$(helm completion bash)"
type -P kubectl &>/dev/null && eval "$(kubectl completion bash)"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"


# ==========================
# ===     Variables      ===
# ==========================
export EDITOR=nvim

