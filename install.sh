#!/usr/bin/env bash
set -euo pipefail

if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
else
    DOTFILES_DIR="$HOME/.dotfiles"
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/trevortr/dotfiles.git "$DOTFILES_DIR"
fi

link_file() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "source file $src does not exist" >&2
        return 1
    fi

    if [ -L "$dest" ]; then
        [ "$(readlink "$dest")" != "$src" ] || return 0
        unlink "$dest"
    elif [ -d "$dest" ]; then
        echo "refusing to replace directory $dest" >&2
        return 1
    elif [ -e "$dest" ]; then
        local backup="${dest}.bak"
        local index=1
        while [ -e "$backup" ] || [ -L "$backup" ]; do
            backup="${dest}.bak.$index"
            index=$((index + 1))
        done
        mv "$dest" "$backup"
        echo "backed up existing $dest to $backup"
    fi

    ln -s "$src" "$dest"
}

mkdir -p "$HOME/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$CONFIG_DIR"

if ! command -v starship &> /dev/null && [ ! -x "$HOME/.local/bin/starship" ]; then
    echo "installing starship to ~/.local/bin..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" -y
else
    echo "starship already installed"
fi

link_file "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
link_file "$DOTFILES_DIR/.bash_exports" "$HOME/.bash_exports"
link_file "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
link_file "$DOTFILES_DIR/.bash_core"    "$HOME/.bash_core"
link_file "$DOTFILES_DIR/.bash_utils"    "$HOME/.bash_utils"
link_file "$DOTFILES_DIR/.bashrc"         "$HOME/.bashrc"

login_file_sources_bashrc() {
    grep -Ev '^[[:space:]]*(#|$)' "$1" |
        grep -Eq '(^|[[:space:];|&])(\.|source)[[:space:]]+[^#;]*[.]bashrc'
}

LOGIN_FILE="$HOME/.bash_profile"
for candidate in "$HOME/.bash_profile" "$HOME/.bash_login" "$HOME/.profile"; do
    if [ -f "$candidate" ]; then
        LOGIN_FILE="$candidate"
        break
    fi
done
touch "$LOGIN_FILE"
LOGIN_LINE='if [ -n "${BASH_VERSION:-}" ]; then case $- in *i*) [ ! -f "$HOME/.bashrc" ] || . "$HOME/.bashrc" ;; esac; fi'
if ! login_file_sources_bashrc "$LOGIN_FILE"; then
    printf '\n%s\n' "$LOGIN_LINE" >> "$LOGIN_FILE"
fi

echo "finished."
