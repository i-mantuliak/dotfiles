if [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi
