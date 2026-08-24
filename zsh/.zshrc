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
else
    alias ll='ls -lah'
fi
if command -v bat > /dev/null 2>&1; then
    alias cat='bat'
fi

if command -v nvim > /dev/null 2>&1; then
    alias vim="nvim"
    alias v="nvim"
else
    alias v="vim"
fi

alias pogoda="curl -s 'wttr.in/{Belgrade,St-Petersburg,Hamburg}?format=3'"
alias k="kubectl"

if [[ $(uname -a | awk '{print $1}') == 'Linux' ]]; then
    export SSH_AUTH_SOCK=${HOME}/.bitwarden-ssh-agent.sock
elif [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
    if [ -z $KEEPASS_SSH_AUTH_SOCK ]; then export KEEPASS_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"; fi
    export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
fi

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

eval "$(starship init zsh)"
