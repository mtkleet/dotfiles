#!/usr/bin/bash
VIM_DIR=~/.vim
NVIM_DIR=~/.config/nvim
BAT_DIR=~/.config/bat
FONTS_DIR=~/.local/fonts
echo "Setting dircolors for Solarized Dark theme..."
mkdir -p ~/.zsh/dircolors
cd ~/.zsh/dircolors
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal
if [ ! -d "VIM_DIR" ]; then
    echo "Creating ~/.vim directory..."
    mkdir -p $VIM_DIR
else
    echo "~/.vim already exists! Skipping..."
fi
if [ ! -d "NVIM_DIR" ]; then
    echo "Creating ~/.config/nvim directory..."
    mkdir -p $NVIM_DIR
    cp ~/dotfiles/init.vim ~/.config/nvim
    echo "neovim config moved to ~/.config/nvim/"
else
    "~/.config/nvim already exists! Skipping..."
fi
if [ ! -d "BAT_DIR" ]; then
    echo "Creating ~/.config/bat directory..."
    mkdir -p $BAT_DIR
    cp ~/dotfiles/config ~/.config/bat
    echo "bat config moved to ~/.config/bat/"
else
    echo "~/.config/bat already exists! Skipping..."
fi
echo "Downloading patched Meslo fonts..."
if [ ! -d "FONTS_DIR" ]; then
    mkdir -p $FONTS_DIR
fi
cd $FONTS_DIR
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
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
echo "Placing RC files in ~/.zsh..."
cp ~/dotfiles/.p10k.zsh ~/.zsh
cp ~/dotfiles/.zshenv ~/.zshenv
cp ~/dotfiles/.zshrc ~/.zsh
echo ""
echo "Installing fzf..."
echo "You will get prompted about enabling fuzzy autocompletions/fzf keybindings and updating shell configuration files..."
echo -e "\e[31mIt is NOT neccesary though! Select [n] three times to avoid duplicated instructions in zshrc\e[0m"
echo ""
sleep 10
git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf && ~/.zsh/fzf/install
cp ~/dotfiles/.fzf.zsh ~/.zsh
echo "Cleaning after fzf..."
rm -rf ~/.fzf.bash ~/.fzf.zsh
echo "You can find zsh configuration files and plugins in \$ZDOTDIR which is now: ~/.zsh"
echo "Done!"
echo "Do you want to remove \$HOME/dotfiles (y/n)"
read input
if [[ $input == "y" || $input == "Y" ]]; then
    rm -rf ~/dotfiles
    echo "~/dotfiles has been removed"
fi
echo "Restart prompt to apply changes and don't forget to run :PlugInstall when using neovim for the first time."
echo "(Optional) If you have su rights, you can place 'ZDOTDIR=\$HOME/.zsh' in /etc/zshenv and delete .zshenv from \$HOME directory."
echo "Enjoy!"
exit
