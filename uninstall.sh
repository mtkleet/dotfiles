#!/usr/bin/bash
declare -a dotdirs
[[ -L "$HOME/.local/bin/fzf" ]] && unlink "$HOME/.local/bin/fzf"
[[ -f "$HOME/.zsh/fzf/uninstall" ]] && . ~/.zsh/fzf/uninstall
dotdirs=("$HOME/.zsh" "$HOME/,config/nvim" "$HOME/.config/astronvim" "$HOME/.local/share/nvim"
    "$HOME/.local/state/nvim" "$HOME/.cache/nvim" "$HOME/.config/bat")
for i in "${dotdirs[@]}"; do rm -rf "$i"; done
[[ -f "$HOME/.zshenv" ]] && rm ~/.zshenv
