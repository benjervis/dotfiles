# eval "$(/opt/homebrew/bin/brew shellenv)"
# pyenv init - | source

# pnpm
set -gx PNPM_HOME /Users/bjervis/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    fish_add_path -gP $PNPM_HOME
end
# pnpm end

zoxide init fish --cmd cd | source

function current_git_branch
    git symbolic-ref --short HEAD
end

function update_branch
    set current_branch (current_git_branch)

    git fetch origin $argv --prune --prune-tags

    for branch_name in $argv
        git rebase origin/$branch_name $branch_name
    end

    set new_branch (current_git_branch)

    if test new_branch != current_branch
        git checkout $current_branch
    end
end

function gum
    update_branch master jira-stable
end

function gu
    update_branch (current_git_branch)
end

function nt
    tmux split-pane -h
    tmux select-pane -t:.0
    tmux set main-pane-width 67%
    tmux select-layout main-vertical
    nvim
end


set -gx EDITOR /opt/homebrew/bin/nvim

abbr -a edr --set-cursor -- "exercism download --track=rust --exercise=%"

# Add the location for globally installed yarn binaries
fish_add_path -gP "~/.yarn/bin"

alias reload_fish="source ~/.config/fish/config.fish"

alias tasky-dos="PARCEL_LOCAL_METRICS=true yarn build:local --fragments task-progress"
alias parcel-link="/Users/bjervis/github/parcel/packages/dev/parcel-link/bin.js"
alias parcel-query="/Users/bjervis/github/packages/dev/query/src/bin.js"
alias upgrade-parcel="GH_TOKEN=(gh auth token) yarn dev upgrade-parcel"

# git commands
alias gs="git status -uno"
alias gc="git commit -m"

fish_add_path -gP /usr/local/go/bin