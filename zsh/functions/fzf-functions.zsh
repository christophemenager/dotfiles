# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
export FZF_COMPLETION_TRIGGER=','

# Custom commands
# --------------

# Pipe command to fzf. f <cmd>
f(){
  "$@" | fzf
}

unalias z 2> /dev/null # Unbind z
# z command + fzf
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --reverse --inline-info +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

# fa <dir> - Search dirs and cd to them - TODO: ignore node_modules + other things
fa() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Kill process
fkil() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fh - Repeat history, assumes zsh
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fr - Select commit to rebase onto
fr() {
  git log --graph --color=always --format="%h%C(#ff69b4)%d%C(reset) %s" "$@" | fzf --ansi --reverse --tiebreak=index | grep -o '[a-f0-9]\{7\}' | awk '{print $1"^"}' | xargs git rebase -i
}

# yarn - get yarn commands
_fzf_complete_yarn() {
  # Get all yarn commands
  YARN_COMMANDS=$(cat package.json | jq -r '.scripts' | sed -e 's/  "\(.*\)":\s*\(.*\)$/\1|\2/' | sed -e '1d;$d' | column -t -c 2 -s '|')

  ARGS="$@"
  if [[ $ARGS = 'yarn ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $YARN_COMMANDS
    )
  fi
}
_fzf_complete_yarn_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}
[ -n "$BASH" ] && complete -F _fzf_complete_yarn -o default -o bashdefault yarn

# fca - amend in selected commit
fca() {
  COMMIT=$(git log --pretty=oneline | fzf | awk '{print $1}')
  git commit --fixup $COMMIT
  GIT_SEQUENCE_EDITOR=: git rebase --autosquash -i $COMMIT\^
}

# make - get make commands
_fzf_complete_make() {
  # Get all make commands
  MAKE_COMMANDS=$(grep '^[^#[:space:]].*:' Makefile)

  ARGS="$@"
  if [[ $ARGS = 'make ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $MAKE_COMMANDS
    )
  fi
}
_fzf_complete_make_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}
[ -n "$BASH" ] && complete -F _fzf_complete_make -o default -o bashdefault make

