source ~/git-completion.bash 2> /dev/null
source ~/.bash_private 2> /dev/null

RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
CYAN="\[\033[01;36m\]"
MAGENTA="\[\033[95m\]"
NO_COLOR="\[\033[0m\]"

user="$GREEN\u"
host="$CYAN\h"
cwd="$YELLOW@\w"
gitbranch="\$(parse_git_branch)"
input="$NO_COLOR$"

parse_git_branch() {

  # Only bother with the git stuff if I am actually in a git repo
  if git rev-parse --git-dir > /dev/null 2>&1; then

    CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
    USER_INFO="$host"
    #check github connection
    wget -q --spider http://github.com

    #if github is resolvable (internet connection present)
    if [ $? -eq 0 ]; then

      LOCAL=$(git rev-parse @)
      #only evaluate upstream if upstream exists
      if git config remote.upstream.url > /dev/null; then
        git fetch upstream develop  --quiet
        UPSTREAM=${1:-'@{u}'}

        REMOTE=$(git rev-parse upstream/develop)
        BASE=$(git merge-base @ upstream/develop)

        # Matches develop
        if [ $LOCAL = $REMOTE ]; then
          DEVELOP_STATUS="$GREEN"
          DEVELOP_MESSAGE="(up to date)"
        #Need to pull
        elif [ $LOCAL = $BASE ]; then
          DEVELOP_STATUS="$YELLOW"
          DEVELOP_MESSAGE="(upstream updated)"
        #Ahead of develop
        elif [ $REMOTE = $BASE ]; then
          DEVELOP_STATUS="$MAGENTA"
          DEVELOP_MESSAGE="(ahead of upstream)"
        else
          DEVELOP_STATUS="$RED"
          DEVELOP_MESSAGE="(upstream updated)"
        fi
      else
        DEVELOP_STATUS="$GREEN"
        DEVELOP_MESSAGE="(branch)"
      fi

      #if the current branch doesn't exist on origin branch status magenta (time to push)
      if git fetch origin "$CURRENT_BRANCH" 2>&1 | grep "fatal:" > /dev/null; then
        BRANCH_STATUS="$MAGENTA"
      else
        REMOTE=$(git rev-parse origin/$CURRENT_BRANCH)
        BASE=$(git merge-base @ $CURRENT_BRANCH)

        if git branch -a | egrep remotes/origin/develop 1> /dev/null; then
          MAIN_BRANCH='develop'
          else
          MAIN_BRANCH='master'
        fi
        # Origin Matches MAIN_BRANCH
        if [ $CURRENT_BRANCH = $MAIN_BRANCH ]; then
          BRANCH_STATUS="$GREEN"
        elif [ $LOCAL = $REMOTE ]; then
          BRANCH_STATUS="$GREEN"
        #Need to push to Origin
        elif [ $LOCAL = $BASE ]; then
          BRANCH_STATUS="$MAGENTA"
        # Ahead of Origin MAIN_BRANCH
        elif [ $REMOTE = $BASE ]; then
          BRANCH_STATUS="$YELLOW"
        else
          BRANCH_STATUS="$RED"
        fi
      fi
    else
      DEVELOP_STATUS="$NO_COLOR"
      DEVELOP_MESSAGE="(no internet)"
      BRANCH_STATUS="$NO_COLOR"
    fi
  else
    USER_INFO="$user@$host"
    DEVELOP_MESSAGE=""
    CURRENT_BRANCH=""
  fi

  PS1="$USER_INFO$cwd$DEVELOP_STATUS$DEVELOP_MESSAGE$BRANCH_STATUS$CURRENT_BRANCH$input "
}

PROMPT_COMMAND=parse_git_branch



export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GOOGLE_APP_ENGINE_DIR=/usr/local/google_appengine

alias cleanUpBranches="git branch | grep -v "develop" | xargs git branch -D"

alias getLatestDevelop='git pull --rebase upstream develop'

alias updateToDevelop='git merge develop'

updateBranch() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git checkout develop
  getLatestDevelop
  git checkout $CURRENT_BRANCH
  updateToDevelop
}

alias updateBranch=updateBranch

pushToOrigin() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git push origin $CURRENT_BRANCH
}

alias pushToOrigin=pushToOrigin

updateBash() {
  CURRENT_DIR=$(pwd)
  cd $PATH_TO_YOUR_DEVELOPER_FOLDER/bash
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git checkout master
  cp ~/.bash_profile $PATH_TO_YOUR_DEVELOPER_FOLDER/bash/.bash_profile
  git add .bash_profile
  git commit -m "latest bash update"
  git push origin master
  git checkout $CURRENT_BRANCH
  cd "$CURRENT_DIR"
}

alias updateBash=updateBash

alias reshell="source ~/.bash_profile"

export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$PATH_TO_YOUR_DEVELOPER_FOLDER/google-cloud-sdk/path.bash.inc' ]; then . '$PATH_TO_YOUR_DEVELOPER_FOLDER/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$PATH_TO_YOUR_DEVELOPER_FOLDER/google-cloud-sdk/completion.bash.inc' ]; then . '$PATH_TO_YOUR_DEVELOPER_FOLDER/google-cloud-sdk/completion.bash.inc'; fi
