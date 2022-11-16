alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias cl="clear -x"
alias grep='grep --colour=auto'
alias n="node"
alias vi="nvim"
alias x="exit"
alias df="duf"
alias man="tldr"
alias rm="sudo env rm -rdf TERM=screen-256color rm"
alias top="btop"
alias ping="gping"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
alias wipe="sudo wipe -rFc"
alias chlinks="sudo symlinks -r /usr | grep dangling"
alias rmlinks="sudo symlinks -r -d /usr"
alias mutter="gjs mutter-rounded-setting/dist/mutter_settings.js"
