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

# update after tap
brew update && brew upgrade

# dev
brew install git tig bash-completion wget
brew install docker java mysql ruby s3cmd yarn
brew install android-sdk android-ndk chromedriver

# apps
brew cask install 1password dropbox google-chrome google-drive polymail slack spotify skype
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager
brew cask install emacs vim iterm2-beta atom sublime-text webstorm android-studio google-cloud-sdk
brew cask install logitech-unifying logitech-control-center
brew linkapps emacs

# nvm
brew install nvm
echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
source ~/.bash_profile

# node
nvm install v6.9.1
nvm alias default v6.9.1
nvm use default

# npm
npm install -g npm jspm yarn
npm install -g node-gyp node-pre-gyp v8-profiler
npm install -g npm-check npm-check-updates npm-run-all
npm install -g typescript@^2.1.0 typings tslint
npm install -g webpack@^2.1.0-beta webpack-dev-server@^2.1.0-beta
npm install -g babel-cli angular-cli aurelia-cli gulp-cli firebase-tools
npm install -g eslint standard karma karma-cli karma-webpack protractor phantomjs
npm install -g electron cordova cordova-browser ios-deploy ios-sim ionic
npm install -g node-inspector nodemon supervisor watchman webdriver-manager

# symlink jsc
ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin

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
