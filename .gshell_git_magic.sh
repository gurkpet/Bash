forkMagic() {
  if ! brew ls --versions hub > /dev/null; then
    # docs @ https://hub.github.com/
    echo Hub is an extension produced by github.com.  See at https://hub.github.com/
    brew install hub
    echo Hub is an extension produced by github.com.  See at https://hub.github.com/
  fi
  
  git remote rename origin upstream
  hub fork --remote-name=origin

  git remote set-url --push origin no_push
}

alias forkAndConfigOriginAndUpstream=forkMagic