alias cleanUpBranches="git branch | grep -v "develop" | xargs git branch -D"

pullDevelop() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git checkout master
  git pull --rebase origin master
  git checkout $CURRENT_BRANCH
  git merge master
}

newBranch() {
  COMMIT_PREFIX=$(echo $1 | cut -c1-9)
  SISU_TAG=$(echo $COMMIT_PREFIX | cut -c1-4)
  JIRA_NUMBER=$(echo $COMMIT_PREFIX | cut -c6-9)
  if [ "$SISU_TAG" != "SISU" ]
  then
    echo "error: Must start with 'SISU' (eg: SISU-####)"
  elif [[ $JIRA_NUMBER =~ [^[:digit:]] ]]
  then 
    echo "error: Must have a valid 4 digit number (eg: SISU-####)'"
  else
    git checkout -b $@
    git commit --allow-empty -m $@
  fi
}


pushToOrigin() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git push origin $CURRENT_BRANCH
}

clearDocker() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}

alias pushToOrigin=pushToOrigin

alias reshell="source ~/.bash_profile"