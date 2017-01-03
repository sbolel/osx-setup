#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

################
# installation #
################

install_brew
install_apps
install_nvm
install_node
install_npm_globals
refresh_brew
symlink_jsc
config_git

#############
# functions #
#############

install_brew(){
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  tap_brew      # update taps
  refresh_brew  # update, cleanup
}

refresh_brew(){
  brew update && brew upgrade
  brew cleanup && brew cask cleanup
}

tap_brew(){
  brew tap homebrew/dupes 
  brew tap homebrew/services 
  brew tap homebrew/versions 
  brew tap homebrew/php 
  brew tap caskroom/cask 
  brew tap caskroom/versions
}

install_apps(){
  # apps
  brew cask install 1password dropbox google-chrome google-drive  # core apps
  brew cask install polymail slack spotify skype                  # communication
  brew cask install logitech-unifying logitech-control-center     # logitech
  # git, editors
  brew install git tig bash-completion                         # git
  brew install vim emacs && brew linkapps emacs                # sys editors
  brew cask install iterm2-beta atom sublime-text webstorm     # app editors
  # dev 
  brew install chromedriver docker mysql ruby s3cmd wget yarn  # core dev
  brew cask install virtualbox virtualbox-extension-pack       # vm apps
  brew cask install google-cloud-sdk
}

install_nvm(){
  brew install nvm
  echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
  echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
  source ~/.bash_profile
}

install_node(){
  nvm install v7.3.0
  nvm alias default v7.3.0
  nvm use default
}

install_npm_globals(){
  npm install -g npm
  npm install -g node-pre-gyp node-gyp node-sass
  npm install -g npm-check npm-check-updates npm-run-all
  npm install -g node-inspector nodemon supervisor watchman webdriver-manager
  npm install -g typescript@>=2.1.4 typings webpack@>=2.2.0-rc.3 webpack-dev-server@>=2.2.0-rc.0
  npm install -g babel-cli angular-cli aurelia-cli gulp-cli firebase-tools 
  npm install -g eslint standard tslint karma karma-cli karma-webpack protractor phantomjs
  npm install -g electron cordova cordova-browser ios-deploy ios-sim ionic
}

# optional
install_android(){
  brew install android-sdk android-ndk
  brew cask install android-studio
}

# optional
install_golang(){
  brew install go hg bzr
  mkdir $HOME/.go
  echo 'export GOPATH=$HOME/.go' >> ~/.bash_profile
  echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
  go get golang.org/x/tools/cmd/godoc
  go get golang.org/x/tools/cmd/vet
}

symlink_jsc() {
  ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin 
}

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
