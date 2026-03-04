#!/usr/bin/env bash

set -euo pipefail

CSI="\033["
GREEN="${CSI}32m"
CYAN="${CSI}36m"
YELLOW="${CSI}33m"
RED="${CSI}31m"
RESET="${CSI}0m"

ZSH_DIR="${ZDOTDIR:-$HOME/.zsh}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
COMPDUMP="$CACHE_DIR/.zcompdump"

mkdir -p "$ZSH_DIR"
mkdir -p "$CACHE_DIR"

# repo list: name|url
REPOS=(
"dircolors-solarized|https://github.com/seebi/dircolors-solarized.git"
"powerlevel10k|https://github.com/romkatv/powerlevel10k.git"
"zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
"zsh-completions|https://github.com/zsh-users/zsh-completions.git"
"zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
"zsh-more-completions|https://github.com/MenkeTechnologies/zsh-more-completions.git"
"zsh-very-colorful-manuals|https://github.com/MenkeTechnologies/zsh-very-colorful-manuals.git"
)

# completion-related repos
COMPLETION_REPOS=(
"zsh-completions"
"zsh-more-completions"
)

needs_compdump_rebuild=false

echo -e "${CYAN}🛠  Updating ZSH plugins...${RESET}"

for entry in "${REPOS[@]}"; do
    name="${entry%%|*}"
    url="${entry##*|}"
    dir="$ZSH_DIR/$name"

    if [[ -d "$dir/.git" ]]; then
        echo -e "${YELLOW}➡ Checking $name${RESET}"

        before=$(git -C "$dir" rev-parse HEAD)

        git -C "$dir" fetch --quiet --all --prune
        git -C "$dir" pull --ff-only --quiet

        after=$(git -C "$dir" rev-parse HEAD)

        if [[ "$before" != "$after" ]]; then
            echo -e "${GREEN}✔ $name updated${RESET}"

            for comp in "${COMPLETION_REPOS[@]}"; do
                if [[ "$name" == "$comp" ]]; then
                    needs_compdump_rebuild=true
                fi
            done
        else
            echo -e "${CYAN}✔ $name already up to date${RESET}"
        fi

    else
        echo -e "${YELLOW}➡ Cloning $name${RESET}"
        git clone --depth=1 "$url" "$dir" --quiet \
            && echo -e "${GREEN}✔ $name cloned${RESET}" \
            || echo -e "${RED}✘ $name clone failed${RESET}"

        # fresh clone of completion repo → rebuild needed
        for comp in "${COMPLETION_REPOS[@]}"; do
            if [[ "$name" == "$comp" ]]; then
                needs_compdump_rebuild=true
            fi
        done
    fi
done

# rebuild compdump only if needed
if $needs_compdump_rebuild; then
    echo -e "${YELLOW}🔄 Completion plugins changed — clearing compdump${RESET}"
    rm -f "${COMPDUMP}"*
    echo -e "${GREEN}✔ compdump removed (will rebuild on next shell start)${RESET}"
fi

echo -e "${CYAN}✔ All done.${RESET}"
