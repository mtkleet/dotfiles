### --- ENVIRONMENTAL VARIABLES --- ###
export TERM=xterm-256color
export COLORTERM=truecolor
export MANROFFOPT='-c'
export MANWIDTH=120
export LESS='-R'
export LESSHISTFILE=-
export PATH=$HOME/.local/bin:$PATH
export VISUAL=nvim
export EDITOR=$VISUAL
export LC_LANG=en-US.UTF-8
export LC_CTYPE=C.UTF-8
export LC_ALL=C.UTF-8

# set WORDCHARDS for 'backward-kill-word' to stop at forward slash
export WORDCHARS=${WORDCHARS/\/}

# remove empty space from right part of the prompt
export ZLE_RPROMPT_INDENT=0

# translate Windows envs: %USERPROFILE% and %LOCALAPPDATA%
# keep access to sysdrive without appending to anything to PATH (set "appendWindowsPath = false" in /etc/wsl.conf)
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    path+=/mnt/c/Windows/System32
    pushd /mnt/c > /dev/null # avoid UNC path error, then restore current path
    export WINUSER=$(wslpath $(cmd.exe /C "echo %USERPROFILE%" | tr -d '\r'))
    export APPDATA=$(wslpath $(cmd.exe /C "echo %LOCALAPPDATA%" | tr -d '\r'))
    popd > /dev/null
    path=(${path[@]:#*System32*})
    # s - web search from the terminal (https://github.com/zquestz/s)
    # using wslview from wslu (https://github.com/wslutilities/wslu) as binary and brave as engine
    alias s='s -b wslview -p brave'
    # edit Windows Terminal settings inside wsl (this path to leads to settings.json in Preview version)
    alias edal="nvim ${APPDATA}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
else
    alias s="s -p brave"
fi

# dircolors-solarized (https://github.com/seebi/dircolors-solarized)
eval `dircolors ${ZDOTDIR}/dircolors/dircolors.256dark`;
# vivid - A themeable LS_COLORS generator with a rich filetype datebase (https://github.com/sharkdp/vivid)
test -r vivid && export LS_COLORS="$(vivid generate solarized-dark)"

### --- ZSH OPTIONS --- ####
# zsh 'cd' and directory stack command behaviour
setopt    AUTO_CD                      # type the name of a directory and it will become current directory
setopt    AUTO_PUSHD                   # make 'cd' push the old directory onto the directory stack
unsetopt  CDABLE_VARS                  # type the name of variable and if it matches valid direcory it will become current directory
unsetopt  CHASE_LINKS                  # resolve symbolic links to their true values when changing directory
setopt    PUSHD_IGNORE_DUPS            # don't push multiple copies of the same directory onto the directory stack
setopt    PUSHD_MINUS                  # exchanges the meanings of `+' and `-' when used with a number to specify a directory in the stack
setopt    PUSHD_SILENT                 # parameter expansion, command substitution and arithmetic expansion are performed in prompts
# completion
setopt    ALWAYS_LAST_PROMPT           # try to return to the last prompt if given no numeric argument
setopt    AUTO_LIST                    # automatically list choices on an ambiguous completion
setopt    AUTO_MENU                    # automatically use menu completion after the second consecutive request for completion
setopt    AUTO_NAME_DIRS               # any parameter that is set to the absolute name of a directory will be available for completion
setopt    AUTO_PARAM_KEYS              # automatically prepare viable key after parameter completion
setopt    AUTO_PARAM_SLASH             # add a slash after completion if it was performed on direcory name
unsetopt  AUTO_REMOVE_SLASH            # do not remove slash after completion, let user handle it
setopt    BASH_AUTO_LIST               # on an ambiguous completion, automatically list viable hoices, like in bash
unsetopt  COMPLETE_ALIASES             # do not make alias a distinct command for completion
setopt    COMPLETE_IN_WORD             # completion is done from both ends
setopt    GLOB_COMPLETE                # when current word has a glob pattern generate matches as for completion and cycle through them
setopt    ALWAYS_TO_END                # moves cursor to end of word if a full completion is inserted
setopt    HASH_LIST_ALL                # make sure the entire command path is hashed first
unsetopt  LIST_AMBIGUOUS               # if there is an unambiguous prefix to insert, it's done without list being displayed or after third call
unsetopt  LIST_BEEP                    # do not beep on an ambigous completion
setopt    LIST_PACKED                  # try to make completion list smaller
setopt    LIST_ROWS_FIRST              # matches are listed in a horizontal fashion
setopt    LIST_TYPES                   # when listing files that are possible completions, show the type of each one
unsetopt  MENU_COMPLETE                # don't iterate through every possible match in menu
unsetopt  REC_EXACT                    # don't accept exact match if there are other possible completions
#setopt    GLOB_DOTS                   # include hidden files in tab completion
## expansion & globbing
setopt    BAD_PATTERN                  # if a pattern for filename generation is badly formed, print an error message
#setopt   BARE_GLOB_QUAL               # in a glob pattern, treat a trailing set of parentheses as a qualifier list, if it doesn't contain `|', `(, `~'
#setopt   BRACE_CCL                    # expands pattern in braces like: $ print 1{abw-z}2 to $ 1a2 1b2 1w2 1x2 1y2 1z2
#unsetopt  CASE_GLOB                    # case insensitive globbing
setopt    EXTENDED_GLOB                # treat the '#', '~' and '^' characters as part of patterns for filename generation, grepping etc.
setopt    GLOB                         # perform filename generation
unsetopt  GLOB_ASSIGN                  # prevent globbing from unpredictable results
unsetopt  GLOB_SUBST                   # don't treat every characters as eligible for expansion
unsetopt  IGNORE_BRACES                # do not perform brace expansion
unsetopt  KSH_GLOB                     # use native syntax for globbing
setopt    MARK_DIRS                    # append a trailing `/' to directory
setopt    MULTIBYTE                    # utf-8 support for zsh
setopt    NO_NOMATCH                   # if a pattern for filename generation has no matches don't print an error
#unsetopt CSH_NULL_GLOB                # if a pattern for filename generation has no matches print an error, overrides NOMATCH
#setopt   NUMERICGLOBSORT              # if numeric filenames are matched by generation pattern, sort the filenames numerically
setopt    RC_EXPAND_PARAM              # set array expansions
unsetopt  REMATCH_PCRE                 # regular expressions will use the extended regexp syntax provided by the system libraries
setopt    UNSET                        # don't error out when unset parameters are used
#unsetopt WARN_CREATE_GLOBAL           # disable warnings if a global variable is defined implicitly
## input/output
setopt    ALIASES                      # expand aliases
setopt    NO_CLOBBER                   # don’t write over existing files with >, use >! instead
setopt    CORRECT                      # spelling correction for commands
unsetopt  CORRECT_ALL                  # spelling correction for commands and everything else
unsetopt  IGNORE_EOF                   # do not exit on end-of-file, require the use of exit or logout instead
#setopt   INTERACTIVE_COMMENTS         # allow comments, even in interactive shells
setopt    HASH_CMDS                    # place the location of each command in the hash table the first time it is executed
setopt    HASH_DIRS                    # hash the directory of command's path whenever you execute it and all directories that occur earlier in the path
#unsetopt PRINT_EXIT_VALUE             # print a newline showing previous command's return value
#unsetopt RM_STAR_SILENT               # don't query the user before executing 'rm *'
#unsetopt RM_STAR_WAIT                 # don't wait before executing 'rm *''
setopt    SHORT_LOOPS                  # allow the short forms of for, select, if, and function constructs
## job control
setopt    AUTO_CONTINUE                # stopped jobs
unsetopt  AUTO_RESUME                  # treat single word commands without redirection as candidates for resumption of an existing job
setopt    BG_NICE                      # run all background jobs at a lower priority
setopt    CHECK_JOBS                   # report the status of background and suspended jobs before exiting a shell
setopt    NO_HUP                       # don't send HUP to jobs when shell exits
unsetopt  FLOWCONTROL                  # disable output flow control via start/stop character in the shell's editor
setopt    LONG_LIST_JOBS               # list jobs in long format by default
setopt    MONITOR                      # allow job control
setopt    NOTIFY                       # report the status of background jobs immediately
## prompt
unsetopt  PROMPT_BANG                  # if set, `!' is treated specially in prompt expansion
setopt    PROMPT_CR                    # print a carriage return just before printing a prompt in the line editor
setopt    PROMPT_SP                    # attempt to preserve a partial line that would otherwise be cover up by PROMPT_CR
setopt    PROMPT_PERCENT               # if set, `%' is treated specially in prompt expansion
setopt    PROMPT_SUBST                 # if set, parameter expansion, command substitution and arithmetic expansion are performed in prompts
## scripts & functions
unsetopt  C_PRECEDENCES                # use prcendence of operators found in C
unsetopt  DEBUG_BEFORE_CMD             # run the DEBUG trap after each command
unsetopt  ERR_EXIT                     # if a command has a non-zero exit status, don't execute the ZERR trap and exit
unsetopt  ERR_RETURN                   # if set and command has a non-zero exit status, return immediately from the enclosing function
setopt    EVAL_LINENO                  # line numbers of expressions evaluated by 'eval' are tracked separately of the enclosing environment
setopt    EXEC                         # do execute commands
setopt    FUNCTION_ARGZERO             # set $0 temporarily to the name of the function/script when executing
setopt    LOCAL_OPTIONS                # allow functions to have local options
setopt    LOCAL_TRAPS                  # allow functions to have local traps
setopt    MULTIOS                      # perform multiple implicit tees and cats with redirection
unsetopt  VERBOSE                      # don't print shell input as they are read
## zle
unsetopt  BEEP                         # don't beep on error
unsetopt  COMBINING_CHARS              # don't handle combining characters specially
unsetopt  OVERSTRIKE                   # don't start up the line editor in overstrike mode
unsetopt  SINGLE_LINE_ZLE              # don't use single line command line
#setopt    ZLE                          # use the zsh line editor
setopt    EMACS                        # emacs keybindings
# history
setopt    HIST_IGNORE_ALL_DUPS          # if a new command is a duplicate, remove the older one
setopt    HIST_REDUCE_BLANKS           # remove superfluous blanks from each command line being added to the history list
setopt    HIST_VERIFY                   # show command with history expansion to user before running it
setopt    SHARE_HISTORY                 # share command history data
setopt    EXTENDED_HISTORY              # save timestamp of  each command's beginning and the its duration
setopt    HIST_IGNORE_SPACE             # remove command lines from the history list when the first character is space
setopt    HIST_SAVE_NO_DUPS

                                        # specify history file location
export HISTFILE=$ZDOTDIR/zcompcache/zsh_history 
export HISTSIZE=10000                   # how many lines of history keep in memory
export SAVEHIST=10000                   # how many lines of history keep in history file

# basic keybindings
bindkey   '^[[1;5D' backward-word
bindkey   '^[[1;5C' forward-word
bindkey   '^[[5D' beginning-of-line
bindkey   '^[[5C' end-of-line
bindkey   '^[[3~' delete-char
bindkey   '^H' backward-kill-word

exp_alias() {                          # expand aliases to the left (if any) before inserting a space
    zle _expand_alias
    zle self-insert
    }; zle -N exp_alias

# better history navigation
autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search

bindkey -- ' '    exp_alias
bindkey -- '^P'   up-history
bindkey -- '^N'   down-history
bindkey -- '^E'   end-of-line
bindkey -- '^A'   beginning-of-line
# bindkey -- '^[^M' self-insert-unmeta # alt-enter to insert a newline/carriage return
bindkey -- '^K'   up-line-or-beginning-search
bindkey -- '^J'   down-line-or-beginning-search

[[ -n ${terminfo[kdch1]} ]] && bindkey -- "${terminfo[kdch1]}" delete-char                   # delete
[[ -n ${terminfo[kend]}  ]] && bindkey -- "${terminfo[kend]}"  end-of-line                   # end
[[ -n ${terminfo[kcuf1]} ]] && bindkey -- "${terminfo[kcuf1]}" forward-char                  # right arrow
[[ -n ${terminfo[kcub1]} ]] && bindkey -- "${terminfo[kcub1]}" backward-char                 # left arrow
[[ -n ${terminfo[kich1]} ]] && bindkey -- "${terminfo[kich1]}" overwrite-mode                # insert
[[ -n ${terminfo[khome]} ]] && bindkey -- "${terminfo[khome]}" beginning-of-line             # home
[[ -n ${terminfo[kbs]}   ]] && bindkey -- "${terminfo[kbs]}"   backward-delete-char          # backspace
[[ -n ${terminfo[kcbt]}  ]] && bindkey -- "${terminfo[kcbt]}"  reverse-menu-complete         # shift-tab
[[ -n ${terminfo[kcuu1]} ]] && bindkey -- "${terminfo[kcuu1]}" up-line-or-beginning-search   # up arrow
[[ -n ${terminfo[kcud1]} ]] && bindkey -- "${terminfo[kcud1]}" down-line-or-beginning-search # down arrow

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

zstyle ':completion::complete:*' cache-path $ZDOTDIR/zcompcache/zcompcache

# correction
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:approximate:*' max-errors 'reply=($(( ($#PREFIX + $#SUFFIX) / 3 )) numeric)'

# completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$comppath"
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose true
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:-command-:*:' verbose false
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' completer _complete _match _approximate _ignored
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# labels and categories
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:messages' format ' %F{green}->%F{purple} %d%f'
zstyle ':completion:*:descriptions' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:warnings' format ' %F{green}->%F{red} no matches%f'
zstyle ':completion:*:corrections' format ' %F{green}->%F{green} %d: %e%f'

# menu colours
# eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=36=0=01'

# command parameters
zstyle ':completion:*:functions' ignored-patterns '(prompt*|_*|*precmd*|*preexec*)'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:(vim|nvim|vi):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif)'

# hostnames and addresses
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle -e ':completion:*:hosts' hosts 'reply=( ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ } ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*} ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}})'

## additional completions (https://github.com/zsh-users/zsh-completions) & (https://github.com/MenkeTechnologies/zsh-more-completions)
fpath=(
    $ZDOTDIR/zsh?##completions\/[^override]#src
    $ZDOTDIR/zsh?##completions\/[^override]#src/**/*~*/(CVS)#(/N)
    "${fpath[@]}"
)
fpath=($ZDOTDIR/zsh-more-completions/override_src $fpath)

# fzf - A command-line fuzzy finder (https://github.com/junegunn/fzf)
source $ZDOTDIR/.fzf.zsh

# completion for ssh
_fzf_complete_ssh() {
    _fzf_complete +m -- "$@" < <(
        setopt localoptions nonomatch
        command cat <(command tail -n +1 ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?%]') \
            <(command grep -oE '^[[a-z0-9.,:-]+' ~/.ssh/known_hosts | tr ',' '\n' | tr -d '[' | awk '{ print $1 " " $1 }') \
            <(command grep -v '^\s*\(#\|$\)' /etc/hosts | command grep -Fv '0.0.0.0') |
        awk '{if (length($2) > 0) {print $2}}' | sort -u
    )
}

# completion for export
_fzf_complete_export() {
    _fzf_complete -m -- "$@" < <(
        declare -xp | sed 's/=.*//' | sed 's/.* //'
    )
}

# completion for kill
_fzf_complete_kill() {
    _fzf_complete -m --preview 'echo {}' --preview-window down:3:wrap --min-height 15 -- "$@" < <(
        command ps -ef | sed 1d
    )
}
_fzf_complete_kill_post() {
    awk '{print $2}'
}

# zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh (https://github.com/zsh-users/zsh-syntax-highlighting)
if [[ ! -e $ZDOTDIR/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/zsh-syntax-highlighting
  zcompile-many $ZDOTDIR/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
fi
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# zsh-autosuggestions - Fish-like autosuggestions for zsh (https://github.com/zsh-users/zsh-autosuggestions)
if [[ ! -e $ZDOTDIR/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZDOTDIR/zsh-autosuggestions
  zcompile-many $ZDOTDIR/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# powerlevel10k - A Zsh theme (https://github.com/romkatv/powerlevel10k)
if [[ ! -e $ZDOTDIR/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZDOTDIR/powerlevel10k
  make -C $ZDOTDIR/powerlevel10k pkg
fi

# instant prompt - should be set before console produce any output
if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit && compinit -C -d $ZDOTDIR/zcompcache/zcompdump
[[ $ZDOTDIR/zcompcache/zcompdump.zwc -nt $ZDOTDIR/zcompcache/zcompdump ]] || zcompile-many $ZDOTDIR/zcompcache/zcompdump
unfunction zcompile-many

source $ZDOTDIR/.z.zsh
source /usr/share/zsh/plugins/zsh-systemd/systemd.plugin.zsh
# zsh-very-colorful-manuals - Custom colorscheme for man pages (https://github.com/MenkeTechnologies/zsh-very-colorful-manuals)
source $ZDOTDIR/zsh-very-colorful-manuals/zsh-very-colorful-manuals.plugin.zsh 


### --- SOURCE PLUGINS --- ###
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/.p10k.zsh

### --- ALIASES --- ###
# yay - An AUR Helper written in Go (https://github.com/Jguer/yay)
if [[ $commands[yay] ]]; then
    alias ipkg='yay -S'
    alias upkg='yay -Y --gendb && yay -Syu --devel --timeupdate'
    alias rpkg='yay -Rsc'
    alias rpkgf='yay -R --nodeps --nodeps'
    alias lpkg='yay --query'
    alias spkg='yay'
else
    alias ipkg='sudo pacman -S'
    alias upkg='sudo pacman -Syyu'
    alias rpkg='sudo pacman -Rsc'
    alias rpkgf='sudo pacman -R --nodeps --nodeps'
    alias lpkg='sudo pacman --query'
    alias spkg='sudo pacman -Ss'
fi
alias cpkg='sudo pacman -Rns $(pacman -Qtdq)'
alias mirror='sudo reflector -f 30 -l 30 --number 15 --verbose --save /etc/pacman.d/mirrorlist'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias su='sudo su'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias sim='sudoedit'
alias vrc="nvim ${XDG_CONFIG_HOME}/nvim/lua/user/init.lua"
alias zrc="nvim ${ZDOTDIR}/.zshrc"

alias lo='exit'
alias :q='exit'
alias cls='clear'
alias df='df -h'
alias du='du -h'
alias free='free -mlt'
alias grep='grep --color --exclude-dir={.git,.svn,CVS}'
alias rg='rg -P -H'
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias -g wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
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
alias mkdir='mkdir -p'
if [[ $commands[advcp] ]]; then
    alias cp='advcp -g'
    alias mv='advmv -g'
fi
#alias cp='rsync -ah --partial --inplace --info=progress2'
alias rmf='rm -rfvi'

# exa - a modern version of ls (https://github.com/ogham/exa)
if [[ $commands[exa] ]]; then
    alias l='exa --all --icons --grid --links --group-directories-first --classify --colour-scale --extended --git'
    alias ll='exa --group --long --all --git --color=auto --time-style=default --icons --extended --group-directories-first --classify --modified --color-scale'
    #alias ll='exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=default'
    function lll() {exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=default $1 | less -r}
    function wch() {exa -lamgF@ $(which $1)}
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
# test -r /opt/urserver/urserver && alias urd="/opt/urserver/urserver --daemon"

### --- FUNCTIONS --- ###
# 256-colors test pattern
colortest() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# ex - extractor for all kinds of archives
ex () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gzip $1        ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.deb)       ar x $1        ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
