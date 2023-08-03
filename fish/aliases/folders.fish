# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ld 'ls -l | grep "^d"'
alias ll='exa -l --color=always --group-directories-first --icons'  # long format

if type -q exa 
    alias l="lsd --date '+%d.%m.%Y %H:%M' -lah"
    alias l.="exa -a | egrep '^\.'" 
    alias la 'exa --long --all --group --header --binary --links --inode --blocks'
    alias ld 'exa --long --all --group --header --list-dirs'
    alias ll 'exa --long --all --group --header --git'
    alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
end