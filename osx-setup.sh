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
  brew cask install 1password dropbox spotify
  brew cask install google-chrome google-drive
  brew cask install polymail slack skype
  brew cask install logitech-control-center logitech-unifying
  # dev
  brew install git tig bash-completion    # git
  brew install vim emacs && brew linkapps emacs
  brew install docker google-cloud-sdk mongodb mongoose mysql ruby s3cmd wget yarn
  brew cask install iterm2-beta atom sublime-text webstorm # editors
  brew cask install virtualbox virtualbox-extension-pack   # vm
}

install_nvm(){
  brew install nvm
  echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
  echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
  source ~/.bash_profile
}

install_node(){
  nvm install v6.9.5
  nvm alias default v6.9.5
  nvm use default
}

install_npm_globals(){
  npm install -g electron cordova node-sass
  npm install -g aurelia-cli babel-cli github:gulpjs/gulp#4.0
}

update_npm_all(){
  npm install -g npm
  npm install -g npm-check npm-check-updates npm-run-all
  npm install -g typescript@next typings tslint
  npm install -g cordova electron node-sass aurelia-cli github:gulpjs/gulp#4.0
  npm install -g node-inspector nodemon supervisor watchman
  npm install -g angular-cli aurelia-cli babel-cli firebase-tools uglifyjs github:gulpjs/gulp#4.0
  npm install -g webpack@>=2.2.0-rc.3 webpack-dev-server@>=2.2.0-rc.0
  npm install -g cordova cordova-browser ios-deploy ios-sim ionic
  npm install -g eslint karma-cli phantomjs protractor standard webdriver-manager
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
