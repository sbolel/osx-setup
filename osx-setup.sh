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
refresh_brew
symlink_jsc
config_git
speedup_osx

#############
# functions #
#############

install_brew(){
  cd && mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  tap_brew      # update taps
  refresh_brew  # update, cleanup
}

refresh_brew(){
  brew update && brew upgrade
  brew cleanup && brew cask cleanup
}

tap_brew(){
#   brew tap homebrew/dupes 
  brew tap homebrew/services 
  brew tap homebrew/versions 
  brew tap homebrew/php 
  brew tap caskroom/cask 
  brew tap caskroom/versions
}

install_apps(){
  # dev
  brew install wget gpg2 git tig bash-completion
  brew install vim emacs && brew linkapps emacs
  brew install docker google-cloud-sdk mongodb mongoose mysql ruby s3cmd yarn
  brew cask install iterm2-beta sublime-text
  brew cask install virtualbox virtualbox-extension-pack
  # apps
  brew cask install 1password dropbox spotify
  brew cask install google-chrome google-drive
  brew cask install gitter polymail slack skype
  brew cask install logitech-control-center logitech-unifying
}

install_nvm(){
  brew install nvm
  echo 'export NVM_DIR="$HOME/.nvm"' > ~/.bash_profile
  echo "source $(brew --prefix nvm)/nvm.sh" > ~/.bash_profile
  source ~/.bash_profile
}

install_node(){
  nvm install 6.10.0
  nvm alias default 6.10.0
  nvm use default
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
  git config --global core.editor nano
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
