# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mtkleet/.zsh/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mtkleet/.zsh/fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/home/mtkleet/.zsh/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/home/mtkleet/.zsh/fzf/shell/key-bindings.zsh"
