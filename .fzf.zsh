if [[ ! "$PATH" == *$ZDOTDIR/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$ZDOTDIR/fzf/bin"
fi
[[ $- == *i* ]] && source "$ZDOTDIR/fzf/shell/completion.zsh" 2> /dev/null
source "$ZDOTDIR/fzf/shell/key-bindings.zsh"
