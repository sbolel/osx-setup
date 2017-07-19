#!/usr/bin/env bash

# general
alias dev="cd ~/dev"
alias KA="killall"
alias pa="ps -A"
alias profile="subl ~/.bash_profile"
alias src="source ~/.bash_profile && clear"

# ls
alias la="ls -GFhal"
alias ls="ls -GFh"

# git
alias ga="git add ."
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gco="git checkout"
alias gex="git reset"
alias gs="git status"
alias t="tig"

# yarn
alias yb="yarn build"
alias yd="yarn develop"
alias yr="yarn rebuild"

# =============================================================================

# update brew
function brew-head {
  brew update && brew upgrade
  brew cleanup && brew cask cleanup
}

# toggle show/hide hidden files
function hidden {
  if [[ $# == 0 ]]; then
    local VALUE=`defaults read com.apple.finder AppleShowAllFiles`
  fi
  if [[ $VALUE == "NO" || $1 == "show" ]]; then
    defaults write com.apple.finder AppleShowAllFiles YES
    printf "Hidden files shown!"
  elif [[ $VALUE == "YES" || $1 == "hide" ]]; then
    defaults write com.apple.finder AppleShowAllFiles NO
    printf "Hidden files hidden!"
  fi
  killall Finder
}

# replace authors in git history
function git-rewrite-authors {
  echo "Enter OLD_EMAIL to replace: "
  read oldEmail
  echo "Enter CORRECT_NAME: "
  read correctName
  echo "Enter CORRECT_EMAIL:"
  read correctEmail
  cp ./.git ./.git.backup
  git filter-branch --env-filter '
  OLD_EMAIL="your-old-email@example.com"
  CORRECT_NAME="Your Correct Name"
  CORRECT_EMAIL="your-correct-email@example.com"
  if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
  then
      export GIT_COMMITTER_NAME="$CORRECT_NAME"
      export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
  fi
  if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
  then
      export GIT_AUTHOR_NAME="$CORRECT_NAME"
      export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
  fi
  ' --tag-name-filter cat -- --branches --tags
}

# =============================================================================

# history search up/down
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ls colors
export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'

# colors
COLOR_BLUE="\033[0;34m"
COLOR_CYAN="\033[0;36m"
COLOR_DIM="\e[2m"
COLOR_GREEN="\033[0;32m"
COLOR_LIGHT_GREEN="\033[1;32m"
COLOR_LIGHT_RED="\033[1;31m"
COLOR_NORMAL="\e[22m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_RED="\033[0;31m"
COLOR_RESET="\033[0m"
COLOR_WHITE="\033[0;37m"
COLOR_YELLOW="\033[0;33m"

# git branch
function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

# git state color
function git_color {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

# bash prompt
PS1="\n"
PS1+="\[$COLOR_LIGHT_RED\]\# "
PS1+="\[$COLOR_RED\]\t"
PS1+="\[$COLOR_LIGHT_GREEN\] \w"
PS1+="\[\$(git_color)\] "
PS1+="\$(git_branch) "
PS1+="\n"
PS1+="\[$COLOR_LIGHT_GREEN\]\$ \[$COLOR_RESET\]"
export PS1

# =============================================================================

# nvm
export NVM_DIR="$HOME/.nvm" && . "/usr/local/opt/nvm/nvm.sh"

# yarn
export PATH="$PATH:`yarn global bin`"

# npm
export PATH="$PATH:`npm -g bin`"

# git bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
