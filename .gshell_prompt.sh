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
      if git config remote.origin.url > /dev/null; then
        if git branch -a | egrep remotes/origin/develop 1> /dev/null; then
          UPSTREAM_MAIN_BRANCH='develop'
        else
          UPSTREAM_MAIN_BRANCH='master'
        fi
        git fetch origin $UPSTREAM_MAIN_BRANCH  --quiet
        UPSTREAM=${1:-'@{u}'}
        REMOTE=$(git rev-parse origin/$UPSTREAM_MAIN_BRANCH)
        BASE=$(git merge-base @ origin/$UPSTREAM_MAIN_BRANCH)
        # Matches develop
        if [ $LOCAL = $REMOTE ]; then
          DEVELOP_STATUS="$GREEN"
          DEVELOP_MESSAGE="(up to date)"
        #Need to pull
        elif [ $LOCAL = $BASE ]; then
          DEVELOP_STATUS="$YELLOW"
          DEVELOP_MESSAGE="(master updated)"
        #Ahead of develop
        elif [ $REMOTE = $BASE ]; then
          DEVELOP_STATUS="$GREEN"
          DEVELOP_MESSAGE="(up to date)"
        else
          DEVELOP_STATUS="$RED"
          DEVELOP_MESSAGE="(master updated)"
        fi
      else
        DEVELOP_STATUS="$GREEN"
        DEVELOP_MESSAGE="(master matched)"
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
        if [ $LOCAL = $REMOTE ]; then
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