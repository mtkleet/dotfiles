# environment variables
export TERM=xterm-256color
export COLORTERM=truecolor
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MANROFFOPT='-c'
export LESSHISTFILE=-
export PATH=$PATH:~/.local/bin
export EDITOR=nvim

# zshell specific envs and "must-set-before" plugins' settings
export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
if [[ -r $ZDOTDIR/dircolors/dircolors.ansi-dark ]]; then
    eval `dircolors $ZDOTDIR/dircolors/dircolors.ansi-dark`
fi
fpath=($ZDOTDIR/zsh-completions/src $fpath)
fpath=($ZDOTDIR/zsh-more-completions/src $fpath)
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
export ZLE_RPROMPT_INDENT=0
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh options
setopt AUTO_CD
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt CORRECT
setopt GLOBDOTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt LIST_PACKED
setopt SHARE_HISTORY

# zsh autocompletion cutomization
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r $ZDOTDIR/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' $ZDOTDIR/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi
zmodload -i zsh/complist
zmodload zsh/zpty

# zsh keybindings
bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-kill-word
bindkey '^?' backward-delete-char

# load plugins
[ -f $ZDOTDIR/.fzf.zsh ] && source $ZDOTDIR/.fzf.zsh
source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases for managing arch-based distros
if [[ $commands[yay] ]]; then   #yay - n AUR Helper written in Go (https://github.com/Jguer/yay)
    alias upkg='yay -Y --gendb && yay -Syu --devel --timeupdate'
    alias yayskip='yay -S --mflags --skipinteg'
else
    alias upkg='sudo pacman -Syyu'
fi
alias ipkg='sudo pacman -S'
alias rpkg='sudo pacman -Rsc'
alias spkg='sudo pacman -Ss'
alias cpkg='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'
if [[ $commands[expac] ]]; then
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"
fi
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# neovim assignments
if [[ $commands[nvim] ]]; then
    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim'
    alias vrc='nvim ~/.config/nvim/init.vim'
    alias zrc='nvim $ZDOTDIR/.zshrc'
fi

# aliases for better experience with basic unix tools
alias lo='exit'
alias :q='exit'
alias cls='clear'
alias df='df -h'
alias free='free -mt'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias sgrep='grep --color -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias userlist='cut -d: -f1 /etc/passwd'
alias jctl='journalctl -p 3 -xb'
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'
alias gcl='git clone'
alias rb='sudo reboot'
alias ssn='sudo shutdown now'
if [[ $commands[bat] ]]; then    #bat - a cat clone with wings (https://github.com/sharkdp/bat)
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    alias c='bat'
    alias cat='bat --style="plain"'
    alias bfzf='fzf --preview="bat {} --color=always"'
fi

# directory navigation
alias dc='cd'
alias bd='cd ..'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
if [[ $commands[exa] ]]; then   #exa - a modern version of ls (https://github.com/ogham/exa)
    alias ll='exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=long-iso'
else
    alias ll='ls -lAFHh --color=auto --group-directories-first'
fi
alias l='ls -lACFH --color --color=auto --group-directories-first'

#other useful aliases
alias colortest='for i in {0..255}; do print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'}; done'
alias gethostname='cat /proc/sys/kernel/hostname'
alias actips="echo '$(ip -o addr show up primary scope global | while read -r num dev fam addr rest; do echo ${addr%/*}; done)'"    #display all active ips
alias lanip='ip addr show |grep "inet " |grep -v 127.0.0. |head -1|cut -d" " -f6|cut -d/ -f1'    #get lan ip
alias pubip='curl icanhazip.com'    #print public ip

alias ytd='youtube-dl -f bestvideo+bestaudio'    #download yt file in highest quality available
alias ytdmp3='youtube-dl -x --audio-format mp3 --audio-quality 320k'    # download yt file and convert it to mp3@320kbps format
alias urd='/opt/urserver/urserver --daemon'    #unified remote - turn your smartphone into a universal remote control (https://github.com/unifiedremote)
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    alias s='s -b wslview'    #s - web search from the terminal (https://github.com/zquestz/s) 
                              #using wslview from wslu (https://github.com/wslutilities/wslu) as binary
fi    

ex ()    #ex - EXtractor for all kinds of archives
{    
  if [ -f $1 ] ; then    
    case $1 in    
      *.tar.bz2)   tar xjf $1   ;;    
      *.tar.gz)    tar xzf $1   ;;    
      *.bz2)       bunzip2 $1   ;;    
      *.rar)       unrar x $1   ;;    
      *.gz)        gunzip $1    ;;    
      *.tar)       tar xf $1    ;;    
      *.tbz2)      tar xjf $1   ;;    
      *.tgz)       tar xzf $1   ;;    
      *.zip)       unzip $1     ;;    
      *.Z)         uncompress $1;;    
      *.7z)        7z x $1      ;;    
      *.deb)       ar x $1      ;;    
      *.tar.xz)    tar xf $1    ;;    
      *)           echo "'$1' cannot be extracted via ex()" ;;    
    esac    
  else    
    echo "'$1' is not a valid file"    
  fi 
}
