#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

brew_get_head() {
  brew update; brew upgrade; brew cask upgrade
  brew prune; brew cleanup; brew cask cleanup
}

brew_install() {
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # Tap sources
  local taps=(
    'homebrew/cask'
    'homebrew/cask-fonts'
    'homebrew/cask-versions'
    'homebrew/core'
    'mongodb/brew'
  ); for i in ${taps[@]}; do brew tap ${i}; done

  # Update & cleanup
  brew_get_head

  # Install Kegs
  local kegs=(
    'curl-openssl'
    'gnupg'
    'gpg2'
    'pinentry-mac'
    'wget'
    'adns'
    'calc'
    'dockutil'
    'ffmpeg'
    'firebase-cli'
    'flow'
    'fzf'
    'gettext'
    'ghi'
    'git'
    'git-extras'
    'google-cloud-sdk'
    'googler'
    'grep'
    'htop'
    'hub'
    'jpeg'
    'jq'
    'lame'
    'mongocli'
    'mongodb'
    'neovim'
    'nettle'
    'nvm'
    'pipenv'
    'pyenv'
    'python@3.7'
    'python@3.8'
    'readline'
    'speedtest-cli'
    'the_silver_searcher'
    'tig'
    'trash'
    'tree'
    'yarn'
    'brew-cask-completion'
    'curl-bash-completion@2'
    'open-completion'
    'pip-completion'
    'yarn-completion'
    'zsh-completions'
  ); for i in ${kegs[@]}; do brew install ${i}; done

  # Install Casks
  local casks=(
    'adobe-acrobat-reader'
    'ccleaner'
    'gimp'
    'imageoptim'
    'iterm2-beta'
    'java'
    'obs'
    'postman'
    'slack'
    'spotify'
    'steam'
    'spectacle'
    'visual-studio-code'
    'font-3270-nerd-font'
    'font-agave-nerd-font'
    'font-anonymice-nerd-font'
    'font-arimo-nerd-font'
    'font-aurulent-sans-mono-nerd-font'
    'font-bigblue-terminal-nerd-font'
    'font-bitstream-vera-sans-mono-nerd-font'
    'font-caskaydia-cove-nerd-font'
    'font-code-new-roman-nerd-font'
    'font-cousine-nerd-font'
    'font-daddy-time-mono-nerd-font'
    'font-dejavu-sans-mono-nerd-font'
    'font-droid-sans-mono-nerd-font'
    'font-fantasque-sans-mono-nerd-font'
    'font-fira-code-nerd-font'
    'font-fira-mono-nerd-font'
    'font-go-mono-nerd-font'
    'font-gohufont-nerd-font'
    'font-hack-nerd-font'
    'font-hackgen-nerd'
    'font-hasklug-nerd-font'
    'font-heavy-data-nerd-font'
    'font-hurmit-nerd-font'
    'font-im-writing-nerd-font'
    'font-inconsolata-lgc-nerd-font'
    'font-inconsolata-nerd-font'
    'font-iosevka-nerd-font'
    'font-jetbrains-mono-nerd-font'
    'font-lekton-nerd-font'
    'font-liberation-nerd-font'
    'font-meslo-lg-nerd-font'
    'font-monofur-nerd-font'
    'font-monoid-nerd-font'
    'font-mononoki-nerd-font'
    'font-mplus-nerd-font'
    'font-noto-nerd-font'
    'font-open-dyslexic-nerd-font'
    'font-overpass-nerd-font'
    'font-profont-nerd-font'
    'font-proggy-clean-tt-nerd-font'
    'font-roboto-mono-nerd-font'
    'font-sauce-code-pro-nerd-font'
    'font-shure-tech-mono-nerd-font'
    'font-space-mono-nerd-font'
    'font-terminess-ttf-nerd-font'
    'font-tinos-nerd-font'
    'font-ubuntu-mono-nerd-font'
    'font-ubuntu-nerd-font'
    'font-victor-mono-nerd-font'
  ); for i in ${casks[@]}; do brew cask install ${i}; done
}

install_node(){
  nvm install --lts --latest-npm
  local LTS_VERSION="$(nvm ls lts/* | grep -oE '(\d+\.\d+\.\d+)')"
  nvm alias default $LTS_VERSION && nvm use default
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
setup_git
install_node
symlink_jsc
speedup_osx
