# Create the default command_not_found handler
function __fish_default_command_not_found_handler
    printf (_ "fish: Unknown command: %s\n") (string escape -- $argv[1]) >&2
end

if not status --is-interactive
    # Hook up the default as the command_not_found handler
    # if we are not interactive to avoid custom handlers.
    function fish_command_not_found --on-event fish_command_not_found
        __fish_default_command_not_found_handler $argv
    end
end

# Launch debugger on SIGTRAP
function fish_sigtrap_handler --on-signal TRAP --no-scope-shadowing --description "TRAP handler: debug prompt"
    breakpoint
end

# When a prompt is first displayed, make sure that interactive
# mode-specific initializations have been performed.
# This handler removes itself after it is first called.
function __fish_on_interactive --on-event fish_prompt
    __fish_config_interactive
    functions -e __fish_on_interactive
end

# Add a handler for when fish_user_path changes, so we can apply the same changes to PATH
function __fish_reconstruct_path -d "Update PATH when fish_user_paths changes" --on-variable fish_user_paths
    # Deduplicate $fish_user_paths
    # This should help with people appending to it in config.fish
    set -l new_user_path
    for path in (string split : -- $fish_user_paths)
        if not contains -- $path $new_user_path
            set -a new_user_path $path
        end
    end

    if test (count $new_user_path) -lt (count $fish_user_paths)
        # This will end up calling us again, so we return
        set fish_user_paths $new_user_path
        return
    end

    set -l local_path $PATH

    for x in $__fish_added_user_paths
        set -l idx (contains --index -- $x $local_path)
        and set -e local_path[$idx]
    end

    set -g __fish_added_user_paths
    if set -q fish_user_paths
        # Explicitly split on ":" because $fish_user_paths might not be a path variable,
        # but $PATH definitely is.
        for x in (string split ":" -- $fish_user_paths[-1..1])
            if set -l idx (contains --index -- $x $local_path)
                set -e local_path[$idx]
            else
                set -ga __fish_added_user_paths $x
            end
            set -p local_path $x
        end
    end

    set -xg PATH $local_path
end

# Set the locale if it isn't explicitly set. Allowing the lack of locale env vars to imply the
# C/POSIX locale causes too many problems. Do this before reading the snippets because they might be
# in UTF-8 (with non-ASCII characters).
__fish_set_locale

# autojump
if test -f /home/cstrp/.autojump/share/autojump/autojump.fish; . /home/cstrp/.autojump/share/autojump/autojump.fish; end

# Theme
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_git_worktree_support yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_ruby yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_nvm yes
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_user yes
set -g theme_date_format "+%H:%M"
set -g theme_project_dir_length 0
set -g theme_newline_prompt ' ><((°>)) 🐧 '

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
set -x GREP_COLOR '37;45'
set -g -x fish_greeting ' '
set -g FILTER ''
set -x PIP_REQUIRE_VIRTUALENV 0
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -U __done_exclude '(git (?!push|pull|fetch)|sudoedit|emacsclient)'
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

switch (uname)
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

### user configs
source "$HOME/.config/fish/aliases/dnf.fish"
source "$HOME/.config/fish/aliases/folders.fish"
source "$HOME/.config/fish/aliases/aliasesFromGit.fish"
source "$HOME/.config/fish/aliases/neo.fish"
source "$HOME/.config/fish/aliases/pnpm.fish"
source "$HOME/.config/fish/aliases/timeshift.fish"
source "$HOME/.config/fish/aliases/other.fish"
source "$HOME/.config/fish/utils/utils.fish"
source "$HOME/.config/fish/fzf/fzfconfig.fish"
source "$HOME/.config/fish/themes/fish_tokyonight_night.fish"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


# Starship prompt
starship init fish | source
