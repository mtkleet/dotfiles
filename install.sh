#!/usr/bin/bash
echo "Installing AstroNvim..."
[ -d "$HOME/.config/nvim" ] && mv $HOME/.config/nvim $HOME/.config/nvim.old
git clone -q https://github.com/AstroNvim/AstroNvim ~/.config/nvim
cp -r $HOME/dotfiles/astronvim $HOME/.config
echo "Installing zsh plugins..."
git clone -q https://github.com/zsh-users/zsh-completions.git $HOME/.zsh/zsh-completions
git clone -q https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh/zsh-autosuggestions
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
git clone -q https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git $HOME/.zsh/zsh-very-colorful-manuals
git clone -q https://github.com/MenkeTechnologies/zsh-more-completions.git $HOME/.zsh/zsh-more-completions
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.zsh/powerlevel10k
wget -P $HOME/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark"
wget -P $HOME/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark"
wget -P $HOME/.zsh/dircolors "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal"
cp -r $HOME/dotfiles/.zsh $HOME
mv $HOME/.zsh/.zshenv $HOME
echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.zsh/fzf && $HOME/.zsh/fzf/install
mv $HOME/.fzf.zsh $HOME/.zsh
rm $HOME/.fzf.bash
[ ! -d "$HOME/.local/bin" ] && mkdir -p $HOME/.local/bin
ln -s $HOME/.zsh/fzf/bin/fzf $HOME/.local/bin/fzf
cp -r $HOME/dotfiles/.local/bin/* $HOME/.local/bin
echo "Downloading MesloLGS NF fonts..."
wget -P $HOME/.local/share/fonts "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -P $HOME/.local/share/fonts "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -P $HOME/.local/share/fonts "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -P $HOME/.local/share/fonts "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
if [ -x "$(command -v fc-cache)" ]; then
    fc-cache -fv $HOME/.local/share/fonts
fi
echo "Do you want automatically install dependiencies (only for Arch-based distros with activated 'community' and 'testing' repositories)? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    if [ -x "$(command -v yay)" ]; then
        sudo pacman -S git base-devel
        git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -si
        rm -rf $HOME/yay
    fi
    yay -S zsh python python-pip perl llvm clang go rust nodejs neovim python-pynvim nodejs-neovim ruby-neovim curl ripgrep bottom ncdu exa bat bat-extras vivid ctags mpd ncmpcpp-git lazygit fd
    echo "Dependiencies installed!"
fi
echo "Do you want to install minimal mpd/ncmpcpp config? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    mkdir -p $HOME/.config/mpd/playlists
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        cp -r $HOME/dotfiles/wsl/.config/mpd $HOME/.config
        cp -r $HOME/dotfiles/wsl/.config/ncmpcpp $HOME/.config
        echo "Remember to change music directory path in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    else
        cp -r $HOME/dotfiles/.config/mpd $HOME/.config
        cp -r $HOME/dotfiles/.config/ncmpcpp $HOME/.config
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
    sudo mv $HOME/.zshenv /etc/zsh/zshenv
    echo "Done!"
fi
exit
