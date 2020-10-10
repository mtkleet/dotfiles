# dotfiles

Personal development-environment preferences. Using this configuration in ArcoLinux, WSL2, and Termux.

![dotfiles](https://user-images.githubusercontent.com/16854775/95653367-c98b3a00-0ae7-11eb-9266-7fa4d57021e3.jpg?raw=true)

To install, just clone this repo to home directory: 
```
git clone https://github.com/g4cm4n/dotfiles.git ~/dotfiles
``` 
and run (you'll need curl in your $PATH): 
```
chmod a+x ~/dotfiles/install.sh
bash ~/dotfiles/install.sh
```
Additionally for WSL: copy contents of a ```dotfiles/windows/%USERPROFILE%/.config/Fonts/``` to ```C:\Windows\Fonts```.

If you want to achieve similar look for [posh](https://github.com/PowerShell/PowerShell) or cmd, inspect files inside ```dotfiles/windows```. Try to adapt them to your environment, as my config has many dependencies. Most of them can be installed with the help of [scoop: command line installer for windows](https://github.com/lukesampson/scoop). Bare in mind, these settings are experimental and I frequently change them along with a development of WSL and Windows Terminal. Surely though, with improved interoperability between Win10 and WSL2 in the near future, it should be possible to optimize them.
