set -g fish_greeting


set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# Source starship
starship init fish | source

#### user configs
source "$HOME/.config/fish/aliases.fish"
source "$HOME/.config/fish/utils.fish"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
