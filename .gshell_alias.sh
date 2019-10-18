alias cleanUpBranches="git branch | grep -v "develop" | xargs git branch -D"

pullDevelop() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git checkout master
  git pull --rebase origin master
  git checkout $CURRENT_BRANCH
  git merge master
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