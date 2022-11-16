  ## FZF settings & functions for fish; collected with attribution and modified.
alias pbcopy="xclip -sel clip"
  # These rely on `git lg`; from git's config:
  #     lg             = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
  # They also rely on the following being installed:
  # - bat
  # - choose
  # - delta
  # - exa
  # - fd
  # - rg

  # https://github.com/jethrokuan/fzf
  # https://github.com/junegunn/fzf#respecting-gitignore
  # We want hidden but not `.git` paths
  set -gx FZF_DEFAULT_COMMAND "fd --hidden --no-ignore --follow --exclude='**/.git/'"
  # https://github.com/junegunn/fzf/wiki/Examples#clipboard
  # `--min-height` is useful with tiny terminal windows; e.g. for VSCode,
  # especially when the preview window is important, like in git log.
  # TODO: could we use
  # https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_clipboard_copy.fish
  # to allow this to work on multiple platforms?
  set -gx FZF_DEFAULT_OPTS '--height 50% --min-height=30 --layout=reverse --color=light 
  set -ctrl-y:execute-silent(printf {} | cut -f 2- | pbcopy)" 
  set -ctrl-u:preview-half-page-up 
  set -ctrl-d:preview-half-page-down
  set -ctrl-o:execute-silent(code {-1})"'

  set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND "--type=f"
  set -gx FZF_CTRL_T_OPTS "--preview='bat --style=numbers --color=always {}'"
  set -gx FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND "--type=d"
  set -gx FZF_ALT_C_OPTS "--preview='exa -T {}'" 
  # https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
  set -gx FZF_CTRL_R_OPTS "--preview='echo {}' --preview-window=down:3:hidden:wrap --bind='?:toggle-preview'"

  # Heavily adapted & simplified from:
  # https://github.com/junegunn/fzf/wiki/Examples-(fish)#navigation
  function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
    if [ -z "$dirprev" ]
      return
    end
    # TODO @max: Can we re-include git-ignored folders?
    string join \n $dirprev | tac | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
    [ "$result" ]; and cd $result
    commandline -f repaint
  end


  # Significantly adjusted to fish from
  # https://github.com/junegunn/fzf/wiki/Examples#searching-file-contents
  function fzf-rg-search-widget -d 'find text in files'

    set rg_command "rg --ignore-case --files-with-matches -uu --iglob='!**/.git/' --follow"
    # Start with all files; i.e. .*
    FZF_DEFAULT_COMMAND="$rg_command '.*'" SHELL=fish fzf \
      -m \
      -e \
      --ansi \
      --disabled \
      --bind "change:reload:$rg_command {q} || true" \
      # I'm not sure what this `cut` does — but remove it and the whole thing fails.
      --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2 \
      | fzf_add_to_commandline
  end


  # The following few `__git` functions are Heavily adapted from
  # https://gist.github.com/aluxian/9c6f97557b7971c32fdff2f2b1da8209
  function __git_fzf_is_in_git_repo -d "Check whether we're in a git repo"
    command -s -q git
      and git rev-parse HEAD >/dev/null 2>&1
  end

  # Deciphered from fzf-file-widget. Surprising why it doesn't exist already!
  function fzf_add_to_commandline -d 'add stdin to the command line, for fzf functions'
    read -l -z result
    commandline -t ""
    # Do we need to escape this? This was here before, but doesn't work well with
    # multiline strings.
    # commandline -it -- (string escape $result)
    commandline -it -- (echo $result | paste -s -d" " -)
    commandline -f repaint
  end

  # Because files that are tracked / untracked have different forms, we can't
  # currently _select_ files that are untracked — selecting them won't print
  # anything to the command line.
  function __git_fzf_git_status -d "fzf on files from git status"
    __git_fzf_is_in_git_repo; or return
    # We use porcelain since otherwise it's hard to handle files with quotes. We
    # lose the colors.
    #
    # The previous version was this, which didn't work for files with spaces:
    # fzf -m --ansi --preview "git diff HEAD -- {} | delta" | \
    # Another previous version did this, which gives some info about whether
    # it's added etc, but fails for new files, since their porcelain output is
    # different.
    # git status --porcelain=2 | choose -1 | \
    #
    git status --porcelain=2 | choose 1 8: \
    # We could use the field indexers, but it means we have a different command
    # for the index and the next command in the pipe. ref
    # https://github.com/junegunn/fzf/issues/1323.
    # SHELL=fish fzf -m --ansi --preview "git diff HEAD -- {-1} | delta" | \
      | SHELL=fish fzf -m --ansi --preview "git diff HEAD -- (echo {} | choose 1:) | delta" \
      --bind=ctrl-a:"execute-silent(git add {-1})+abort" \
      | choose 1: \
      | fzf_add_to_commandline
    commandline -f repaint
  end


  function __git_fzf_git_branch -d "fzf on git branches"
    # We could use this rather than the separate function, but we get quoting issues.
    set pattern '^[\*\s]*(?:remotes/)?([^\s]*)' 


    __git_fzf_is_in_git_repo; or return

    git branch -a --color=always \
      | grep -v '/HEAD\s' \
      | SHELL=fish fzf -m --ansi --preview-window=right:70% \
          # Add `--` so this is always recognized as a branch rather than path.
          --preview='git lg --color=always (echo {} | __get_branch) --' \
          # This doesn't seem to print anything at all
          # We also remove `origin` off the prefix, because switch needs just the
          # branch name. That requires escaping the `$`.
          --bind=ctrl-s:"execute-silent(git switch (echo {} | __get_branch | rg '(?:origin/)?(.*)' -r '\$1') > /dev/tty )+abort" \
      # This can't use __get_branch because that only works on a single line...
      | rg $pattern -or '$1' \
      | fzf_add_to_commandline
    commandline -f repaint
  end

  function __git_fzf_git_tag -d "fzf on git tags"
    __git_fzf_is_in_git_repo; or return
    git tag --sort=-creatordate \
      | SHELL=fish fzf -m --ansi --no-sort \
        --preview-window=right:70% --preview='git show {} | delta' \
      | fzf_add_to_commandline
  end

  function __git_fzf_git_log -d "fzf on git history"
    __git_fzf_is_in_git_repo; or return
    git lg --color=always \
      | SHELL=fish fzf -m --ansi --no-sort --preview 'git show (echo {} | rg "(\w+).*" -or \'$1\') | delta' \
      | rg "(\w+).*" -or '$1' \
      | fzf_add_to_commandline
  end

  function __git_fzf_git_stash -d "fzf on git stashes"
    __git_fzf_is_in_git_repo; or return
    set -l pattern "(stash@[{\d}]*)"
    git stash list --color=always \
      # We seem to need delta explicitly, since git will write without using
      # delta if it's not a tty.
      | SHELL=fish fzf -m --ansi --no-sort \
        --preview "git stash show -p (echo {} | rg '$pattern' -o) | delta" \
        # This doesn't clear the fzf screen, so the output looks messy. Is there a
        # better way? Adding `clear-screen+` doesn't help.
        --bind=ctrl-p:"execute-silent(git stash pop (echo {} | rg '$pattern' -o) > /dev/tty)+abort" \
      | rg $pattern -o \
      | fzf_add_to_commandline
    commandline -f repaint
  end

  function git_fzf_key_bindings -d "Set custom key bindings for git+fzf"
    # `-M insert` is added, as we want these in insert mode
    #
    bind \cg\cb __git_fzf_git_branch
    bind \cg\ch __git_fzf_git_stash
    bind \cg\cl __git_fzf_git_log
    bind \cg\cs __git_fzf_git_status
    bind \cg\ct __git_fzf_git_tag
    # We add C-g on because we use C-t for tags in Zellij
    bind \cg\cg __git_fzf_git_tag
    bind -M insert \cg\cb __git_fzf_git_branch
    bind -M insert \cg\ch __git_fzf_git_stash
    bind -M insert \cg\cl __git_fzf_git_log
    bind -M insert \cg\cs __git_fzf_git_status
    bind -M insert \cg\ct __git_fzf_git_tag
    # We add C-g on because we use C-t for tags in Zellij
    bind -M insert \cg\cg __git_fzf_git_tag
  end

  bind \cb fzf-cdhist-widget
  bind -M insert \cb fzf-cdhist-widget
  bind \cf fzf-rg-search-widget
  bind -M insert \cf fzf-rg-search-widget
  git_fzf_key_bindings

# Keep an eye on https://github.com/PatrickF1/fzf.fish, which does some of
# these, but arguably worse.

# This needs to be in the main scope because the fzf functions call it. This
# whole thing is messy.
function __get_branch -d "Parses branch name for __git_fzf_git_branch"
  # Putting this in `__git_fzf_git_branch` seems to sometimes not work, maybe
  # because it's not available in the shell to the `preview` command?
  set pattern '^[\*\s]*(?:remotes/)?([^\s]*)' 
  # First part removes colors
  # https://github.com/fish-shell/fish-shell/issues/5390 (but now I don't
  # think that's necessary, and it was a different issue around `read` only
  # reading from the first line)
  read | string replace -ra '\e\[[^m]*m' '' | rg $pattern -or '$1'
end

### End of fzf functions

#set -U FZF_ENABLE_OPEN_PREVIEW 1
#set fzf_preview_dir_cmd exa --all --color=always
#set fzf_fd_opts --hidden --exclude=.git
#set -xg FZF_DEFAULT_OPTS '--bind "ctrl-n:down,ctrl-p:up,ctrl-r:previous-history,#ctrl-s:next-history,ctrl-q:select-all,ctrl-x:toggle-out"'