if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"
plugins=(git docker fzf kubectl helm encode64 brew)

source $ZSH/oh-my-zsh.sh
fpath+=$HOME/.zsh/pure

alias lg="lazygit"
alias ls="eza"
alias ll="ls -lah"
alias vim="nvim"
alias v="nvim"
setopt globdots
alias pogoda="curl -s 'wttr.in/{Belgrade,St-Petersburg,Hamburg}?format=3'"
alias k="kubectl"
source <(kubectl completion zsh)
if [[ $(uname -a | awk '{print $1}') == 'Linux' ]]; then
    export SSH_AUTH_SOCK=${HOME}/.bitwarden-ssh-agent.sock
elif [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
    if [ -z $KEEPASS_SSH_AUTH_SOCK ]; then export KEEPASS_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"; fi
    export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export EDITOR="nvim"

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
