#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

ZSH_DIR="${HOME}/.zsh"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Helper functions
ask() {
  read -rp "$1 [y/N]: " input
  [[ "${input:-}" =~ ^[Yy]$ ]]
}

clone_or_pull() {
  local repo="$1"
  local dir="$2"

  if [[ -d "$dir/.git" ]]; then
    echo "Updating $(basename "$dir")..."
    git -C "$dir" pull --quiet
  else
    echo "Cloning $(basename "$dir")..."
    git clone --depth=1 --quiet "$repo" "$dir"
  fi
}

create_bin_redirect() {
  local parent="$1"
  local target="$HOME/.local/bin"

  mkdir -p "$parent"

  if [[ -L "$parent/bin" ]]; then
    rm "$parent/bin"
  elif [[ -e "$parent/bin" ]]; then
    echo "Warning: $parent/bin exists and is not a symlink. Skipping."
    return
  fi

  ln -s "$target" "$parent/bin"
}

detect_ruby_version() {
  if command -v ruby &>/dev/null; then
    ruby -e 'print RbConfig::CONFIG["ruby_version"]'
  else
    echo ""
  fi
}

# ZSH plugins
echo "Installing ZSH plugins..."
mkdir -p "$ZSH_DIR"

clone_or_pull https://github.com/zsh-users/zsh-completions.git "$ZSH_DIR/zsh-completions"
clone_or_pull https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_DIR/zsh-autosuggestions"
clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_DIR/zsh-syntax-highlighting"
clone_or_pull https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git "$ZSH_DIR/zsh-very-colorful-manuals"
clone_or_pull https://github.com/MenkeTechnologies/zsh-more-completions.git "$ZSH_DIR/zsh-more-completions"
clone_or_pull https://github.com/romkatv/powerlevel10k.git "$ZSH_DIR/powerlevel10k"
clone_or_pull https://github.com/seebi/dircolors-solarized.git "$ZSH_DIR/dircolors-solarized"

# Copy dotfiles
echo "Copying configuration files..."

# .zsh
cp -r "$DOTFILES_DIR/.zsh" "$HOME"
cp "$ZSH_DIR/.zshenv" "$HOME"

# .config (without mpd/ncmpcpp for now)
mkdir -p "$XDG_CONFIG_HOME"

for dir in "$DOTFILES_DIR/.config"/*; do
  base="$(basename "$dir")"

  if [[ "$base" == "mpd" || "$base" == "ncmpcpp" ]]; then
    continue
  fi

  cp -r "$dir" "$XDG_CONFIG_HOME/"
done

# .local/bin
mkdir -p "$HOME/.local/bin"
cp -r "$DOTFILES_DIR/.local/bin/." "$HOME/.local/bin/" 2>/dev/null || true

# .local/share
mkdir -p "$XDG_DATA_HOME"
cp -r "$DOTFILES_DIR/.local/share/." "$XDG_DATA_HOME/" 2>/dev/null || true

mkdir -p "$XDG_DATA_HOME/pki/nssdb"

# Unified bin redirections
echo "Creating unified bin redirections..."

create_bin_redirect "$XDG_DATA_HOME/cargo"
create_bin_redirect "$XDG_DATA_HOME/go"
create_bin_redirect "$XDG_DATA_HOME/pnpm"

RUBY_VERSION="$(detect_ruby_version)"

if [[ -n "$RUBY_VERSION" ]]; then
  create_bin_redirect "$XDG_DATA_HOME/gem/ruby/$RUBY_VERSION"
else
  echo "Ruby not detected. Skipping Ruby bin redirect."
fi

# Arch dependencies
if ask "Install dependencies (Arch-based only)?"; then

  if [[ ! -f /etc/arch-release ]]; then
    echo "Not an Arch-based system. Skipping."
    exit 0
  fi

  sudo pacman -S --needed git base-devel

  if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
  fi

  yay -S --needed \
    coreutils patch zsh python python-pip perl go rust nodejs neovim \
    curl ripgrep bottom gdu exa bat bat-extras vivid ctags mpd \
    ncmpcpp lazygit fd llvm boost wget

  echo "Dependencies installed."
fi

# mpd / ncmpcpp
if ask "Install mpd/ncmpcpp config?"; then

  mkdir -p "$XDG_CONFIG_HOME/mpd/playlists"

  if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    cp -r "$DOTFILES_DIR/wsl/.config/mpd" "$XDG_CONFIG_HOME"
    cp -r "$DOTFILES_DIR/wsl/.config/ncmpcpp" "$XDG_CONFIG_HOME"
  else
    cp -r "$DOTFILES_DIR/.config/mpd" "$XDG_CONFIG_HOME"
    cp -r "$DOTFILES_DIR/.config/ncmpcpp" "$XDG_CONFIG_HOME"
  fi

  touch "$XDG_CONFIG_HOME/mpd/"{log,mpd.db,mpd.sql,state,sticker.sql}

  echo "Remember to change music directory path in mpd.conf"
fi

# AstroNvim
if ask "Install AstroNvim configuration?"; then
  [[ -d "$XDG_CONFIG_HOME/nvim" ]] && mv "$XDG_CONFIG_HOME/nvim" "$XDG_CONFIG_HOME/nvim.backup"
  clone_or_pull https://github.com/mtkleet/astronvim_config.git "$XDG_CONFIG_HOME/nvim"
fi

# ZDOTDIR notice
echo
echo "ZDOTDIR is set to ~/.zsh"
echo "Recommended: move ~/.zshenv to /etc/zsh/zshenv"

if ask "Move now? (requires sudo)"; then
  sudo mv "$HOME/.zshenv" "/etc/zsh/zshenv"
  echo "Done."
fi

echo
echo "Installation complete."
