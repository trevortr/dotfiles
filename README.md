# Dotfiles

Bash configuration for Linux and macOS.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trevortr/dotfiles/main/install.sh)"
source ~/.bashrc
```

Update with:

```bash
git -C ~/.dotfiles pull && bash ~/.dotfiles/install.sh && source ~/.bashrc
```

For local changes, just `source ~/.bashrc`.

Put machine-specific configuration in `~/.bashrc.local`.
