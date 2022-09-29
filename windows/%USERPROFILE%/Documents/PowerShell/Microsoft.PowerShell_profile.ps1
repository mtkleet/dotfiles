Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
#Set-PSReadlineKeyHandler -Key DownArrow -ScriptBlock { Invoke-GuiCompletion }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
#Set-PSReadlineOption -PredictionSource History
#Set-PSReadlineOption -PredictionViewStyle ListView
#Set-PSReadlineOption -ShowToolTip

oh-my-posh init pwsh -c $HOME\scoop\apps\oh-my-posh\current\themes\powerlevel10k_lean.omp.json | Invoke-Expression
Import-Module '$HOME\scoop\apps\scoop\current\supporting\completion\Scoop-Completion.psd1' -ErrorAction SilentlyContinue
Import-Module Terminal-Icons
Import-Module cd-extras
Set-Alias 'vim' 'nvim'
Set-Alias 'v' 'nvim'
Set-Alias 'vi' 'nvim'
function .{cd .}
function ..{cd ..}
function ...{cd ..\..}
function ....{cd ..\..\..}
function .....{cd ..\..\..\..}
function l{ls | Format-Wide -Column 5}
function ll{Get-ChildItem -Force}
function ~{cd $env:USERPROFILE}
function /{cd \}
function \{cd \}
function lo{Invoke-command -ScriptBlock {exit}}
function edal{nvim $env:USERPROFILE\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1}
function wtrc{nvim $env:LOCALAPPDATA\\Packages\\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\\LocalState\\settings.json}
function vrc{nvim $env:LOCALAPPDATA\\nvim\\lua\\custom\\init.lua}
function hsts{gsudo nvim $env:SystemRoot\\System32\\drivers\\etc\\hosts}
function vdir{cd $env:LOCALAPPDATA\nvim}
function upkg{shovel update *}

Enable-PoshTooltips
Enable-PoshTransientPrompt
#try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }
