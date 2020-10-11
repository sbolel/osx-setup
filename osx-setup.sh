#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

brew_get_head() {
  brew update
  brew upgrade
  brew cask upgrade
  brew cleanup
}

brew_install() {
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # Tap sources
  local taps=('homebrew/cask' 'homebrew/cask-fonts' 'homebrew/cask-versions' 'homebrew/core' 'mongodb/brew');
  for i in "${taps[@]}"; do brew tap "${i}"; done

  # Update & cleanup
  brew_get_head

  # Install Kegs
  local kegs=(
    'adns' 'bash-completion@2' 'brew-cask-completion' 'calc' 'contentful-cli' 'curl-openssl' 'dockutil' 'ffmpeg'
    'firebase-cli' 'flow' 'fzf' 'gettext' 'gh' 'git' 'git-extras' 'googler' 'gnupg2' 'grep' 'htop' 'jpeg' 'jq' 'lame'
    'mongocli' 'ncurses' 'neovim' 'nettle' 'nvm' 'oniguruma' 'open-completion' 'openssl@1.1' 'pinentry-mac'
    'pip-completion' 'prettier' 'pyenv' 'python@3.8' 'readline' 'speedtest-cli' 'shellcheck' 'shfmt' 'sqlite'
    'subversion' 'the_silver_searcher' 'tig' 'trash' 'tree' 'wget' 'yarn' 'yarn-completion' 'zsh-completions'
  ); for i in "${kegs[@]}"; do brew install "${i}"; done;

  # Install Casks
  local casks=(
    'adobe-acrobat-reader' 'brave-browser' 'gimp' 'google-cloud-sdk' 'imageoptim' 'iterm2-beta' 'java' 'microsoft-teams'
    'obs' 'postman' 'pycharm' 'react-studio' 'slack' 'spectacle' 'spotify' 'steam' 'visual-studio-code' 'webstorm'
  ); for i in "${casks[@]}"; do brew cask install "${i}"; done;

  # Install Fonts
  local fonts=(
    '3270-nerd-font' 'agave-nerd-font' 'andale-mono' 'anonymice-nerd-font' 'arimo-nerd-font'
    'aurulent-sans-mono-nerd-font' 'average' 'average-mono' 'average-sans' 'awesome-terminal-fonts' 'b612-mono'
    'bigblue-terminal-nerd-font' 'bitstream-vera-sans-mono-nerd-font' 'blex-mono-nerd-font' 'cascadia-code'
    'cascadia-mono' 'caskaydia-cove-nerd-font' 'code-new-roman-nerd-font' 'cousine-nerd-font' 'crimson-pro'
    'crimson-text' 'cutive-mono' 'daddy-time-mono-nerd-font' 'dejavu-sans-mono-nerd-font' 'droid-sans-mono-nerd-font'
    'fantasque-sans-mono-nerd-font' 'fira-code-nerd-font' 'fira-mono-nerd-font' 'go-mono-nerd-font'
    'gohufont-nerd-font' 'hack-nerd-font' 'hackgen-nerd' 'hasklug-nerd-font' 'heavy-data-nerd-font' 'hurmit-nerd-font'
    'ibm-plex' 'ibm-plex-mono' 'ibm-plex-sans' 'ibm-plex-sans-condensed' 'ibm-plex-serif' 'im-writing-nerd-font'
    'inconsolata-go-nerd-font' 'inconsolata-lgc-nerd-font' 'inconsolata-nerd-font' 'iosevka-nerd-font'
    'jetbrains-mono-nerd-font' 'lekton-nerd-font' 'liberation-nerd-font' 'major-mono-display' 'meslo-lg-nerd-font'
    'miriam-libre' 'miriam-mono-clm' 'monofur-nerd-font' 'monoid-nerd-font' 'mononoki-nerd-font' 'mplus-nerd-font'
    'noto-nerd-font' 'open-dyslexic-nerd-font' 'overpass-nerd-font' 'profont-nerd-font' 'proggy-clean-tt-nerd-font'
    'pt-mono' 'roboto-mono' 'roboto-mono-nerd-font' 'sauce-code-pro-nerd-font' 'shure-tech-mono-nerd-font'
    'space-mono-nerd-font' 'sudo' 'terminess-ttf-nerd-font' 'times-new-roman' 'tinos-nerd-font' 'twitter-color-emoji'
    'ubuntu' 'ubuntu-condensed' 'ubuntu-mono' 'ubuntu-mono-nerd-font' 'ubuntu-nerd-font' 'victor-mono-nerd-font'
  ); for i in "${fonts[@]}"; do brew cask install "font-${i}"; done;
}

install_node(){
  [[ -f '/usr/local/opt/nvm/nvm.sh' ]] && . '/usr/local/opt/nvm/nvm.sh'
  nvm install --lts --latest-npm
  LTS_VERSION="$(nvm ls lts/* | grep -oE '(\d+\.\d+\.\d+)')"
  nvm alias default "$LTS_VERSION" && nvm use default
}

install_python(){
  pyenv init
  pyenv install 3.7.8
  pyenv install 2.7.18
  pyenv global 3.7.8 2.7.18
  pip install --upgrade pip
  pip install --user pipenv
}

setup_git(){
  # echo "Enter git user.name: " && read name
  # echo "Enter git user.email: " && read email
  local name='Sinan Bolel'
  local email='sbolel@noreply.users.github.com'
  git config --global color.branch 'auto'
  git config --global color.diff 'auto'
  git config --global color.interactive 'auto'
  git config --global color.status 'auto'
  git config --global commit.gpgsign 'true'
  git config --global core.editor 'nvim'
  git config --global core.excludesfile "$HOME/.global.gitignore"
  git config --global github.user 'sbolel'
  git config --global gpg.program 'gpg'
  git config --global pull.ff 'only'
  git config --global push.default 'current'
  git config --global tag.forcesignannotated 'true'
  git config --global user.email "${email}"
  git config --global user.name "${name}"
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

gpg_import() {
  cd $HOME/Downloads
  wget https://mullvad.net/media/mullvad-code-signing.asc && \
    gpg --import mullvad-code-signing.asc && \
    rm mullvad-code-signing.asc
}

# ---------------------------------------------------------

brew_install
brew_get_head
setup_git
install_node
install_python
speedup_osx
symlink_jsc
