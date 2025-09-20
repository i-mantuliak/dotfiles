# dotfiles
My Dotfiles

settings for XDG envs:
```shell
cp .zshenv ~/
```

nvim setup:
```shell
brew install neovim ripgrep fzf bat
brew install node@22 # for bash lsp
echo 'export PATH="/opt/homebrew/opt/node@22/bin:$PATH"' >> ~/.zshrc
```
ghostty setup
```shell
brew install --cask ghostty
brew install --cask font-jetbrains-mono-nerd-font
```
