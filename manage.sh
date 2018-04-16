#!/bin/bash

# idea from https://help.github.com/articles/about-git-subtree-merges/
function init_subtree() {
    local name=$1
    local prefix=external/$2
    local repo=$3
    git remote add $name $repo
    git fetch $name
    git merge -s ours --no-commit --allow-unrelated-histories $name/master
    git read-tree --prefix=$prefix -u $name/master
    git commit -m "Add $name subtree to $prefix"
}

function pull_subtree() {
    local name=$1
    git pull -s subtree $name master
}

function init_repos() {
    init_subtree zim .zim/ https://github.com/zimfw/zimfw.git
    init_subtree zim_history_substring_search .zim/modules/history-substring-search/external/ https://github.com/zsh-users/zsh-history-substring-search.git
    init_subtree zim_completion .zim/modules/completion/external/ https://github.com/zsh-users/zsh-completions.git
    init_subtree zim_syntax_highlighting .zim/modules/syntax-highlighting/external/ https://github.com/zsh-users/zsh-syntax-highlighting.git
    init_subtree zim_pure .zim/modules/prompt/external-themes/pure/ https://github.com/sindresorhus/pure.git
    init_subtree zim_liquidprompt .zim/modules/prompt/external-themes/liquidprompt/ https://github.com/nojhan/liquidprompt.git
    init_subtree zim_lean .zim/modules/prompt/external-themes/lean/ https://github.com/miekg/lean
    init_subtree zim_autosuggestions .zim/modules/autosuggestions/external/ https://github.com/zsh-users/zsh-autosuggestions.git
    # https://github.com/junegunn/vim-plug.git plug.vim
    # https://github.com/paulp/sbt-extras.git sbt
}

function pull_repos() {
    pull_subtree zim
    pull_subtree zim_history_substring_search
    pull_subtree zim_completion
    pull_subtree zim_syntax_highlighting
    pull_subtree zim_pure
    pull_subtree zim_liquidprompt
    pull_subtree zim_lean
    pull_subtree zim_autosuggestions
}

function usage() {
    echo "Usage: $0 (init|pull)"
    exit 1
}

if [[ $# != 1 ]]; then usage; fi

case $1 in
    init) init_repos;;
    update) pull_repos;;
    *) usage;;
esac
