
# Term
switch "$TERM_EMULATOR"
case '*kitty*'
	export TERM='xterm-kitty'
case '*'
	export TERM='xterm-256color'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

#### user configs
source "$HOME/.config/fish/completions/herbstclient.fish"
source "$HOME/.config/fish/aliases/abbreviations.fish"
source "$HOME/.config/fish/aliases/pacman.fish"
source "$HOME/.config/fish/aliases/git.fish"
source "$HOME/.config/fish/aliases/neo.fish"
source "$HOME/.config/fish/aliases/pnpm.fish"
source "$HOME/.config/fish/aliases/timeshift.fish"
source "$HOME/.config/fish/aliases/other.fish"
source "$HOME/.config/fish/utils.fish"

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH
set -gx PATH ~/.local/share/nvm/v18.17.0/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# content has to be in .config/fish/config.fish
# if it does not exist, create the file
setenv SSH_ENV $HOME/.ssh/environment

function start_agent                                                                                                                                                                    
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV 
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities                                                                                                                                                                
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ] 
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end  
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end  
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else 
        start_agent
    end  
end


# Source starship
starship init fish | source
fish_add_path /home/hie/.spicetify
