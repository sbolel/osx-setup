#!/usr/bin/env bash

# general
alias dev="cd ~/dev"
alias profile="subl ~/.bash_profile"

# ls
alias ls='ls -GFh'
alias la="ls -GFhal"

# git
alias ga="git add ."
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gco="git checkout"
alias gex="git reset"
alias gs="git status"
alias t="tig"

# =============================================================================

# install npm global packages
function npm-g {
  npm install -g npm jspm yarn
  npm install -g node-gyp node-pre-gyp v8-profiler
  npm install -g npm-check npm-check-updates npm-run-all
  npm install -g typescript@^2.1.0 typings tslint
  npm install -g webpack@^2.1.0-beta webpack-dev-server@^2.1.0-beta
  npm install -g babel-cli angular-cli aurelia-cli gulp-cli firebase-tools
  npm install -g eslint standard karma karma-cli karma-webpack protractor phantomjs
  npm install -g electron cordova cordova-browser ios-deploy ios-sim ionic
  npm install -g node-inspector nodemon supervisor watchman webdriver-manager
}

# update brew
function brew-head {
  brew update
  brew upgrade
  brew cleanup
}

# show/hide hidden files in finder
function hidden {
  if [[ $# == 0 || $1 == "show" ]]; then
    defaults write com.apple.finder AppleShowAllFiles YES
    killall Finder && printf "Hidden files shown!"
  fi
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

# git bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
. $(brew --prefix nvm)/nvm.sh

# node
export PATH=$PATH:$HOME/.nvm/versions/node/v6.9.1/bin/node

# rvm
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

# =========================================================
