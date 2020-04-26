# Update Zsh plugins
uz(){
  antibody bundle <~/.dotfiles/zsh/plugins.txt >~/.zsh_plugins.sh
  antibody update
}

# Android emulator
function emulator { ( cd "$(dirname "$(whence -p emulator)")" && ./emulator "$@"; ) }

# md <folder-name> - Create folder and cd to it
md(){
  mkdir "$1"
  cd "$1"
}

# React Native Android reload
ar(){
  adb shell input keyevent 82
}
