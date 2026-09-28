# Dotfiles

run this configuration for Linux and macOS in bash:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trevortr/dotfiles/main/install.sh)"
source ~/.bashrc
```

update existing install:

```bash
git -C ~/.dotfiles pull && bash ~/.dotfiles/install.sh && source ~/.bashrc
```

after local edits:

```bash
source ~/.bashrc
```