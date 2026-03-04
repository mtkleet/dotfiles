@echo off
REM DOSKEY ll=dir
REM DOSKEY l=dir
DOSKEY ll=lsd -la --group-directories-first
DOSKEY l=lsd -a --group-directories-first
DOSKEY ipkg=shovel install $*
DOSKEY upkg=shovel update *
DOSKEY spkg=scoop-search.exe $*
DOSKEY rpkg=shovel uninstall $*
DOSKEY lo=exit
DOSKEY :q=exit
DOSKEY reboot=powershell.exe --Reboot-Computer
DOSKEY vim=nvim.exe $*
DOSKEY vi=nvim.exe *
DOSKEY v=nvim.exe $*
DOSKEY c=bat.exe --theme=OneHalfDark --paging=never $*
DOSKEY ~=cd %USERPROFILE%
DOSKEY ..=cd ..
DOSKEY ...=cd ..\..
DOSKEY ....=cd ..\..\..
DOSKEY edal=nvim -- %USERPRFOFILE%\.config\init.cmd
DOSKEY rmdir=RD /S /Q $*
call %USERPROFILE%\.config\powerline.bat\init.bat
winfetch
