if test (uname) = "Darwin"
    eval "$(/opt/homebrew/bin/brew shellenv)"
end
# pyenv init - | source

# pnpm
# set -gx PNPM_HOME ~/Library/pnpm
# if not string match -q -- $PNPM_HOME $PATH
#     fish_add_path -gP $PNPM_HOME
# end
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

function gu
    set branch_name $argv[1]

    if test -z $branch_name
        set branch_name (current_git_branch)
    end

    echo "Updating $(colors yellow $branch_name)..."

    update_branch $branch_name
end

function default_branch
    git rev-parse --abbrev-ref origin/HEAD | string replace origin/ ""
end

function gum
    set default (default_branch)

    gu $default && git rebase $default
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

function gcr
    set branch_name $argv[1]
    git fetch origin $branch_name --prune --prune-tags
    git checkout $branch_name
end

function pr
    set branch_name $argv[1]

    if test -z $branch_name
        set branch_name (current_git_branch)
    end

    set diff_url \
        "https://bitbucket.org/atlassian/atlassian-frontend-monorepo" \
        /pull-requests/new \
        "?source=$branch_name"

    if test (uname) = "Darwin"
        open (string join '' $diff_url)
    else
        xdg-open (string join '' $diff_url)
    end
end

function guy
    gu && i
end

function i
    if pwd | string match -q -- "*/atlassian/afm/*"
        afm install
    else
        yarn
    end
end

if test (uname) = "Darwin"
    set -gx EDITOR /opt/homebrew/bin/nvim
    set -gx HOMEBREW_NO_ENV_HINTS true
else
    set -gx EDITOR nvim
end
set -gx XDG_CONFIG_HOME ~/.config
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
set -gx AFM_DIR ~/atlassian/afm
set -gx CFE_SSR ~/atlassian/afm/confluence/next/packages/ssr-app/dist/ssr-app.js
set -gx ATLASPACK_DEBUG_TOOLS "asset-file-names-in-output,simple-cli-reporter"

# Add the location for globally installed yarn binaries
fish_add_path -gP "~/.yarn/bin"

alias reload_fish="source ~/.config/fish/config.fish"

alias tasky-dos="PARCEL_LOCAL_METRICS=true yarn build:local --fragments task-progress"
alias al="~/atlassian/atlaspack/packages/dev/atlaspack-link/bin.js"
alias au="~/atlassian/atlaspack/packages/dev/atlaspack-link/bin.js unlink"
alias aq="~/atlassian/atlaspack/packages/dev/query/src/bin.js"
alias bump-atlaspack="~/atlassian/afm/afm-tools/src/packages/bump-atlaspack/run.sh"

alias grm="git rebase master -Xours"
alias gcd="git checkout (default_branch)"
alias gnb="git checkout -b"

alias yb="yarn build"
alias ybn="yarn build-native"

alias n="nvim"
alias g="lazygit"
alias l="lazygit"
alias r="acli rovodev"

# git commands
alias gs="git status -uno"
alias gc="git commit -m"
alias gcn="git commit --no-verify -m"

alias ac="git add .changeset && git commit -m \"Add changeset\""

# fish_add_path -gP /usr/local/go/bin
fish_add_path -gP ~/.local/bin
