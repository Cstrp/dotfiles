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
