function checkout
  set branches (git --no-pager branch -vv) 
  set branch( echo "$branches" | fzf +m) 
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
end
