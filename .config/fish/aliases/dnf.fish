# DNF
alias install="sudo dnf install -y"
alias search="sudo dnf search"
alias makecache="sudo dnf makecache"
alias refreshcache="sudo dnf makecache --refresh"
alias upd="sudo dnf upgrade --refresh -y && flatpak update -y && clean"
alias remove="sudo dnf remove"
alias clean="sudo dnf autoremove && dnf clean all"
alias autoremove="sudo dnf autoremove"
