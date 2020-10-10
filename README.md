# dotfiles

Personal development-environment preferences. Using this configuration in ArcoLinux, WSL2, and Termux.

![dotfiles](https://user-images.githubusercontent.com/16854775/95653367-c98b3a00-0ae7-11eb-9266-7fa4d57021e3.jpg?raw=true)

How to install on Linux: 
1. Create backup of your current (neo)vim and zsh rc-files.
2. Make sure you've got working ```curl``` binary in your ```$PATH```.
3. Run in terminal: 
```git clone https://github.com/g4cm4n/dotfiles.git ~/dotfiles```
```cd ~/dotfiles```
```bash ~/dotfiles/install.sh```

(Optional) 4. If you have superuser rights you can remove ```.zshenv``` from your ```$HOME``` to keep it clean. Instead set ```ZDOTDIR=$HOME/.zsh``` inside ```/etc/zsh/zshenv``` (if it doesn't exist, create it first).

Instructions for WSL: 
1. Copy contents of ```dotfiles\windows\%USERPROFILE%\.config\Fonts``` to ```C:\Windows\Fonts```.
2. Copy ```dotfiles\windows\%USERPROFILE%\.config\ProfileIcons\``` to ```C:\Users\%USERPROFILE%\.config\ProfileIcons```.
3. Replace Windows Terminal settings (CTRL+,) with [this provided in repo](https://github.com/g4cm4n/dotfiles/blob/master/windows/settings.json).
4. Customize options which are different in your W10/WSL environment like ```startingDirectory```, ```keybindings```, etc...
4. Run ```bash ~/dotfiles/install.sh``` inside your WSL distro.
5. Restart prompt.

If you want to achieve similar look for [posh](https://github.com/PowerShell/PowerShell) or cmd, inspect files inside ```dotfiles\windows```. Try to adapt them to your environment, as my config has many dependencies. Most of them can be installed with the help of [scoop: command line installer for windows](https://github.com/lukesampson/scoop). Bare in mind, these settings are experimental and I frequently change them along with development of Linux Subsystem for Windows and Windows Terminal. Surely though, with improved interoperability between Win10 and WSL2 in the near future, it should be possible to optimize them and eliminate most exisiting annoyances/issues.
