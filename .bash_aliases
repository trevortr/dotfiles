# listing files
if command ls --color -d . >/dev/null 2>&1; then
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

# shhhh... don't ask me why these are here. I've never overwritten any important files. I promise.
alias mv='mv -i'
alias cp='cp -i'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --all --decorate --oneline --graph'
alias gpush='git push'
alias gpull='git pull'

# docker
alias d="docker"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}'"
alias dpsa="docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}'"
alias di="docker images"
alias dvol="docker volume ls"
alias dnet="docker network ls"
alias dstats="docker stats --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'"
alias dprune="docker system prune -af --volumes"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcd="docker compose down"
alias dcdv="docker compose down -v"          
alias dcl="docker compose logs -f --tail=100"
alias dcps="docker compose ps"

# socket/interface linux-only
case "$(uname -s)" in
    Linux)
        alias ports='ss -nutpel'
        alias estab='ss -tunp state established'
        alias myip='ip -br -c a'
        alias route='ip -c route'
        alias arp-cache='ip neigh'
        ;;
esac

# icmp, dns, tcpdump
alias mywan='curl -4 -s https://ifconfig.me; echo'
alias pong='ping -c 5 -i 0.2'
alias digtrace='dig +trace +nodnssec'
alias tcpdump-clean='sudo tcpdump -nn -s0 -v'
alias tcpdump-syn='sudo tcpdump -nn "tcp[tcpflags] & (tcp-syn|tcp-rst) != 0"'

# misc
alias c='clear'
alias e='exit'
alias path='printf "%s\n" "$PATH" | tr ":" "\n"'
alias mkdir='mkdir -pv'
alias reload='source ~/.bashrc'
