#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

install.brew(){
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap homebrew/dupes
  brew tap homebrew/versions
  brew tap homebrew/homebrew-php
  brew install caskroom/cask/brew-cask
  brew install git
  brew install hub    # hub.github.com
  brew install tig
  brew install git bash-completion
  brew install wget
  brew install atom
  brew install mysql
  brew install s3cmd
  brew install android-sdk
  brew install --with-mysql --with-cgi php55
  brew cask install iterm2
  brew cask install little-snitch
  brew cask install google-chrome
  brew cask install vlc
  brew cask install pandoc
  brew cask install flux
  brew cask install spotify  
}

install.node(){
  # curl -o ~/Downloads https://nodejs.org/dist/v0.12.7/node-v0.12.7.pkg && ~/Downloads/node-v0.12.7.pkg
  brew install node
  sudo npm install -g npm
  sudo npm install -g cordova
  sudo npm install -g ionic
  npm install -g firebase-tools
  npm install -g bower
  npm install -g grunt-cli
  npm install -g nodemon
}

# TODO in progress
install.rvm(){
  local rubyVersion
  cd ~/
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled --ruby --rails --trace
  source ~/.rvm/scripts/rvm
  rubyVersion = echo $(ruby -v) | sed 's/[^0-9.]*\([0-9.]*\).*/\1/'
}

# Setup Git
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

config.speedup(){
  # Speed up window tranisations 
  defaults write NSGlobalDomain NSWindowResizeTime 0.01;
  # Speed up mission control transition (F3)
  defaults write com.apple.dock expose-animation-duration -float 0.1; 
  # Speed up Launchpad (F4)
  defaults write com.apple.dock springboard-show-duration -float 0.1;
  defaults write com.apple.dock springboard-hide-duration -float 0.1; 
  # Restart dock so effects can kick in.
  killall Dock;
}

# Run everything
install.brew
install.node
config.git
config.speedup
