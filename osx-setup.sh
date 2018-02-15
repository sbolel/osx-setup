#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

brew_get_head() {
  brew update
  brew upgrade
  brew prune
  brew cleanup
  brew cask cleanup
}

brew_install() {
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Tap sources
  local taps=(
    'homebrew/php'
    'homebrew/services'
    'caskroom/cask'
    'caskroom/versions'
  ); for i in ${taps[@]}; do brew tap ${i}; done

  # Update & cleanup
  brew_get_head

  # Install Kegs
  local kegs=(
    'angular-cli'
    'aws-cli'
    'bash-completion'
    'brew-cask-completion'
    'calc'
    'curl'
    'direnv'
    'docker'
    'dockutil'
    'emacs'
    'ffmpeg'
    'firebase-cli'
    'flow'
    'gdbm'
    'gettext'
    'gifsicle'
    'git'
    'git-extras'
    'gmp'
    'gnupg'
    'gnutls'
    'go'
    'google-cloud-sdk'
    'googler'
    'gpg2'
    'grep'
    'heroku'
    'hub'
    'imagemagick'
    'imagemagick@6'
    'mongodb'
    'mongoose'
    'mysql'
    'nettle'
    'nvm'
    'open-completion'
    'openssl'
    'openssl@1.1'
    'perl'
    'python'
    'readline'
    'redis'
    'ruby'
    's3cmd'
    'speedtest-cli'
    'sqlite'
    'the_silver_searcher'
    'tig'
    'tmux'
    'trash'
    'tree'
    'vim'
    'watch'
    'watchman'
    'wget'
    'yarn'
  ); for i in ${kegs[@]}; do brew install ${i}; done

  # Install Casks
  local casks=(
    'atom'
    'brave'
    'ccleaner'
    'firefox'
    'dropbox'
    'gimp'
    'google-chrome'
    'google-drive'
    'imageoptim'
    'iterm2-beta'
    'postman'
    'sketch'
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
  nvm install 9.2.0
  nvm alias default 9.2.0
  nvm use default
  npm i -g npm
  local npms=(
    'create-react-app'
    'editorconfig'
    'eslint'
    'gulp-cli'
    'jscodeshift'
    'npm-check'
    'npm-check-updates'
    'nodemon'
    'serve'
    'standard'
  ); for i in ${npms[@]}; do yarn add global ${i}; done
}

setup_atom(){
  local apms=(
    'atom-beautify'
    'calc'
    'language-babel'
    'nuclide'
    'set-syntax'
    'sort-lines'
    'tinytimer'
  ); for i in ${apms[@]}; do apm install ${i}; done
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
  defaults write NSGlobalDomain NSWindowResizeTime 0.01
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write com.apple.dock springboard-show-duration -float 0.1
  defaults write com.apple.dock springboard-hide-duration -float 0.1
  # Don’t animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false
  # Remove the auto-hiding Dock delay
  defaults write com.apple.dock autohide-delay -float 0
  # Remove the animation when hiding/showing the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0
  # Increase window resize speed for Cocoa applications
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  killall Dock && killall Finder
}

symlink_jsc() {
  ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin
}

#############################
#  Main Installation Steps  #
#############################
brew_install
brew_get_head
setup_atom
setup_git
install_node
symlink_jsc
speedup_osx
