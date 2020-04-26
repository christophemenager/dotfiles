# Setting and editing of env variables.

# Vars
export EDITOR='nvim'
export SUDO_EDITOR='nvim'

export ANDROID_HOME=/Users/christophmenager/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

export BASE16_SHELL="$HOME/.config/base16-shell/" # Base 16
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export LC_ALL=en_US.UTF-8 # Fastlane config
export LANG=en_US.UTF-8 # Fastlane config
export FASTLANE_HIDE_CHANGELOG=true # Fastlane config

# Path
export PATH=$PATH:/Users/christophmenager/Library/Android/sdk/platform-tools # Android
export PATH=$PATH:/Users/christophmenager/Library/Android/sdk/tools # Android
export PATH=$PATH:/Users/christophmenager/Library/Flutter/bin # Flutter
export PATH="$PATH:$HOME/.rvm/bin" #RVM
export PATH="$PATH:$HOME/Library/Python/3.7/bin" # python

typeset -U PATH # Remove duplicates in $PATH
