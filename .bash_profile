# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
. $(brew --prefix nvm)/nvm.sh

# aliases
alias ls='ls -GF'
alias la='ls -alGF'
alias e='emacs'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias t=tig
alias 'brew-head'='brew update && brew upgrade && brew cleanup'

# colors
COLOR_RED="\033[0;31m"
COLOR_LIGHT_RED="\033[1;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_LIGHT_GREEN="\033[1;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_CYAN="\033[0;36m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"
COLOR_DIM="\e[2m"
COLOR_NORMAL="\e[22m"

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
PS1+="$COLOR_LIGHT_RED\# \[\e]0;\w\a\]"
PS1+="$COLOR_RED\t"
PS1+="$COLOR_NORMAL$COLOR_CYAN \w"
PS1+="\[\$(git_color)\] "
PS1+="\$(git_branch) "
PS1+="\n"
PS1+="$COLOR_LIGHT_GREEN\$ $COLOR_RESET"
export PS1
