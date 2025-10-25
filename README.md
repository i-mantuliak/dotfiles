# dotfiles
My Dotfiles

## settings for XDG envs:
```shell
cp .zshenv ~/
```

## nvim setup:
```shell
brew install neovim ripgrep fzf bat
brew install mvn openjdk@11 # for kotlin language server
brew install node@22 # for bash lsp
echo 'export PATH="/opt/homebrew/opt/node@22/bin:$PATH"' >> ~/.zshrc
```
## ghostty setup
```shell
brew install --cask ghostty
brew install --cask font-jetbrains-mono-nerd-font
```

## tmux setup
```shell
mkdir -p ~/.config/tmux/
ln -s ~/github/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
tmux
```
Press `Prefix + I` to install plugins
