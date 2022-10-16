### --- ENVIROMENTAL VARIABLES --- ###

export TERM=xterm-256color
export COLORTERM=truecolor
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MANROFFOPT='-c'
export LESSHISTFILE=-
export PATH=$PATH:$HOME/.local/bin:/home/g4cm4n/.local/share/gem/ruby/3.0.0/bin
eval "$(perl -I$HOME/.local/perl5 -Mlocal::lib=$HOME/.local/perl5/lib)"
export EDITOR=nvim
export VISUAL=nvim

# set WORDCHARDS to delete backwards to slash, no further
export WORDCHARS=${WORDCHARS/\/}

# remove empty space from right part of the prompt
export ZLE_RPROMPT_INDENT=0

# translate %USERPROFILE% and %LOCALAPPDATA% to unix envs
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    export PATH=$PATH:/mnt/c/Windows/System32
    pushd /mnt/c > /dev/null # avoid UNC path error, then restore current path
    export WINHOME=$(wslpath $(cmd.exe /C "echo %USERPROFILE%" | tr -d '\r'))
    popd > /dev/null
    pushd /mnt/c > /dev/null
    export WINAPPDATA=$(wslpath $(cmd.exe /C "echo %LOCALAPPDATA%" | tr -d '\r' ))
    popd > /dev/null
    # s - web search from the terminal (https://github.com/zquestz/s)
    # using wslview from wslu (https://github.com/wslutilities/wslu) as binary and brave search as engine
    alias s='s -b wslview -p brave'
    # open windows terminal settings in neovim
    pushd $WINAPPDATA > /dev/null
    export WSL_JSON=$WINAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
    popd > /dev/null
    alias edal="nvim \${WSL_JSON}"
    alias dwnl="cd \${WINHOME}/Downloads"
else
    alias s='s -p brave'
fi

# dircolors-solarized (https://github.com/seebi/dircolors-solarized)
if [[ -r $ZDOTDIR/dircolors/dircolors.ansi-dark ]]; then
    eval `dircolors $ZDOTDIR/dircolors/dircolors.ansi-dark`;
    # vivid - A themeable LS_COLORS generator with a rich filetype datebase (https://github.com/sharkdp/vivid)
    if [[ [$commands]vivid ]] then;
        export LS_COLORS="$(vivid generate solarized-dark)"
    fi
fi

# fzf - A command-line fuzzy finder (https://github.com/junegunn/fzf)
[ -f $ZDOTDIR/.fzf.zsh ] && source $ZDOTDIR/.fzf.zsh

# source completions to fpath (https://github.com/zsh-users/zsh-completions) & (https://github.com/MenkeTechnologies/zsh-more-completions)
[ -f $ZDOTDIR/zsh-completions/src ]
[ -f $ZDOTDIR/zsh-more-completions/src ]
[ -f $ZDOTDIR/zsh-more-completions/override_src ]
[ -f $ZDOTDIR/zsh-more-completions/man_src ]

# instant prompt - should be set before console produce any output
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### --- ZSH OPTIONS --- ####

# zsh 'cd' and directory stack command behaviour
setopt	  AUTO_CD              # type the name of a directory and it will become current directory
setopt		AUTO_PUSHD           # make 'cd' push the old directory onto the directory stack
unsetopt	CDABLE_VARS          # type the name of variable and if it matches valid direcory it will become current directory
unsetopt	CHASE_LINKS          # resolve symbolic links to their true values when changing directory
setopt		PUSHD_IGNORE_DUPS    # don't push multiple copies of the same directory onto the directory stack
setopt		PUSHD_MINUS          # exchanges the meanings of `+' and `-' when used with a number to specify a directory in the stack
setopt		PUSHD_SILENT         # parameter expansion, command substitution and arithmetic expansion are performed in prompts
# completion
setopt		ALWAYS_LAST_PROMPT   # try to return to the last prompt if given no numeric argument
setopt		AUTO_LIST            # automatically list choices on an ambiguous completion
setopt		AUTO_MENU            # automatically use menu completion after the second consecutive request for completion
setopt		AUTO_NAME_DIRS       # any parameter that is set to the absolute name of a directory will be available for completion
setopt		AUTO_PARAM_KEYS      # automatically prepare viable key after parameter completion
setopt		AUTO_PARAM_SLASH     # add a slash after completion if it was performed on direcory name
unsetopt	AUTO_REMOVE_SLASH    # do not remove slash after completion, let user handle it
setopt	  BASH_AUTO_LIST       # on an ambiguous completion, automatically list viable hoices, like in bash
unsetopt	COMPLETE_ALIASES     # do not make alias a distinct command for completion
setopt		COMPLETE_IN_WORD     # completion is done from both ends
unsetopt	GLOB_COMPLETE        # when current word has a glob pattern generate matches as for completion and cycle through them
setopt		HASH_LIST_ALL        # make sure the entire command path is hashed first
setopt		LIST_AMBIGUOUS       # if there is an unambiguous prefix to insert, it's done without list being displayed or after third call
unsetopt	LIST_BEEP            # do not beep on an ambigous completion
setopt		LIST_PACKED          # try to make completion list smaller
setopt		LIST_ROWS_FIRST      # matches are listed in a horizontal fashion
setopt		LIST_TYPES           # when listing files that are possible completions, show the type of each one
unsetopt	MENU_COMPLETE        # don't iterate through every possible match in menu
unsetopt	REC_EXACT            # don't accept exact match if there are other possible completions
# expansion & globbing
setopt		BAD_PATTERN          # if a pattern for filename generation is badly formed, print an error message
setopt		BARE_GLOB_QUAL       # in a glob pattern, treat a trailing set of parentheses as a qualifier list, if it doesn't contain `|', `(, `~'
setopt		BRACE_CCL            # expands pattern in braces like: $ print 1{abw-z}2 to $ 1a2 1b2 1w2 1x2 1y2 1z2
unsetopt	CASE_GLOB            # case insensitive globbing
setopt		EXTENDED_GLOB        # treat the '#', '~' and '^' characters as part of patterns for filename generation, grepping etc.
setopt		GLOB                 # perform filename generation
unsetopt	GLOB_ASSIGN          # prevent globbing from unpredictable results
unsetopt	GLOB_SUBST           # don't treat every characters as eligible for expansion
unsetopt	IGNORE_BRACES        # do not perform brace expansion
unsetopt	KSH_GLOB             # use native syntax for globbing
setopt		MARK_DIRS            # append a trailing `/' to directory
setopt		MULTIBYTE            # utf-8 support for zsh
setopt		NOMATCH              # if a pattern for filename generation has no matches print an error
unsetopt	CSH_NULL_GLOB        # if a pattern for filename generation has no matches print an error, overrides NOMATCH
setopt		NUMERIC_GLOBSORT     # if numeric filenames are matched by generation pattern, sort the filenames numerically
setopt		RC_EXPAND_PARAM      # set array expansions
unsetopt	REMATCH_PCRE         # regular expressions will use the extended regexp syntax provided by the system libraries
setopt		UNSET                # don't error out when unset parameters are used
unsetopt	WARN_CREATE_GLOBAL   # disable warnings if a global variable is defined implicitly
# input/output
setopt		ALIASES              # expand aliases
setopt	  NO_CLOBBER           # don’t write over existing files with >, use >! instead
setopt		CORRECT              # spelling correction for commands
unsetopt	CORRECT_ALL          # spelling correction for commands and everything else
unsetopt	IGNORE_EOF           # do not exit on end-of-file, require the use of exit or logout instead
setopt		INTERACTIVE_COMMENTS # allow comments, even in interactive shells
setopt		HASH_CMDS            # place the location of each command in the hash table the first time it is executed
setopt		HASH_DIRS            # hash the directory of command's path whenever you execute it and all directories that occur earlier in the path
unsetopt	PRINT_EXIT_VALUE     # print a newline showing previous command's return value
unsetopt	RM_STAR_SILENT       # don't query the user before executing 'rm *'
unsetopt	RM_STAR_WAIT         # don't wait before executing 'rm *''
setopt		SHORT_LOOPS          # allow the short forms of for, select, if, and function constructs
# job control
setopt		AUTO_CONTINUE        # stopped jobs
unsetopt	AUTO_RESUME          # treat single word commands without redirection as candidates for resumption of an existing job
setopt		BG_NICE              # run all background jobs at a lower priority
setopt		CHECK_JOBS           # report the status of background and suspended jobs before exiting a shell
setopt    NO_HUP               # don't send HUP to jobs when shell exits
unsetopt	FLOWCONTROL          # disable output flow control via start/stop character in the shell's editor
setopt		LONG_LIST_JOBS       # list jobs in long format by default
setopt		MONITOR              # allow job control
setopt		NOTIFY               # report the status of background jobs immediately
# prompt
unsetopt	PROMPT_BANG          # if set, `!' is treated specially in prompt expansion
setopt		PROMPT_CR            # print a carriage return just before printing a prompt in the line editor
setopt		PROMPT_SP            # attempt to preserve a partial line that would otherwise be cover up by PROMPT_CR
setopt		PROMPT_PERCENT       # if set, `%' is treated specially in prompt expansion
setopt		PROMPT_SUBST         # if set, parameter expansion, command substitution and arithmetic expansion are performed in prompts
# scripts & functions
setopt		C_BASES              # output hexadecinal number in the standard C format: 0xFF instead of 16#FF
unsetopt 	C_PRECEDENCES        # use precendence of operators found in C
unsetopt	DEBUG_BEFORE_CMD     # run the DEBUG trap after each command
unsetopt	ERR_EXIT             # if a command has a non-zero exit status, don't execute the ZERR trap and exit
unsetopt	ERR_RETURN           # if set and command has a non-zero exit status, return immediately from the enclosing function
setopt		EVAL_LINENO          # line numbers of expressions evaluated by 'eval' are tracked separately of the enclosing environment
setopt		EXEC                 # do execute commands
setopt		FUNCTION_ARGZERO     # set $0 temporarily to the name of the function/script when executing
setopt		LOCAL_OPTIONS        # allow functions to have local options
setopt		LOCAL_TRAPS          # allow functions to have local traps
setopt		MULTIOS              # perform multiple implicit tees and cats with redirection
unsetopt	VERBOSE              # don't print shell input as they are read
# zle
unsetopt	BEEP                 # don't beep on error
unsetopt	COMBINING_CHARS      # don't not handle combining characters specially
setopt		EMACS                # emacs keybindings
unsetopt	OVERSTRIKE           # don't start up the line editor in overstrike mode
unsetopt	SINGLE_LINE_ZLE      # don't use single line command line
setopt		ZLE                  # use the zsh line editor
# basic keybindings
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-kill-word
# history
HISTFILE=$ZDOTDIR/.zsh_history    # specify history file location
HISTSIZE=10000                    # how many lines of history keep in memory
SAVEHIST=15000                    # how many lines of history keep in history file
setopt HIST_IGNORE_ALL_DUPS       # if a new command is a duplicate, remove the older one
setopt EXTENDED_HISTORY           # save each command's beginning timestamp and the duration
setopt HIST_IGNORE_DUPS           # do not save command lines into history list if they are duplicates
setopt HIST_EXPIRE_DUPS_FIRST     # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_SPACE          # remove command lines from the history list when the first character is space
setopt HIST_REDUCE_BLANKS         # remove superfluous blanks from each command line being added to the history list
setopt HIST_VERIFY                # show command with history expansion to user before running it
setopt SHARE_HISTORY              # share command history data

### --- COMPLETIONS  --- ###

autoload -Uz compinit
compinit -d "$ZDOTDIR/.zcompdump"
_comp_options+=(globdots)
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZDOTDIR
# use ls-colors for path completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# enable approximate completions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'
# automatically update PATH entries
zstyle ':completion:*' rehash true
# use menu completion
zstyle ':completion:*' menu select
# complete directory stack entries
zstyle ':completion:*' complete-options true
# verbose completion results
zstyle ':completion:*' verbose true
# smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
# case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' keep-prefix true
# group results by category
zstyle ':completion:*' group-name ''
# don't insert a literal tab when trying to complete in an empty buffer
zstyle ':completion:*' insert-tab false
# keep directories and files separated
zstyle ':completion:*' list-dirs-first true
# don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true
# always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'
# show message while waiting for completion
zstyle ':completion:*' show-completer true
# prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# 'kill' and 'ssh' completion using fzf (https://github.com/junegunn/fzf/blob/master/shell/completion.zsh)
_fzf_complete_kill() {
    _fzf_complete -m --preview 'echo {}' --preview-window down:3:wrap --min-height 15 -- "$@" < <(
        command ps -ef | sed 1d
    )
}
_fzf_complete_kill_post() {
    awk '{print $2}'
}
_fzf_complete_ssh() {
    _fzf_complete +m -- "$@" < <(
        setopt localoptions nonomatch
        command cat <(command tail -n +1 ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?%]') \
            <(command grep -oE '^[[a-z0-9.,:-]+' ~/.ssh/known_hosts | tr ',' '\n' | tr -d '[' | awk '{ print $1 " " $1 }') \
            <(command grep -v '^\s*\(#\|$\)' /etc/hosts | command grep -Fv '0.0.0.0') |
        awk '{if (length($2) > 0) {print $2}}' | sort -u
    )
}


### --- PLUGINS LOADING --- ###

# powerlevel10k - A Zsh theme (https://github.com/romkatv/powerlevel10k)
source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

# zsh-autosuggestions - Fish-like autosuggestions for zsh (https://github.com/zsh-users/zsh-autosuggestions)
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# The Fuck - Magnificent app which corrects your previous console command (https://github.com/nvbn/thefuck)
#source '/usr/share/zsh/plugins/zsh-thefuck-git/zsh-thefuck.plugin.zsh'
#eval $(thefuck --alias --enable-experimental-instant-mode)

# zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh (https://github.com/zsh-users/zsh-syntax-highlighting)
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)


### --- ALIASES --- ###

# yay - An AUR Helper written in Go (https://github.com/Jguer/yay)
if [[ $commands[yay] ]]; then
    alias ipkg='yay -S'
    alias upkg='yay -Y --gendb && yay -Syu --devel --timeupdate'
    alias rpkg='yay -Rsc'
    alias rpkgf='yay -Rd --nodeps'
else
    alias ipkg='sudo pacman -S'
    alias upkg='sudo pacman -Syyu'
    alias spkg='sudo pacman -Ss'
    alias rpkg='sudo pacman -Rsc'
    alias rpkgf='sudo pacman -Rd --nodeps'
fi
alias cpkg='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'
if [[ $commands[expac] ]]; then
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"
fi
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias su='sudo su'

alias -g vim='$EDITOR'
alias -g vi='$EDITOR'
alias -g v='$EDITOR'
alias vrc='$EDITOR $HOME/.config/astronvim/lua/user/init.lua'
alias zrc='$EDITOR $ZDOTDIR/.zshrc'

alias lo='exit'
alias :q='exit'
alias cls='clear'
alias df='df -h'
alias du='du -h'
alias free='free -mlt'
alias grep='grep --color -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias wget='wget --hsts-file="${HOME}/.cache/.wget-hsts"'
alias userlist='cut -d: -f1 /etc/passwd'
alias jctl='journalctl -p 3 -xb'
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'
alias gcl='git clone'
alias rb='sudo reboot'
alias ssn='sudo shutdown now'

# bat - a cat clone with wings (https://github.com/sharkdp/bat)
if [[ $commands[bat] ]]; then
    alias c='bat --theme="Solarized (dark)"'
    alias cat='bat --paging=never --style="plain"'
    alias bfzf='fzf --preview="bat {} --color=always"'
    alias rg='batgrep'
    alias man='batman'
fi

alias dc='cd'
alias bd='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
# alias cp='rsync -ah --partial --inplace --info=progress2'

# exa - a modern version of ls (https://github.com/ogham/exa)
if [[ $commands[exa] ]]; then
    alias ll='exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=default'
    alias lll='exa -lamgF@ --group-directories-first --git --color=always --color-scale --time-style=default less -r'
else
    alias ll='ls -lAFHh --color=auto --group-directories-first'
    alias lll='ls -lAFHh --color=auto -group-directories-first | less -r'
fi
alias l='ls -lACFH --color --color=auto --group-directories-first'

# test terminal color ability
alias colortest='for i in {0..255}; do print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'}; done'
# print real hostname
alias gethostname='cat /proc/sys/kernel/hostname'
# display all active ips
alias actips="echo '$(ip -o addr show up primary scope global | while read -r num dev fam addr rest; do echo ${addr%/*}; done)'"
# get lan ip
alias lanip='ip addr show |grep "inet " |grep -v 127.0.0. |head -1|cut -d" " -f6|cut -d/ -f1'
# print public ip
alias pubip='curl icanhazip.com'

# youtube-dl - command-line program to download videos from YouTube.com and other video sites (https://github.com/ytdl-org/youtube-dl)
if [[ $commands[youtube-dl] ]]; then
    # download youtube video in fhd resolution and convert it to mp4
    alias ytd='youtube-dl --format "bestvideo[height<=1080,ext=mp4]+bestaudio[ext=m4a]"'
    # download video from youtube and convert it to mp3@320kbps file
    alias ytdmp3='youtube-dl -x --audio-format mp3 --audio-quality 320k'
fi

# unified remote - turn your smartphone into a universal remote control (https://github.com/unifiedremote)
if [[ $commands[urserver] ]]; then
    alias urd='/opt/urserver/urserver --daemon'
fi

# ex function - extractor for all kinds of archives
ex ()    {
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
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
