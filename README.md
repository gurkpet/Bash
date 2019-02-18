# Bash

Designed to make knowing the state of your development easier

## Instructions
  Update `.gshell_private.sh.bak` by removing the `.bak` and then add source `/path/to/repo/.ghsell_master.sh` to your `.bash_profile` or `.bashrc`.  Then either open a new terminal or run `source ~/.bash_profile` to refresh your shell.  You should be good to go.

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

pullDevelop - this will rebase develop from upstream and them merge it with current branch

pushToOrigin - this will push the current branch to origin

pushToLabs - will create a new branch called labs/$OldBranch/$currentYYYYMMDDHHMMSS, push it to upstream, switch back to original branch, and finanally delete the labs branch it created.

reshell - will update your shell br resourcing `~/.bash_profile` to get access to any changes