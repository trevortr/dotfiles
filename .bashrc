# keep interactive shell setup in the modular dotfiles.
case $- in
    *i*) ;;
    *) return ;;
esac

[[ -f "$HOME/.bash_core" ]] && source "$HOME/.bash_core"
