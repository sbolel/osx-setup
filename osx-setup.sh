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

# lib
brew install mysql ruby s3cmd wget docker
brew install --with-mysql --with-cgi php55

# dev
brew install bash-completion git tig
brew cask install emacs vim iterm2-beta sublime-text webstorm atom java
brew linkapps emacs

# apps
brew cask install 1password dropbox google-chrome google-drive polymail slack spotify skype

# nvm
brew install nvm
echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
source ~/.bash_profile

# node
nvm install v6.5.0
nvm alias default v6.5.0
nvm use default

# npm packages
npm install -g npm jspm rimraf
npm install -g cordova ionic
npm install -g angular-cli firebase-tools
npm install -g bower bower-check-updates npm-check-updates
npm install -g typescript typings tsc tslint
npm install -g babel-cli webpack webpack-dev-server
npm install -g grunt-cli gulp jshint uglify-js yo
npm install -g node-inspector nodemon supervisor watchman
npm install -g protractor karma

# vm
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager

# android
brew install android-sdk android-ndk
brew cask install android-studio

# golang
brew install go --cross-compile-common
brew install hg bzr
mkdir $HOME/.go
echo 'export GOPATH=$HOME/.go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
go get golang.org/x/tools/cmd/godoc
go get golang.org/x/tools/cmd/vet
go get golang.org/x/tools/cmd/vet

# update & clean
brew update && brew upgrade
brew cleanup && brew cask cleanup 


# optional git setup
config_git(){
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
speedup_osx(){
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

other(){
  # symlink jsc
  ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin
}
