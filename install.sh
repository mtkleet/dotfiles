#!/usr/bin/bash
echo "Do you want install dependiencies (Arch-based distros only)? [y/n]"
read input
if [[ $input == "y" || $input == "Y" ]]; then
    sudo pacman -S --needed git base-devel zsh python llvm go rust nodejs neovim python-pynvim nodejs-neovim ruby-neovim wget ripgrep bottom ncdu htop exa bat bat-extras vivid ctags
    git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si
    git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    echo "Dependiencies installed!"
fi
echo "Do you want to install minimal mpd/ncmpcpp config? [y/n]"
read input
if [[ $input == "y" || $input == "Y" ]]; then
    if [ -n "${WSL_DISTRO_NAME}+1" ]; then
        cp -r ~/dotfiles/wsl/mpd ~/.config/
        cp -r ~/dotfiles/wsl/ncmpcpp ~/.config/
        echo "Remember to change music directory in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    else
        cp -r ~/dotfiles/.config/mpd ~/.config/
        cp -r ~/dotfiles/.config/ncmpcpp ~/.config/
        echo "Remember to change music directory in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    fi
fi
echo "Installing AstroNvim..."
git clone -q https://github.com/AstroNvim/AstroNvim ~/.config/nvim
cp -r ~/dotfiles/astronvim ~/.config/
echo "Downloading MesloLGS NF fonts..."
if [ ! -d "$HOME/.local/fonts" ]; then
    mkdir -p "$HOME/.local/fonts"
fi
cd $HOME/.local/fonts
curl -O https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf
curl -O https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf
curl -O https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf
curl -O https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf
if [ -x "$(command -v fc-cache)" ]; then
    fc-cache -fv .
fi
echo "Installing zsh plugins..."
git clone -q https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone -q https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone -q https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git ~/.zsh/zsh-very-colorful-manuals
git clone -q https://github.com/MenkeTechnologies/zsh-more-completions.git ~/.zsh/zsh-more-completions
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
echo "Placing RC files in ~/.zsh..."
cp -r ~/dotfiles/.zsh ~/
echo "Setting dircolors for Solarized Dark theme..."
mkdir -p ~/.zsh/dircolors
cd ~/.zsh/dircolors
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal
# echo ""
echo "Installing fzf..."
# echo "You will get prompted about enabling fuzzy autocompletions/fzf keybindings and updating shell configuration files..."
# echo -e "\e[31mIt is NOT neccesary though! Select [n] three times to avoid duplicated instructions in zshrc\e[0m"
# sleep 5
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf && ~/.zsh/fzf/install
cp ~/dotfiles/.fzf.zsh ~/.zsh
echo "Cleaning after fzf..."
rm -r ~/.fzf*
echo "You can find zsh configuration files and plugins in \$ZDOTDIR which is now: ~/.zsh"
echo "Done!"
echo "Do you want to remove \$HOME/dotfiles (y/n)"
read input
if [[ $input == "y" || $input == "Y" ]]; then
    rm -r ~/dotfiles
    echo "$HOME/dotfiles has been removed"
fi
echo "Restart prompt to apply changes and don't forget to run :PackerSync when using neovim for the first time."
echo "(Optional) If you have su rights, you can place 'ZDOTDIR=\$HOME/.zsh' in /etc/zshenv and delete .zshenv from \$HOME directory."
echo "Enjoy!"
exit
