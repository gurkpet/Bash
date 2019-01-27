forkMagic() {
  if ! brew ls --versions hub > /dev/null; then
    brew install hub
  fi
  
  git remote rename origin upstream
  hub fork

  USERNAME=$(git config user.name)
  git remote rename $USERNAME origin
  git remote set-url --push upstream no_push
}

alias forkAndConfigOriginAndUpstream=forkMagic