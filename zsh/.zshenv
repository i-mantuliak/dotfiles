export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Define XDG Base directory environment variables
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$TMPDIR/runtime-$UID"
export PATH="$XDG_BIN_HOME:$PATH"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

if [[ $(uname -a | awk '{print $1}') == 'Linux' ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
elif [[ $(uname -a | awk '{print $1}') == 'Darwin' ]]; then
  export XDG_CACHE_HOME="$HOME/Library/Caches"
fi

[[ -d "$XDG_BIN_HOME" ]] || mkdir -p "$XDG_BIN_HOME"
[[ -d "$XDG_RUNTIME_DIR" ]] || mkdir -p "$XDG_RUNTIME_DIR"
[[ -d "$XDG_STATE_HOME/zsh" ]] || mkdir -p "$XDG_STATE_HOME/zsh"
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Define user vars
export EDITOR="nvim"
if [[ "$(hostname)" == 'igor-mantuliak' ]]; then
  export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
  export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
fi

