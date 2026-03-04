# helper: compile multiple zsh files safely
zcompile-many() {
    emulate -L zsh
    setopt extendedglob

    local file
    for file in "$@"; do
        [[ -f "$file" ]] || continue

        if [[ ! -f "$file.zwc" || "$file" -nt "$file.zwc" ]]; then
          zcompile -R -- "$file.zwc" "$file"
        fi
    done
}

# powerlevel10k instant prompt 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh-very-colorful-manuals - Custom colorscheme for man pages (https://github.com/MenkeTechnologies/zsh-very-colorful-manuals)
if [[ -d "$ZDOTDIR/zsh-very-colorful-manuals" ]]; then 
    source "$ZDOTDIR/zsh-very-colorful-manuals/zsh-very-colorful-manuals.plugin.zsh"
fi

# zsh-autosuggestions - Fish-like autosuggestions for zsh (https://github.com/zsh-users/zsh-autosuggestions)
if [[ -d "$ZDOTDIR/zsh-autosuggestions" ]]; then
    zcompile-many "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh (https://github.com/zsh-users/zsh-syntax-highlighting)
if [[ -d "$ZDOTDIR/zsh-syntax-highlighting" ]]; then
    zcompile-many "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# powerlevel10k - A Zsh theme (https://github.com/romkatv/powerlevel10k)
if [[ -d "$ZDOTDIR/powerlevel10k" ]]; then
    source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"
    source $ZDOTDIR/.p10k.zsh
fi

unfunction zcompile-many
