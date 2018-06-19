#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

brew_get_head() {
  brew update
  brew upgrade
  brew cask upgrade
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
    'adns'
    'amazon-ecs-cli'
    'aws-cli'
    'bash-completion'
    'brew-cask-completion'
    'calc'
    'cmake'
    'curl'
    'direnv'
    'docker'
    'docker-cloud'
    'docker-compose'
    'docker-machine'
    'docker-swarm'
    'dockutil'
    'emacs'
    'ffmpeg'
    'firebase-cli'
    'flow'
    'fzf'
    'gdbm'
    'gettext'
    'ghi'
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
    'neovim'
    'nvm'
    'open-completion'
    'openssl'
    'openssl@1.1'
    'perl'
    'pip-completion'
    'pkg-config'
    'python'
    'python3'
    'python@2'
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
    'docker'
    'firefox'
    'dropbox'
    'google-chrome'
    'google-drive'
    'imageoptim'
    'iterm2-beta'
    'iterm2-nightly'
    'kensington-trackball-works'
    'lastpass'
    'logitech-gaming-software'
    'obs'
    'postman'
    'sketch'
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
  nvm install --lts --latest-npm
  local LTS_VERSION="$(nvm ls lts/* | grep -oE '(\d+\.\d+\.\d+)')"
  nvm alias default $LTS_VERSION && nvm use default
  local npms=(
    'create-react-app'
    'editorconfig'
    'eslint'
    'gulp-cli'
    'jscodeshift'
    'nodemon'
    'serve'
    'standard'
  ); for i in ${npms[@]}; do yarn global add ${i}; done
}

setup_atom(){
  local apms=(
    'aligner'
    'aligner-javascript'
    'atom-beautify'
    'busy-signal'
    'calc'
    'copy-filename'
    'editorconfig'
    'flow-ide'
    'hyperclick'
    'ide-flowtype'
    'intentions'
    'language-babel'
    'linter'
    'linter-eslint'
    'linter-flow'
    'linter-ui-default'
    'minimap'
    'nuclide'
    'nuclide'
    'react'
    'riot'
    'set-syntax'
    'sort-lines'
    'textmate-espresso-libre-syntax'
    'tinytimer'
    'todo-show'
  ); for i in ${apms[@]}; do apm install ${i}; done
}

setup_git(){
  echo "Enter git user.name: "
  read name
  echo "Enter git user.email: "
  read email
  git config --global user.name "${name}"
  git config --global user.email "${email}"
  git config --global core.editor vim
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
