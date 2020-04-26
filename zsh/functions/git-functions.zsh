
# Open a PR on Github with GPR
gpr() {
  cd $(git rev-parse --show-toplevel)
  TITLE=${1}
  MESSAGE=$(echo $TITLE'\n' | cat - ./PULL_REQUEST_TEMPLATE.md)
  hub pull-request -m "${MESSAGE}" -b ${2:-"master"} --browse
}

# Cd to root dir of git project
gr() {
  cd $(git rev-parse --show-toplevel)
}

# Commit all in a Work in progress commit
wip() {
  gr
  git add .
  git ci ':construction: Work in progress'
}

# Unwip: Reset HEAD to previous commit
unwip() {
  git reset HEAD~1
}

# md <folder-name> - Create folder and cd to it
md(){
  mkdir "$1"
  cd "$1"
}

# gb <branch-name> - Create a new branch and check it out
gb(){
  git co -b $1
}

# gcl - Clean working tree and untracked folder
gcl(){
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  NC='\033[0m' # No Color
  printf "${RED}WARNING${NC} ☢️  Are you sure you want to ${RED}clean${NC} your working directory? [y/n]\n"
  printf "${YELLOW}Ready to run:${NC} ❯ git reset --hard && git clean -fd ${YELLOW}Answer:${NC} "
  read choice
  case "$choice" in 
    y|Y ) git reset --hard && git clean -fd;;
    * ) echo "\n⏹  Operation aborted\n";;
  esac
}
