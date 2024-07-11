# eval "$(/opt/homebrew/bin/brew shellenv)"
# pyenv init - | source

# pnpm
set -gx PNPM_HOME ~/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    fish_add_path -gP $PNPM_HOME
end
# pnpm end

if test -n "$(which zoxide)"
    zoxide init fish --cmd cd | source
end

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

set -gx EDITOR /opt/homebrew/bin/nvim
set -gx XDG_CONFIG_HOME ~/.config
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
set -gx HOMEBREW_NO_ENV_HINTS true

# Add the location for globally installed yarn binaries
fish_add_path -gP "~/.yarn/bin"

alias reload_fish="source ~/.config/fish/config.fish"

alias tasky-dos="PARCEL_LOCAL_METRICS=true yarn build:local --fragments task-progress"
alias parcel-link="~/github/parcel/packages/dev/parcel-link/bin.js"
alias parcel-unlink="~/github/parcel/packages/dev/parcel-link/bin.js unlink"
alias parcel-query="~/github/packages/dev/query/src/bin.js"
alias upgrade-parcel="GH_TOKEN=(gh auth token) yarn dev upgrade-parcel"
alias afm-upgrade-parcel="~/atlassian/atlassian-frontend-monorepo/afm-tools/src/packages/upgrade-parcel/index.ts"

alias lg="lazygit"

# git commands
alias gs="git status -uno"
alias gc="git commit -m"

fish_add_path -gP /usr/local/go/bin
fish_add_path -gP ~/.local/bin
