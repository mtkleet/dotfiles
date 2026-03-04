# yay - An AUR Helper written in Go (https://github.com/Jguer/yay)
if [[ $commands[yay] ]]; then
    alias ipkg='yay -S'
    alias upkg='yay -Syu --devel'
    alias rpkg='yay -Rsc'
    alias rpkgf='yay -R --nodeps'
    alias lpkg='yay --query'
    alias spkg='yay'
else
    alias ipkg='sudo pacman -S'
    alias upkg='sudo pacman -Syyu'
    alias rpkg='sudo pacman -Rsc'
    alias rpkgf='sudo pacman -R --nodeps'
    alias lpkg='sudo pacman --query'
    alias spkg='sudo pacman -Ss'
fi
alias cpkg='sudo pacman -Rns $(pacman -Qtdq)'
alias mirror='sudo reflector -f 30 -l 30 --number 15 --verbose --save /etc/pacman.d/mirrorlist'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias sim='sudoedit'
alias vrc="nvim ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/lua/plugins/user.lua"
alias zrc="nvim $ZDOTDIR/.zshrc"
alias i3c="nvim ${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"

alias lo='exit'
alias :q='exit'
alias cls='clear'
alias df='df -h'
alias du='du -h'
alias free='free -mlt'
alias grep='grep --color=auto'
alias grepr='grep -r --exclude-dir={.git,.svn,CVS}'
alias rg='rg -P -H'
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias pbcopy='xclip -sel clip'
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME}/yarn/config"
alias userlist='cut -d: -f1 /etc/passwd'
alias jctl='journalctl -p 3 -xb'
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'
alias gcl='git clone'
alias gfp='git fetch && git pull'
alias rb='sudo reboot'
alias ssn='sudo shutdown now'

# bat - a cat clone with wings (https://github.com/sharkdp/bat)
if [[ $commands[bat] ]]; then
    alias c='bat --style="full"'
    alias cat='bat --style="plain"'
    alias bfzf='fzf --preview="bat {} --color=always"'
fi

alias dc='cd'
alias bd='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
if [[ $commands[advcp] ]]; then
    alias cp='advcp -g'
    alias mv='advmv -g'
fi
#alias cp='rsync -ah --partial --inplace --info=progress2'
alias rmi='rm --verbose --recursive --interactive'
alias rmf='rm -R -I --verbose'

# exa - a modern version of ls (https://github.com/ogham/exa)
if [[ $commands[eza] ]]; then
    alias l='eza --all --icons --grid --links --group-directories-first --classify --extended --git'
    alias ll='eza --group --long --all --git --color=auto --time-style=default --icons --extended --group-directories-first --classify --modified'
    #alias ll='exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=default'
    function lll() {eza --group --long --all --git --color=auto --time-style=default --icons --extended --group-directories-first --classify --modified $1 | less -RF}
    function wch() {eza --all --icons --grid --links --group-directories-first --classify --extended --git $(which $1)}
else
    alias l='ls -lACFfH --color=auto '
    alias ll='ls -lAFfHh --color=auto '
    function lll() {ls -lAFfHh --color=auto $1 | less -r}
    function wch() {ls -lAFhh $(which $1)}
fi
if [[ $commands[lsd] ]]; then
    alias lss='lsd --total-size --long --all --human-readable --classify --dereference --group-directories-first'
else
    alias lss='du -h --max-depth=1'
fi

# print real hostname
alias gethostname='cat /proc/sys/kernel/hostname'
# display all active ips
alias actip="echo '$(ip -o addr show up primary scope global | while read -r num dev fam addr rest; do echo ${addr%/*}; done)'"
# get lan ip
alias lanip='ip addr show |grep "inet " |grep -v 127.0.0. |head -1|cut -d" " -f6|cut -d/ -f1'
# print public ip
alias pubip='curl icanhazip.com'

if [[ $commands[yt-dlp] ]]; then
    alias ytd='yt-dlp --format "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]"'
    alias ytdmp3='yt-dlp -x --audio-format mp3 --audio-quality 320k'
fi

# unified remote - turn your smartphone into a universal remote control (https://github.com/unifiedremote)
test -r /opt/urserver/urserver && alias urd="/opt/urserver/urserver --daemon"

# 256-colors test pattern
colortest() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# ex - extractor for all kinds of archives
ex () {
    local file="$1"

    if [[ -f "$file" ]]; then
        case "$file" in
            *.tar.bz2) tar xjf "$file" ;;
            *.tar.gz)  tar xzf "$file" ;;
            *.bz2)     bunzip2 "$file" ;;
            *.rar)     unrar x "$file" ;;
            *.gz)      gunzip "$file" ;;
            *.tar)     tar xf "$file" ;;
            *.tbz2)    tar xjf "$file" ;;
            *.tgz)     tar xzf "$file" ;;
            *.zip)     unzip "$file" ;;
            *.Z)       uncompress "$file" ;;
            *.7z)      7z x "$file" ;;
            *.deb)     ar x "$file" ;;
            *) echo "'$file' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$file' is not a valid file"
    fi
}
