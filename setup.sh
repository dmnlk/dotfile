#for xcode
#sudo xcode-build --licence

#install homebrew
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#for homebrew
brew update
#if already installed cask from old repo, unlink it

brew unlink brew-cask
brew install caskroom/cask/brew-cask
brew upgrade brew-cask

brew tap caskroom/versions


brew install tomcat
brew install node
brew install go
brew install tmux
brew install zsh
brew install nkf
brew install htop-osx
brew install csshx


# from homebrew-cask
brew cask install google-chrome
brew cask install sublime-text
brew cask install virtualbox
brew cask install vagrant
brew cask install keyremap4macbook
brew cask install iterm2
brew cask install eclipse-ide
brew cask install google-japanese-ime
brew cask install limechat
brew cask install tunnelblick
brew cask install alfred
brew cask install skype
brew cask install gas-mask
brew cask install sourcetree
brew cask install java
brew cask install java7

# for alfred hack
brew cask alfred link

brew cleanup

brew cask cleanup



## Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "NO"

# Keyboard
## Remap Caps Lock key to Control
keyboardid=$(ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' -)'-0'
defaults -currentHost delete -g com.apple.keyboard.modifiermapping.${keyboardid}
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboardid} -array-add '<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'


# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Enable tap to click (Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true



# enable settings
for app in Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done
