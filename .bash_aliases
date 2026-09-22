# listing files
if ls --color -d . >/dev/null 2>&1; then
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -lah --color=auto'
else
    alias ls='ls -G'
    alias ll='ls -lhG'
    alias la='ls -lahG'
fi

# navigating back
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# shhhh... don't ask me why these are here
alias mv='mv -i'
alias cp='cp -i'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --all --decorate --oneline --graph'
alias gpush='git push'
alias gpull='git pull'

# misc
alias c='clear'
alias e='exit'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
alias reload='source ~/.bashrc'