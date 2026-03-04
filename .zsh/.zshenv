setopt NO_GLOBAL_RCS
ZDOTDIR=${ZDOTDIR:-$HOME/.zsh}

export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:-/etc/xdg}

export GNUPGHOME=${XDG_DATA_HOME}/gnupg
export GOPATH=${XDG_DATA_HOME}/go
export NPM_CONFIG_CACHE=${XDG_CACHE_HOME}/npm
export PNPM_HOME=${XDG_DATA_HOME}/pnpm
export CARGO_HOME=${XDG_DATA_HOME}/cargo
export PARALLEL_HOME=${XDG_CONFIG_HOME}/parallel
export FLATPAK_USER_APP_DIR=${XDG_DATA_HOME}/flatpak/var
export WINEPREFIX=${XDG_DATA_HOME}/wineprefixes/default
export GRADLE_USER_HOME=${XDG_DATA_HOME}/gradle
export GTK2_RC_FILES=${XDG_CONFIG_HOME}/gtk-2.0/gtkrc
export SCREENRC=${XDG_CONFIG_HOME}/screenrc
export CUDA_CACHE_PATH=${XDG_CACHE_HOME}/nv
export _GL_SHADER_DISK_CACHE_PATH=${XDG_CACHE_HOME}/nv
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"
