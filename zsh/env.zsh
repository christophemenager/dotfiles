# Setting and editing of env variables.

# Vars
export EDITOR='nvim'
export SUDO_EDITOR='nvim'

export ANDROID_HOME=/Users/christophemenager/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

export BASE16_SHELL="$HOME/.config/base16-shell/" # Base 16
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export LC_ALL=en_US.UTF-8 # Fastlane config
export LANG=en_US.UTF-8 # Fastlane config

# Path
export PATH=$PATH:/Users/christophemenager/Library/Android/sdk/platform-tools # Android
export PATH=$PATH:/Users/christophemenager/Library/Android/sdk/tools # Android
export PATH=$PATH:/Users/christophemenager/Library/Android/sdk/tools/bin
export PATH=$PATH:/usr/local/bin/adb
export PATH=$PATH:/Users/christophemenager/Library/Flutter/bin # Flutter
export PATH="$PATH:$HOME/.rvm/bin" #RVM
export PATH="$PATH:$HOME/Library/Python/3.7/bin" # python
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
export PATH=$PATH:$JAVA_HOME/bin


typeset -U PATH # Remove duplicates in $PATH
