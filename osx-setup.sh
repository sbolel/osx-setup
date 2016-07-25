#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

# download and install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# taps
brew tap homebrew/dupes 
brew tap homebrew/services 
brew tap homebrew/versions 
brew tap homebrew/php 
brew tap caskroom/cask 
brew tap caskroom/versions

# update after tapping
brew update && brew upgrade
brew cleanup && brew cask cleanup

# dev
brew install bash-completion git tig
brew cask install emacs vim iterm2-beta sublime-text webstorm atom java
brew linkapps emacs

# lib
brew install mysql ruby s3cmd wget
brew install --with-mysql --with-cgi php55

# apps
brew cask install 1password dropbox google-chrome google-drive slack spotify skype

# nvm
brew install nvm
echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
source ~/.bash_profile

# node
nvm install v6.3.1
nvm use --delete-prefix v6.3.1
nvm alias default v6.3.1
nvm use default

# npm packages
npm install -g npm
npm install -g cordova
npm install -g ionic
npm install -g angular-cli ember-cli firebase-tools
npm install -g bower bower-check-updates npm-check-updates
npm install -g babel-cli grunt-cli gulp jspm karma node-inspector nodemon protractor rimraf supervisor typescript typings uglify-js watchman webpack webpack-dev-server yo

# vm
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager

# android
brew install android-sdk android-ndk
brew cask install android-studio

# optional git setup
config.git(){
  echo "Enter git user.name: "
  read name
  echo "Enter git user.email: "
  read email
  git config --global user.name "${name}"
  git config --global user.email "${email}"
  git config --global core.editor emacs
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
brew update && brew upgrade
brew cleanup && brew cask cleanup
