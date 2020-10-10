@echo off
DOSKEY l=wsl -e exa -amFg --group-directories-first --color=always --color-scale $*
DOSKEY ll=wsl -e exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=long-iso $*
REM DOSKEY ll=ls -lAFHhg --color=auto
REM DOSKEY l=ls -ACFH --color=auto
DOSKEY lo=exit
DOSKEY :q=exit
DOSKEY reboot=powershell.exe --Reboot-Computer
DOSKEY nvim=wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $*
DOSKEY vim=wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $*
DOSKEY vi=wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $*
DOSKEY v=wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $*
DOSKEY c=bat --theme=OneHalfDark --paging=never $*
DOSKEY ~=cd %USERPROFILE%
DOSKEY ..=cd ..
DOSKEY ...=cd ..\..
DOSKEY ....=cd ..\..\..
DOSKEY edal=wsl -e nvim /mnt/c/Users/%USERNAME%/.config/init.cmd
DOSKEY rmdir=RD /S /Q $*
winfetch.cmd
