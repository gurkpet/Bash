alias cleanUpBranches="git branch | grep -v "develop" | xargs git branch -D"

pullDevelop() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git checkout develop
  git pull --rebase upstream develop
  git checkout $CURRENT_BRANCH
  git merge develop
}

alias updateBranch=updateBranch

pushToOrigin() {
  CURRENT_BRANCH=$(git branch 2> /dev/null|sed -e'/^[^*]/d' -e's/* \(.*\)/\1/')
  git push origin $CURRENT_BRANCH
}

alias pushToOrigin=pushToOrigin

alias reshell="source ~/.bash_profile"