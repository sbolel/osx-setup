#!/usr/bin/env bash

alias ls="ls -GFh"
alias la="ls -GFhal"
alias ts="date \"+%Y-%m-%d\""
alias now="date \"+DATE: %Y%m%d%nTIME: %H:%M:%S\""
alias ka="killall"
alias pa="ps -A"
alias profile="vim $HOME/.bash_profile"
alias reset="source $HOME/.bash_profile && reset"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

alias ga="git add ."
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gco="git checkout"
alias gex="git reset"
alias gr="git remote -v"
alias gs="git status"
alias t="tig"

alias y="yarn"
alias yb="yarn build"
alias yd="yarn develop"

# =============================================================================

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
export HISTCONTROL=ignoredups

# =============================================================================

dev() {
  if   [[ $# == 0 ]]; then cd ~/dev
  elif [[ $1 == "notes" || $1 == "docs" ]]; then cd ~/dev/notes
  else cd ~/dev/*$1*
  fi
}

brew-head() {
  brew update
  brew upgrade
  brew cask upgrade
  brew prune
  brew cleanup
  brew cask cleanup
}

# =============================================================================

git_branch() {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]]; then local branch=${BASH_REMATCH[1]} && echo "($branch) "
  elif [[ $git_status =~ $on_commit ]]; then local commit=${BASH_REMATCH[1]} && echo "($commit) "
  fi
}

git_branch_color() {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working tree clean" ]]; then echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then echo -e $COLOR_GREEN
  else echo -e $COLOR_OCHRE
  fi
}

# =============================================================================

export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'

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
PS1+="\[$COLOR_CYAN_LIGHT\]\w "
PS1+="\[\$(git_branch_color)\]\$(git_branch)"
PS1+="\[$COLOR_GREEN_LIGHT\]\\$ "
PS1+="\[$COLOR_RESET\]"
export PS1

# =============================================================================

export NVM_DIR="${HOME}/.nvm"

[[ -f "${HOME}/.bash_env" ]] && source "${HOME}/.bash_env"
# [[ -f "${HOME}/.bin/.symlink" ]] && . "${HOME}/.bin/.symlink"
# [[ -f "${HOME}/.bin/.iterm2_shell_integration.bash" ]] && . "${HOME}/.bin/.iterm2_shell_integration.bash"
[[ -f "/usr/local/etc/bash_completion" ]] && . "/usr/local/etc/bash_completion"
[[ -f "/usr/local/opt/nvm/nvm.sh" ]] && . "/usr/local/opt/nvm/nvm.sh"

export PATH=~/homebrew/sbin:~/homebrew/bin:$PATH
export PATH=$PATH:"$(nvm_version_dir)/$(nvm_version)/bin"

ssh-add -l | [[ "$(grep -oEi '(id_rsa)')" != 'id_rsa' ]] && ssh-add -K
