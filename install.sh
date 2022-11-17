#!/usr/bin/bash
echo "Installing AstroNvim..."
git clone -q https://github.com/AstroNvim/AstroNvim ~/.config/nvim
cp -r ~/dotfiles/astronvim ~/.config/
echo "Installing zsh plugins..."
git clone -q https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone -q https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone -q https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git ~/.zsh/zsh-very-colorful-manuals
git clone -q https://github.com/MenkeTechnologies/zsh-more-completions.git ~/.zsh/zsh-more-completions
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
wget -P ~/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark"
wget -P ~/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark"
wget -P ~/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal"
cp -r ~/dotfiles/.zsh ~/
mv ~/.zsh/.zshenv ~/
echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf && ~/.zsh/fzf/install
mv ~/.fzf.zsh ~/.zsh
rm -r ~/.fzf*
[[ ! -d "$HOME/.local/bin" ]] && mkdir -p ~/.local/bin
ln -s ~/.zsh/fzf/bin/fzf ~/.local/bin/fzf
cp -r ~/dotfiles/.local/bin/* ~/.local/bin
echo "Downloading MesloLGS NF fonts..."
wget -P ~/.local/fonts "https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS^%20NF%20Regular.ttf"
wget -P ~/.local/fonts "https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf"
wget -P ~/.local/fonts "https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf"
wget -P ~/.local/fonts "https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf"
if [ -x "$(command -v fc-cache)" ]; then
    fc-cache -fv .
fi
echo "Do you want automatically install dependiencies (only for Arch-based distros with activated 'community' and 'testing' repositories)? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si
    yay -S python perl llvm clang go rust nodejs neovim python-pynvim nodejs-neovim ruby-neovim curl ripgrep bottom ncdu exa bat bat-extras vivid ctags mpd ncmpcpp
    echo "Dependiencies installed!"
fi
echo "Do you want to install minimal mpd/ncmpcpp config? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        cp -r ~/dotfiles/wsl/.config/mpd ~/.config/
        cp -r ~/dotfiles/wsl/.config/ncmpcpp ~/.config/
        echo "Remember to change music directory path in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    else
        cp -r ~/dotfiles/.config/mpd ~/.config/
        cp -r ~/dotfiles/.config/ncmpcpp ~/.config/
        echo "Remember to change music directory path in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    fi
fi
echo "You can find zsh configuration files and plugins in \$ZDOTDIR which is now set to: ~/.zsh"
echo "Restart prompt to apply changes and run: nvim +PackerSync"
echo "[Recommended] If you have su rights, move ~/.zshenv to /etc/zsh (without dot): sudo mv \$HOME/.zshenv /etc/zsh/zshenv"
echo "Do you wish to do it now? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    sudo mv ~/.zshenv /etc/zsh/zshenv
    echo "Done!"
fi
exit
