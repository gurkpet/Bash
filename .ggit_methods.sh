#!/usr/bin/env sh

array_contains () { 
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

git_safe_push () {
  protected_branch=('master', 'develop')
  current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

  on_protected_branch=false
echo 'test'
  for item in "${protected_branch[@]}"; do
    if [[ "array_contains $current_branch $protected_branch" ]]; then
      on_protected_branch=true
    fi
    done

  if [ $on_protected_branch = true ]
    then
        read -p "You're about to push to a protect branch, is that what you intended? [y|n] " -n 1 -r < /dev/tty
        echo
        if echo $REPLY | grep -E '^[Yy]$' > /dev/null
        then
            return 0 # push will execute
        fi
        return 1 # push will not execute
    else
        return 0 # push will execute
  fi
}

alias git_safe_push=git_safe_push