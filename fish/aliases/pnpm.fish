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

set -gx PNPM_HOME "/home/cstrp/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
export PNPM_HOME="~/.local/share/nvm/v18.8.0/bin/pnpm"
