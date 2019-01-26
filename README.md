# Bash

Designed to make knowing the state of your development easier

## Terminal Propmt 
If there is no internet avaiable to compare to github output will appear like this:  
  `John-Smith's-MacBook-Pro@~/Developer/Bash(no internet)%master%$`  
If connected to the internet it will change colors indicating current branchs state relative to origin  
  output would look like this with colors changing for the `(branch)%master%` portion:  
  `John-Smith's-MacBook-Pro@~/Developer/Bash(branch)%master%$`  
  -green indicates up to date  
  -yellow indicates the origin is newer than local  
  -magenta indicates origin is behind local  
  -red indicates there may be some weirdness between them  
If the remote has an upstream additional details will be provided in the parens like this:  
  `Peter-Gs-MacBook-Pro@~/Developer/front-end(up to date)develop`  
  `Peter-Gs-MacBook-Pro@~/Developer/front-end(upstream updated)develop`  
  Colors in the parens will also be provided to provide insite:  
  -green indicates up to date with upstream develop  
  -yellow indicates the upstream is newer than local  
  -magenta indicates upstream is behind local  
  -red indicates there may be some weirdness between them  

## aliases
cleanUpBranches - this will delete ever branch locally except the develop branch

getLatestDevelop - this will merge develop into the current branch

updateToDevelop - this will merge current branch with develop

updateBranch - this will rebase develop from upstream and them merge it with current branch

pushToOrigin - this will push the current branch to origin

pushBash - this is copy bashProfile to local git folder and then push it origin