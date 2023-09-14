set -g fish_greeting

if status is-interactive
end

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH
set -gx PATH ~/.local/share/nvm/v18.17.0/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Source starship
starship init fish | source

#### user configs
source "$HOME/.config/fish/aliases.fish"
source "$HOME/.config/fish/utils.fish"
