#!/usr/bin/bash
echo "Installing zsh plugins..."
git clone -q "https://github.com/zsh-users/zsh-completions.git" "${HOME}/.zsh/zsh-completions"
git clone -q "https://github.com/zsh-users/zsh-autosuggestions.git" "${HOME}/.zsh/zsh-autosuggestions"
git clone -q "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/.zsh/zsh-syntax-highlighting"
git clone -q "https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git" "${HOME}/.zsh/zsh-very-colorful-manuals"
git clone -q "https://github.com/MenkeTechnologies/zsh-more-completions.git" "${HOME}/.zsh/zsh-more-completions"
git clone -q --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${HOME}/.zsh/powerlevel10k"
git clone -q "https://github.com/seebi/dircolors-solarized" "${HOME}/.zsh/dircolors-solarized"
cp -r "${HOME}/dotfiles/.zsh" "${HOME}"
cp "${HOME}/.zsh/.zshenv" "${HOME}"
[[ ! -d ${XDG_DATA_HOME:-$HOME/.local/share}/pki/nssdb ]] && mkdir -p ${XDG_DATA_HOME:-$HOME/.local/share}/pki/nssdb
[[ ! -d "${HOME}/.local/bin" ]] && mkdir -p "${HOME}/.local/bin"
cp -r "${HOME}/dotfiles/.local/bin/*" "${HOME}/.local/bin"
cp -r "${HOME}/dotfiles/.config/bat" "${HOME}/.config"

echo "Do you want automatically install dependiencies (only for Arch-based distros with activated 'community' and 'testing' repositories)? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    ln -s ${HOME}/.local/bin ${XDG_DATA_HOME}/go/bin
    ln -s ${HOME}/.local/bin ${XDG_DATA_HOME}/cargo/bin
    ln -s ${HOME}/.local/bin ${XDG_DATA_HOME}/gem/ruby/3.0.0/bin
    sudo pacman -S git base-devel
    git clone "https://aur.archlinux.org/yay.git" "${HOME}/yay" && cd "${HOME}/yay" && makepkg -si
    rm -rf "${HOME}/yay"
    yay -S coreutils patch zsh python python-pip python-setuptools perl go rust nodejs neovim python-pynvim nodejs-neovim ruby-neovim \
    curl ripgrep bottom gdu exa bat bat-extras vivid ctags mpd ncmpcpp-git lazygit fd llvm clang boost lazygit wget
    curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ${HOME}.local/advcpmv/install.sh && (cd advcpmv && sh install.sh)
    cp ${HOME}/.local/advcpmv/advcp ${HOME}/.local/bin
    cp ${HOME}/.local/advcpmv/advmv ${HOME}/.local/bin
    rm -rf ${HOME}/.local/advcpmv
    echo "Dependiencies installed!"
 fi
echo "Do you want to install minimal mpd/ncmpcpp config? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    mkdir -p "${HOME}/.config/mpd/playlists"
    if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
        cp -r "${HOME}/dotfiles/wsl/.config/mpd" "${HOME}/.config"
        cp -r "${HOME}/dotfiles/wsl/.config/ncmpcpp" "${HOME}/.config"
        cd "${HOME}/.config/mpd"
        touch log mpd.db mpd.sql state sticker.sql
        echo "Remember to change music directory path in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3

    else
        cp -r "${HOME}/dotfiles/.config/mpd" "${HOME}/.config"
        cp -r "${HOME}/dotfiles/.config/ncmpcpp" "${HOME}/.config"
        cd "${HOME}/.config/mpd"
        touch log mpd.db mpd.sql state sticker.sql
        echo "Remember to change music directory path in ~/.config/mpd/mpd.conf and ~/.config/ncmpcpp/config"
        sleep 3
    fi
fi

echo "Do you want to install AstroNvim (configuration)? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    echo "Installing AstroNvim..."
    [[ -d "${HOME}/.config/nvim" ]] && mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.old"
    git clone -q "https://github.com/mtkleet/astronvim_config.git" "${HOME}/.config/nvim"
fi

echo -n "You can find zsh configuration files and plugins in \$ZDOTDIR which is now set to: ~/.zsh 
Restart prompt to apply changes and run: nvim +PackerSync
[Recommended] If you have su rights, move ~/.zshenv to /etc/zsh (without dot): sudo mv \$HOME/.zshenv /etc/zsh/zshenv
Do you wish to do it now? [y/n]"
read -r input
if [[ $input == "y" || $input == "Y" ]]; then
    sudo mv "${HOME}/.zshenv" "/etc/zsh/zshenv"
    echo "Done!"
fi
exit
