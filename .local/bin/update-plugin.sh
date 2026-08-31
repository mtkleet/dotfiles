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
    # fetch everything
    git -C "$dir" fetch --quiet --all --prune

    # detect the remote default branch (main/master/other)
    default_branch=$(git -C "$dir" remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}')

    # fallback if detection fails
    if [[ -z "$default_branch" ]]; then
      default_branch="main"
    fi

    current_branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD)

    # if the current branch is missing on origin, switch to the default branch
    if ! git -C "$dir" rev-parse --verify "origin/$current_branch" &>/dev/null; then
      echo -e "${YELLOW}⚠ Fixing branch for $name → $default_branch${RESET}"
      git -C "$dir" checkout "$default_branch" --quiet 2>/dev/null ||
        git -C "$dir" checkout -b "$default_branch" "origin/$default_branch" --quiet

      git -C "$dir" branch -u "origin/$default_branch" "$default_branch" 2>/dev/null || true
    fi

    # pull fast-forward only
    if git -C "$dir" pull --ff-only --quiet 2>/dev/null; then
      :
    else
      echo -e "${YELLOW}⚠ Pull failed, retrying with correct upstream for $name${RESET}"
      git -C "$dir" branch -u "origin/$default_branch" "$default_branch" 2>/dev/null || true
      git -C "$dir" pull --ff-only --quiet || true
    fi

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
    if git clone --depth=1 "$url" "$dir" --quiet; then
      echo -e "${GREEN}✔ $name cloned${RESET}"
    else
      echo -e "${RED}✘ $name clone failed${RESET}"
    fi

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
