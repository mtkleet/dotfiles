emulate -L zsh
setopt extendedglob

export COLORTERM=truecolor
export MANROFFOPT='-c'
export MANWIDTH=120
export LESS='-RF'
export LESSHISTFILE=-
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export VISUAL=nvim
export EDITOR=$VISUAL
export BROWSER=firefox
[[ -o interactive ]] && export GPG_TTY=$TTY

# translate Windows envs: %USERPROFILE% and %LOCALAPPDATA%
# keep access to sysdrive without appending anything to PATH (set "appendWindowsPath = false" in /etc/wsl.conf)
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    path+=(/mnt/c/Windows/System32)
    pushd /mnt/c >/dev/null || return
    export WINUSER=$(wslpath "$(cmd.exe /C "echo %USERPROFILE%" | tr -d '\r')")
    export APPDATA=$(wslpath "$(cmd.exe /C "echo %LOCALAPPDATA%" | tr -d '\r')")
    popd >/dev/null
    path=(${path:#/mnt/c/Windows/System32})
    alias s='s -b wslview -p brave'
    alias edal="nvim ${APPDATA}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
else
    alias s="s -p brave"
fi

# dircolors-solarized (https://github.com/seebi/dircolors-solarized)
if [[ -f "$ZDOTDIR/dircolors-solarized/dircolors.256dark" ]]; then
    eval "$(dircolors "$ZDOTDIR/dircolors-solarized/dircolors.256dark")"
fi

# vivid - A themeable LS_COLORS generator with a rich filetype datebase (https://github.com/sharkdp/vivid)
if command -v vivid >/dev/null 2>&1; then
    export LS_COLORS="$(vivid generate solarized-dark)"
fi

source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/completions.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/aliases.zsh"
