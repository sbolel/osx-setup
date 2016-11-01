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
brew install git tig bash-completion ruby java mysql docker s3cmd wget chromedriver android-sdk android-ndk

# apps
brew cask install 1password dropbox google-chrome google-drive polymail slack spotify skype
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager
brew cask install emacs vim iterm2-beta atom sublime-text webstorm android-studio
brew linkapps emacs

# nvm
brew install nvm
echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
source ~/.bash_profile

# node
nvm install v6.9.0
nvm alias default v6.9.0
nvm use default

# npm
npm install -g npm npm-check-updates
npm install -g typescript typings tsc tslint
npm install -g angular-cli babel-cli firebase-tools
npm install -g webpack@^2.1.0-beta webpack-dev-server@^2.1.0-beta
npm install -g eslint standard protractor karma karma-cli karma-webpack
npm install -g cross-env dotenv npm-run-all node-inspector nodemon supervisor watchman

# npm - other
npm install -g bower bower-check-updates gulp uglify-js yo cordova ionic
npm install -g node-sass && npm rebuild node-sass

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
