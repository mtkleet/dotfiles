#!/usr/bin/bash
NVIM_DIR=$HOME/.config/astronvim
FONTS_DIR=$HOME/.local/fonts
if [ ! -d "NVIM_DIR" ]; then
	echo "Creating ~/.config/astronvim directory..."
	mkdir -p "$NVIM_DIR"
	cp ~/dotfiles/astronvim ~/.config/
	echo "neovim config moved to ~/.config/astronvim/"
else
	echo "$HOME/.config/astronvim already exists! Skipping..."
fi
echo "Downloading patched Meslo fonts..."
if [ ! -d "FONTS_DIR" ]; then
	mkdir -p "$FONTS_DIR"
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
git clone -q https://github.com/MenkeTechnologies/zsh-more-completions.git ~/.zsh/zsh-more-completions
git clone -q https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
echo "Placing RC files in ~/.zsh..."
cp -r ~/dotfiles/.zsh ~/.
cp ~/dotfiles/.zsh/.zshenv ~/
echo "Setting dircolors for Solarized Dark theme..."
mkdir -p ~/.zsh/dircolors
cd ~/.zsh/dircolors
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
curl -O https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal
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
	echo "$HOME/dotfiles has been removed"
fi
echo "Restart prompt to apply changes and don't forget to run :PlugInstall when using neovim for the first time."
echo "(Optional) If you have su rights, you can place 'ZDOTDIR=\$HOME/.zsh' in /etc/zshenv and delete .zshenv from \$HOME directory."
echo "Enjoy!"
exit
