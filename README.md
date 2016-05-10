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

```bash
#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

# download and install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# tap
brew tap homebrew/dupes homebrew/services homebrew/versions homebrew/php caskroom/cask caskroom/versions

# update after tapping
brew update; brew upgrade; brew cleanup; brew cask cleanup

# system
brew install bash-completion mysql ruby s3cmd wget
brew install --with-mysql --with-cgi php55
brew cask install java

# essentials
brew cask install 1password dropbox google-chrome google-drive google-hangouts spotify

# dev
brew cask install atom iterm2-beta sublime-text3 vim webstorm

# communication
brew cask install slack skype

# android
brew install android-sdk android-ndk
brew cask install android-studio

# vm
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager

# nvm
brew install nvm
source $(brew --prefix nvm)/nvm.sh
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.bash_profile

# install a node version
nvm install v5.10
nvm use --delete-prefix v5.10

# npm packages
npm install -g npm
npm install -g bower gulp grunt-cli cordova ionic firebase-tools nodemon node-inspector supervisor

# optional git setup
config.git(){
  echo "Enter git user.name: "
  read name
  echo "Enter git user.email: "
  read email
  git config --global user.name "${name}"
  git config --global user.email "${email}"
  git config --global core.editor vim
  git config --global push.default current
}

# optional osx setup
config.speedup_osx(){
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

# update & cleanup again
brew update; brew upgrade; brew cleanup; brew cask cleanup
```
