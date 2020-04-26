source ~/.zsh_plugins.sh # Load zsh plugins

source ~/.dotfiles/zsh/env.zsh

source ~/.dotfiles/zsh/options.zsh
source ~/.dotfiles/zsh/functions/functions.zsh
source ~/.dotfiles/zsh/functions/fzf-functions.zsh
source ~/.dotfiles/zsh/functions/git-functions.zsh
source ~/.dotfiles/zsh/functions/fzf-docker-kubetcl.zsh
source ~/.dotfiles/zsh/alias.zsh
source ~/.dotfiles/zsh/private.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
