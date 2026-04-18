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

## aerospace
Need to disable mission control key bindings in settings (Ctll + -> ...)
```shell
ln -s ~/github/dotfiles/aerospace ~/.config/aerospace
```

## arch
```shell
pacman -S npm fzf tree-sitter-cli ttf-jetbrains-mono-nerd zip unzip tig ripgrep htop neovim eza jq yq tmux alacritty iwd less amd-ucode wireplumber openssh qt6-wayland qt5-wayland hyprpolkitagent impala bluetui wiremix
```

yay
```
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S brave-bin
```
