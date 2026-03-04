# remove empty space from right part of the prompt
typeset -g ZLE_RPROMPT_INDENT=0

# set WORDCHARDS for 'backward-kill-word' to stop at forward slash
WORDCHARS=${WORDCHARS/\/}

# directory behaviour
setopt    AUTO_CD                      # type the name of a directory and it will become current directory
setopt    AUTO_PUSHD                   # make 'cd' push the old directory onto the directory stack
setopt    PUSHD_IGNORE_DUPS            # don't push multiple copies of the same directory onto the directory stack
setopt    PUSHD_MINUS                  # exchanges the meanings of `+' and `-' when used with a number to specify a directory in the stack
setopt    PUSHD_SILENT                 # don't print directory stack after pushd/popd
unsetopt  CDABLE_VARS                  # type the name of variable and if it matches valid direcory it will become current directory
unsetopt  CHASE_LINKS                  # resolve symbolic links to their true values when changing directory
# completion
setopt    AUTO_MENU                    # automatically use menu completion after the second consecutive request for completion
setopt    COMPLETE_IN_WORD             # completion is done from both ends
setopt    ALWAYS_TO_END                # moves cursor to end of word if a full completion is inserted
setopt    BASH_AUTO_LIST               # on an ambiguous completion, automatically list viable hoices, like in bash
setopt    GLOB_DOTS                    # include hidden files in tab completion
setopt    LIST_PACKED                  # try to make completion list smaller
setopt    LIST_ROWS_FIRST              # matches are listed in a horizontal fashion
setopt    LIST_TYPES                   # when listing files that are possible completions, show the type of each one
unsetopt  MENU_COMPLETE                # don't iterate through every possible match in menu
unsetopt  REC_EXACT                    # don't accept exact match if there are other possible completions
unsetopt  LIST_BEEP                    # do not beep on an ambigous completion
## expansion & globbing
setopt    BAD_PATTERN                  # if a pattern for filename generation is badly formed, print an error message
setopt    EXTENDED_GLOB                # treat the '#', '~' and '^' characters as part of patterns for filename generation, grepping etc.
setopt    MARK_DIRS                    # append a trailing `/' to directory
unsetopt  GLOB_ASSIGN                  # prevent globbing from unpredictable results
unsetopt  GLOB_SUBST                   # don't treat every characters as eligible for expansion
unsetopt  IGNORE_BRACES                # do not perform brace expansion
unsetopt  KSH_GLOB                     # use native syntax for globbing
## safety & i/o
setopt    UNSET                        # allow use of unset parameters (expand to empty string)
setopt    NO_CLOBBER                   # don’t write over existing files with >, use >! instead
setopt    CORRECT                      # spelling correction for commands
setopt    HASH_DIRS                    # hash the directory of command's path whenever you execute it and all directories that occur earlier in the path
unsetopt  FLOWCONTROL                  # disable Ctrl-S freeze
unsetopt  NO_NOMATCH                   # if a pattern for filename generation has no matches don't print an error
## job control
setopt    AUTO_CONTINUE                # stopped jobs
setopt    BG_NICE                      # run all background jobs at a lower priority
setopt    CHECK_JOBS                   # report the status of background and suspended jobs before exiting a shell
setopt    LONG_LIST_JOBS               # list jobs in long format by default
## prompt
setopt    PROMPT_SP                    # attempt to preserve a partial line that would otherwise be cover up by PROMPT_CR
setopt    PROMPT_SUBST                 # if set, parameter expansion, command substitution and arithmetic expansion are performed in prompts
## zle
setopt    EMACS                        # emacs keybindings
unsetopt  BEEP                         # don't beep on error
unsetopt  COMBINING_CHARS              # don't handle combining characters specially
# history
setopt    INC_APPEND_HISTORY           # append each command to HISTFILE immediately (not only at shell exit)
setopt    SHARE_HISTORY                # share command history data
setopt    EXTENDED_HISTORY             # save timestamp of  each command's beginning and the its duration
setopt    HIST_IGNORE_ALL_DUPS         # if a new command is a duplicate, remove the older one
setopt    HIST_IGNORE_SPACE            # remove command lines from the history list when the first character is space
setopt    HIST_EXPIRE_DUPS_FIRST       # when trimming history, remove oldest duplicate entries first
setopt    HIST_REDUCE_BLANKS           # remove superfluous blanks from each command line being added to the history list
setopt    HIST_VERIFY                  # show command with history expansion to user before running it
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/.zsh_history"
mkdir -p "${HISTFILE:h}"               # specify history file and create direcory if necessary
HISTSIZE=100000                        # how many lines of history keep in memory
SAVEHIST=100000                        # how many lines of history keep in history file

# terminfo keybindings
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
[[ -n ${terminfo[kLFT5]} ]] && bindkey -- "${terminfo[kLFT5]}" backward-word                 # ctrl-left
[[ -n ${terminfo[kRIT5]} ]] && bindkey -- "${terminfo[kRIT5]}" forward-word                  # ctrl-right
