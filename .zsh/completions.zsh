# completion cache (XDG compliant)
local zcompcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$zcompcache"

# completion behaviour
zstyle ':completion:*' use-cache on
zstyle ':completion::complete:*' cache-path "$zcompcache"
zstyle ':completion:*' rehash true
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:*:*:*' menu select

# matchers (case insensitive + smart separators)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'

# completers
zstyle ':completion:*' completer _complete _match _approximate _ignored

# correction
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:approximate:*' max-errors 'reply=($(( ($#PREFIX + $#SUFFIX) / 3 )) numeric)'

# formatting
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:warnings' format ' %F{green}->%F{red} no matches%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# processes (works with kill)
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# SSH / SCP / RSYNC hosts
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'

# extra completions (https://github.com/zsh-users/zsh-completions) & (https://github.com/MenkeTechnologies/zsh-more-completions)
fpath=(
  $ZDOTDIR/zsh-more-completions/override_src
  $ZDOTDIR/zsh-completions/src
  $ZDOTDIR/zsh-more-completions/man_src
  $ZDOTDIR/zsh-more-completions/architecture_src
  $fpath
)
fpath+=(
  $ZDOTDIR/zsh-more-completions/src
)

# init completion system
autoload -Uz compinit
compinit -C -d "$zcompcache/.zcompdump"
# compile dump for performance
[[ "$zcompcache/.zcompdump.zwc" -nt "$zcompcache/.zcompdump" ]] || zcompile "$zcompcache/.zcompdump"
