#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

# Main Installation Steps
brew_install
brew_get_head
install_node
symlink_jsc
setup_git
speedup_osx

brew_get_head() {
  brew update && brew upgrade
  brew cleanup && brew cask cleanup
}

brew_install() {
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Tap sources
  local taps=(
    'homebrew/services'
    'homebrew/php'
    'caskroom/cask'
    'caskroom/versions'
  ); for i in ${taps[@]}; do brew tap ${i}; done

  # Update & cleanup
  brew_get_head

  # Install Kegs
  local kegs=(
    'bash-completion'
    'direnv'
    'docker'
    'emacs'
    'gdbm'
    'gettext'
    'git'
    'gmp'
    'gnupg'
    'gnutls'
    'go'
    'google-cloud-sdk'
    'gpg2'
    'hub'
    'mongodb'
    'mongoose'
    'mysql'
    'nvm'
    'openssl'
    'openssl@1.1'
    'perl'
    'python'
    'readline'
    'ruby'
    's3cmd'
    'sqlite'
    'tig'
    'vim'
    'wget'
    'yarn'
  ); for i in ${kegs[@]}; do brew install ${i}; done

  # Install Casks
  local casks=(
    'adobe-acrobat-reader'
    'atom'
    'ccleaner'
    'cloudapp'
    'divvy'
    # 'dropbox'
    'gimp'
    'gitter'
    'google-chrome'
    # 'google-drive'
    'imageoptim'
    'iterm2-beta'
    'polymail'
    'postman'
    'sketch'
    'skype'
    'skype-for-business'
    'slack'
    'spectacle'
    'spotify'
    'steam'
    'sublime-text'
    'twitch'
    'unity'
  ); for i in ${casks[@]}; do brew cask install ${i}; done
}

install_node(){
  nvm install 8.1.2
  nvm alias default 8.1.2
  nvm use default
}

setup_git(){
  echo "Enter git user.name: "
  read name
  echo "Enter git user.email: "
  read email
  git config --global user.name "${name}"
  git config --global user.email "${email}"
  git config --global core.editor emacs
  git config --global push.default current
}

speedup_osx(){
  defaults write NSGlobalDomain NSWindowResizeTime 0.01;
  defaults write com.apple.dock expose-animation-duration -float 0.1;
  defaults write com.apple.dock springboard-show-duration -float 0.1;
  defaults write com.apple.dock springboard-hide-duration -float 0.1;
  killall Dock;
}

symlink_jsc() {
  ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin
}
