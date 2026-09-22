#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"

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

    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "${dest}.bak"
        echo "backed up existing $dest to ${dest}.bak"
    fi

    ln -sf "$src" "$dest"
}

echo "setting up dotfiles from $DOTFILES_DIR..."

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"

if ! command -v starship &> /dev/null && [ ! -f "$HOME/.local/bin/starship" ]; then
    echo "Installing starship to ~/.local/bin..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" -y
else
    echo "starship already installed"
fi

link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES_DIR/.bash_exports" "$HOME/.bash_exports"
link_file "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
link_file "$DOTFILES_DIR/.bash_core"    "$HOME/.bash_core"

BASHRC="$HOME/.bashrc"
touch "$BASHRC"
LINE="[[ -f ~/.bash_core ]] && source ~/.bash_core"
grep -qF "$LINE" "$BASHRC" || echo -e "\n$LINE" >> "$BASHRC"

echo "finished."