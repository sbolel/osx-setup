#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"

_SOURCES=(
  "/usr/local/etc/bash_completion"
  "/usr/local/opt/nvm/nvm.sh"
  "${HOME}/.iterm2_shell_integration.bash"
); for i in ${_SOURCES[@]}; do $(test -e "${i}") && source ${i}; done

# -----------------------------------------------------------------------------

alias ls="ls -GFhp"
alias la="ls -GFhpal"
alias ka="killall"
alias pa="ps -A"
alias now="date \"+DATE: %Y%m%d%nTIME: %H:%M:%S\""
alias profile="subl $HOME/.bash_profile"
alias brew-head="brew update; brew upgrade; brew prune; brew cleanup; brew cask cleanup"

alias ga="git add ."
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gco="git checkout"
alias gex="git reset"
alias gp="git pull"
alias gr="git remote -v"
alias gs="git status"
alias t="tig"

alias yb="yarn build"
alias yd="yarn develop"
alias yr="yarn rebuild"

# -----------------------------------------------------------------------------

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# -----------------------------------------------------------------------------

function cdd {
  cd *$1*
}

function dev {
  if [[ $# == 0 ]]; then cd ~/dev;
elif [[ $# == 1 ]]; then cd ~/dev/*$1;
elif [[ $# == 2 ]]; then $("cd ~/dev/*$1*/*$2*")
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]]; then echo "(${BASH_REMATCH[1]}) "
  elif [[ $git_status =~ $on_commit ]]; then echo "(${BASH_REMATCH[1]}) "
  fi
}

function git_color {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working tree clean" ]]; then echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then echo -e $COLOR_GREEN
  else echo -e $COLOR_OCHRE
  fi
}

# -----------------------------------------------------------------------------

COLOR_RED="\033[0;31m"      ; COLOR_RED_LIGHT="\033[1;31m"
COLOR_GREEN="\033[0;32m"    ; COLOR_GREEN_LIGHT="\033[1;32m"
COLOR_BLUE="\033[0;34m"     ; COLOR_BLUE_LIGHT="\033[1;34m"
COLOR_YELLOW="\033[0;33m"   ; COLOR_YELLOW_LIGHT="\033[1;33m"
COLOR_CYAN="\033[0;36m"     ; COLOR_CYAN_LIGHT="\033[1;36m"
COLOR_MAGENTA="\033[0;35m"  ; COLOR_MAGENTA_LIGHT="\033[1;35m"
COLOR_WHITE="\033[0;37m"    ; COLOR_WHITE_BOLD="\033[1;37m"
COLOR_BLACK="\033[0;30m"
COLOR_NORMAL="\e[22m"       ; COLOR_DIM="\e[2m"
COLOR_OCHRE="\033[38;5;95m" ; COLOR_RESET="\033[0m"

PS1="\n "
PS1+="\[$COLOR_RED_LIGHT\]\\$ "
PS1+="\[$COLOR_CYAN_LIGHT\]\w "
PS1+="\[\$(git_color)\]\$(git_branch)\n "
PS1+="\[$COLOR_GREEN_LIGHT\]> "
PS1+="\[$COLOR_WHITE_BOLD\]"
export PS1

export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'

# trap "tput sgr0" DEBUG
