#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

# download and install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# tap
brew tap homebrew/dupes homebrew/services homebrew/versions homebrew/php caskroom/cask caskroom/versions

# update after tapping
brew update && brew upgrade
brew cleanup && brew cask cleanup

# system
brew install bash-completion mysql ruby s3cmd wget
brew install --with-mysql --with-cgi php55
brew cask install java

# development
brew install emacs --with-cocoa
brew linkapps emacs
brew install vim
brew cask install iterm2-beta atom sublime-text3 webstorm

# android
brew install android-sdk android-ndk
brew cask install android-studio

# essentials
brew cask install 1password dropbox google-chrome google-drive google-hangouts spotify imagemagick

# communication
brew cask install slack skype

# vm
brew cask install virtualbox virtualbox-extension-pack vagrant vagrant-manager

# nvm
brew install nvm
source $(brew --prefix nvm)/nvm.sh
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.bash_profile

# npm packages
npm install -g npm angular-cli babel-cli bower bower-check-updates cordova ember-cli firebase-tools grunt-cli gulp ionic jspm karma node-inspector nodemon npm-check-updates protractor rimraf supervisor typescript typings uglify-js watchman webpack webpack-dev-server yo generator-kyper-react

# install a node version
nvm install v6.2.2d
nvm alias default v6.2.2
nvm use default

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
brew update && brew upgrade
brew cleanup && brew cask cleanup
