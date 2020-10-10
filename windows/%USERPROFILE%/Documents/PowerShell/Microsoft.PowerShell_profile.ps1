Import-Module posh-git
Import-Module oh-my-posh
Import-Module $env:SCOOP\modules\scoop-completion
Set-PSReadlineOption -BellStyle None
Set-Theme pure

function nvim {wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $args[0]}
function vim {wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $args[0]}
function vi {wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $args[0]}
function v {wsl -e nvim -c "let g:airline_theme='onehalfdark' | colorscheme onehalfdark | redrawtabline" $args[0]}
Set-Alias 'npp' 'notepad++.exe'
Set-Alias 'reboot' 'Restart-Computer'
function .. {cd ..}
function ... {cd ..\..}
function .... {cd ..\..\..}
function ~ {cd $HOME}
function lo {Invoke-command -ScriptBlock {exit}}
function :q {Invoke-command -ScriptBlock {exit}}
function l {wsl -e exa -amFg --group-directories-first --color=always --color-scale $args[0]}
function ll {wsl -e exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=long-iso $args[0]}
#function / {cd \}
#function \ {cd \}
#function l {ls.ps1 -ALCFH --color=auto}
#function ll {ls.ps1 -lLAFHh --color=auto}
function edal {nvim /mnt/c/Users/$env:USERNAME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1}
#function vrc {nvim $HOME\AppData\Local\nvim\init.vim}
function c {bat.ps1 --paging=never $args[0]}
