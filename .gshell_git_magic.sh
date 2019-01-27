forkMagic() {
  if ! brew ls --versions hub > /dev/null; then
    # docs @ https://hub.github.com/
    brew install hub
  fi
  
  git remote rename origin upstream
  hub fork --remote-name=origin
}

alias forkAndConfigOriginAndUpstream=forkMagic