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

function is_parcel_lunk
    return (exists-up ".atlaspack-link" ".git")
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

    if test $new_branch != $current_branch
        git checkout $current_branch
    end
end

function yarn_patch
    set package_name $argv[1]

    set patch_path $(yarn patch --json $package_name | jq --raw-output .path)

    n $patch_path
    yarn patch-commit -s $patch_path
end

function gum
    update_branch master jira-stable
end

function gu
    set branch_name $argv[1]

    if test -z $branch_name
        set branch_name (current_git_branch)
    end

    echo "Updating $(colors yellow $branch_name)..."

    update_branch $branch_name
end

function rebase_onto
    set branch_name $argv[1]

    if test -z $branch_name
        set branch_name master
    end

    echo -e "\nRebasing $( colors blue (current_git_branch)) onto $(colors yellow $branch_name)...\n"
    gu $branch_name && git rebase $branch_name

end

function stash_token
    op read "op://Private/Stash Access Token/credential"
end

function git_checkout_remote
    set branch_name $argv[1]
    git fetch origin $branch_name --prune --prune-tags
    git checkout $branch_name
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
alias parcel-unlink="~/github/atlaspack/packages/dev/parcel-link/bin.js unlink"
alias atlaspack-link="~/github/atlaspack/packages/dev/atlaspack-link/bin.js"
alias atlaspack-unlink="~/github/atlaspack/packages/dev/atlaspack-link/bin.js unlink"
alias parcel-query="~/github/parcel/packages/dev/query/src/bin.js"
alias atlaspack-query="~/github/atlaspack/packages/dev/query/src/bin.js"
alias upgrade-parcel="~/atlassian/afm/afm-tools/src/packages/upgrade-parcel/run.sh"

alias grm="git rebase master -Xours"

alias n="nvim"
alias lg="lazygit"

# git commands
alias gs="git status -uno"
alias gc="git commit -m"

fish_add_path -gP /usr/local/go/bin
fish_add_path -gP ~/.local/bin
