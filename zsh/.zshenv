# Define XDG Base directory environment variables
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

if [[ $(uname -a | awk '{print $1}') == 'Linux' ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
elif [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
  export XDG_CACHE_HOME="$HOME/Library/Caches"
fi

export PATH="$XDG_BIN_HOME:$PATH"
export EDITOR="nvim"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

mkdir -p $XDG_STATE_HOME/zsh
mkdir -p $XDG_CACHE_HOME/zsh

### unused
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_RUNTIME_DIR="$TMPDIR/runtime-$UID"
# mkdir -p $XDG_RUNTIME_DIR
