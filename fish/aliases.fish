# pacman aliases
alias pac='sudo pacman -S'                                   # install
alias pacu='sudo pacman -Syu'                                # update, add 'a' to the list of letters to update AUR packages if you use yaourt
alias pacr='sudo pacman -Rs'                                 # remove
alias pacs='sudo pacman -Ss'                                 # search
alias paci='sudo pacman -Si'                                 # info
alias paclo='sudo pacman -Qdt'                               # list orphans
alias pacro='sudo paclo && sudo pacman -Rns $(pacman -Qtdq)' # remove orphans
alias pacc='sudo pacman -Scc'                                # clean cache
alias paclf='sudo pacman -Ql'                                # list files
alias upd='paru -Syu'


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

# GITHUB
alias g="git"

# Add
alias ga="git add ."
alias gaa="git add -all"
alias gai="git add -i"

# Branch
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gbdd="git branch -D"
alias gbr="git branch -r"

# Commit
alias gc="git commit"
alias gca="git commit -a"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gcem="git commit --allow-empty -m"
alias gcd="git commit --amend"
alias gcad="git commit -a --amend"
alias gced="git commit --allow-empty --amend"

# Clone
alias gcl="git clone"
alias gcld="git clone --depth 1"

# CherryPuck
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

# Checkout
alias gch="git checkout"
alias gom="git checkout main"
alias gob="git checkout -b"
alias god="git checkout develop"

# Push
alias gps="git push"
alias gpsf="git push -f"
alias gpsu="git push -u"
alias gpst="git push --tags"
alias gpso="git push origin"
alias gpsao="git push --all origin"
alias gpsfo="git push -f origin"
alias gpsuo="git push -u origin"

# Pull
alias gpl="git pull"
alias gpb="git pull --rebase"
alias gplo="git pull origin"
alias gpbo="git pull --rebase origin"
alias gplom="git pull origin master"
alias gpbom="git pull --rebase origin master"

# Remote
alias gr="git remote"
alias gra="git remote add"
alias grr="git remote rm"
alias grv="git remote -v"
alias grn="git remote rename"
alias grp="git remote prune"
alias grs="git remote show"
alias grao="git remote add origin"
alias grau="git remote add upstream"
alias grro="git remote remove origin"
alias grru="git remote remove upstream"
alias grso="git remote show origin"
alias grsu="git remote show upstream"
alias grpo="git remote prune origin"
alias grpu="git remote prune upstream"

# Status
alias gs="git status"
alias gsb="git status -s -b"

# PNPM
alias pn="pnpm"
alias px="pnpm dlx"
alias pi="pnpm install"
alias pin="pnpm init"
alias pa="pnpm add"
alias pas="pnpm add --save"
alias pasd="pnpm add --save-dev"
alias pag="pnpm add -g"
alias pp="pnpm prune"
alias pl="pnpm list"
alias pr="pnpm remove"
alias pu="pnpm update"
alias pal="pi && pn start"

# Timeshift
alias tm="sudo timeshift"
alias tmc="sudo timeshift --create"
alias tmd="sudo timeshift --delete"
alias tmda="sudo timeshift --delete-all"
alias tml="sudo timeshift --list"

# IDK
alias neo="neofetch --source /home/_cstrp/.config/neofetch/logo"
alias kernel="uname -rs"
alias k="uname -rs"
alias f="lsb_release -sd"
alias age="stat / | grep "Birth""
alias hot_up="nmcli connection up 1337"
alias hot_down="nmcli connection down 1337"
alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias cat="bat --theme 1337"
alias cl="clear -x"
alias grep='grep --colour=auto'
alias clr="sudo pacman -Rns $(pacman -Qtdq) --noconfirm && yay -Sc --noconfirm"
alias n="node"
alias vi="nvim"
alias x="exit"
alias df="duf"
alias man="tldr"
alias rm="rm -rdf"
alias top="btop"
alias ping="gping"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
alias chlinks="sudo symlinks -r /usr | grep dangling"
alias rmlinks="sudo symlinks -r -d /usr"
alias today='date +"%A, %B %d, %Y"'
alias t='projectdo test'
alias r='projectdo run'
alias b='projectdo build'
alias p='projectdo tool'
alias germanyUp="wg-quick up germany"
alias germanyDown="wg-quick down germany"
alias usaUp="wg-quick up usa"
alias usaDown="wg-quick down usa"
alias japanUp="wg-quick up japan"
alias japanDown="wg-quick down japan"

