# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# export ZSH="$HOME/.oh-my-zsh"
#
# # ZSH_THEME="robbyrussell"
# # ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# COMPLETION_WAITING_DOTS="true"
# plugins=(git docker fzf kubectl helm encode64 brew)
#
# # source $ZSH/oh-my-zsh.sh
# fpath+=$HOME/.zsh/pure


# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt globdots

autoload -Uz compinit

# =========================================================
# Completion
# =========================================================

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
# Enable interactive completion menu selection
zstyle ':completion:*' menu select
# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower


# Set up fzf key bindings and fuzzy completion
if command -v fzf > /dev/null 2>&1; then
    source <(fzf --zsh)
fi

alias lg="lazygit"

if command -v eza > /dev/null 2>&1; then
    alias ls="eza --icons"
    alias ll="eza -lah --icons --git"
    alias tree="eza --tree --icons"
fi
if command -v bat > /dev/null 2>&1; then
    alias cat='bat'
fi

alias vim="nvim"
alias v="nvim"
alias pogoda="curl -s 'wttr.in/{Belgrade,St-Petersburg,Hamburg}?format=3'"
alias k="kubectl"
# source <(kubectl completion zsh)
if [[ $(uname -a | awk '{print $1}') == 'Linux' ]]; then
    export SSH_AUTH_SOCK=${HOME}/.bitwarden-ssh-agent.sock
elif [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
    if [ -z $KEEPASS_SSH_AUTH_SOCK ]; then export KEEPASS_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"; fi
    export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
fi

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# export PATH="/opt/homebrew/opt/node@24/bin:$PATH"

# bindkey '^[[H' beginning-of-line
# bindkey '^[[F' end-of-line
# bindkey '^[[1~' beginning-of-line
# bindkey '^[[4~' end-of-line
bindkey -v
bindkey '^[[B' history-search-forward
bindkey '^[[A' history-search-backward

eval "$(starship init zsh)"
