# OSX Setup Script

This is a shell script to install programs for a fresh OSX installation.

Based on [Mike Rogers' OSX setup](http://mikerogers.io/2014/05/20/my-OSX-setup.html)

## Overview

This script is experimental. It has the following functionality:
## Homebrew and Homebrew Cask

* Install [Homebrew](http://brew.sh/) & [Homebrew Cask](http://caskroom.io/)
* Install brew formulae and cask bits
    - Git and supporting apps (and configure git)
    - Cask bits
    - Misc Brew formulae
* Install Node and global npm modules

#### Main function

This function runs all other functions.
```bash
osx_setup(){
  console.log "Welcome to OSX Setup :D"
  console.log ""
  config.install_dir
  install.brew
  install.brew.git
  config.git
  install.brew.misc
  install.brew.cask
  install.brew.cask.apps
  # install.node    # TODO
  # install.rvm     # TODO
  # finish.set      # TODO
}
# Run everything
osx_setup
```

#### Installations

```bash
config.git(){
  printf "Enter git user.name: "
  local name=$(prompt)
  printf "Enter git user.email: "
  local email=$(prompt)
  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global core.editor vim
  git config --global push.default current
}

install.brew(){
  local bool=$(is_installed brew)
  if [[ -z "$bool" ]]; then
    console.log "Installing Homebrew...\n"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    console.warn "Homebrew already installed!"
  fi
}

install.brew.cask(){
  brew install caskroom/cask/brew-cask
}

install.brew.git(){
  brew install git
  brew install hub    # hub.github.com
  brew install tig
  brew install git bash-completion
}

install.brew.misc(){
  brew install wget
  brew install mysql
  brew install atom
  brew install s3cmd
}

install.brew.cask.apps(){
  brew cask install iterm2
  brew cask install little-snitch
  brew cask install google-chrome
  brew cask install vlc
  brew cask install pandoc
  brew cask install flux
  brew cask install spotify  
}

# NOTE: untested
install.node(){
  curl -o "$dir" https://nodejs.org/dist/v0.12.7/node-v0.12.7.pkg
  "$dir"/node-v0.12.7.pkg
  sudo npm install -g npm
  npm install -g bower
  npm install -g grunt-cli
  npm install -g nodemon
  npm install -g firebase-tools
  npm install -g ionic
}

# NOTE untested
# TODO in progress
install.rvm(){
  local rubyVersion
  cd ~/
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled --ruby --rails --trace
  source ~/.rvm/scripts/rvm
  rubyVersion = echo $(ruby -v) | sed 's/[^0-9.]*\([0-9.]*\).*/\1/'
}
```

#### Helper functions

```bash
prompt(){
  read var
  if [[ -z "$var" ]]; then
    prompt
    return 1
  else
    echo "$var"
  fi
}
```

Printing to shell

```bash
console.log(){
  printf "%s\n" "$1"
}
console.error(){
  local callerFunction="${FUNCNAME[1]}"
  local errorPrompt=$(echo "Error: '$callerFunction'")
  printf "%s" "$errorPrompt"
}
console.warn(){
  printf '\e[4;33m%-6s\e[m' "Warning"
  printf ": %s\n" "$1"
}
```

Truth checking

```bash
is_true(){
  local result
  if [ "$1" ]; then
    result=true
  fi
  echo "$result"
}
is_file(){
  echo $(is_true "-f $1")
}
is_directory(){
  echo $(is_true "-d $1")
}
is_installed(){
  if hash $1 2>/dev/null; then
    echo true
  fi
}
```

