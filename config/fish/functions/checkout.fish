# Defined in /tmp/fish.QnEs8A/checkout.fish @ line 2
function checkout
	set branch (git --no-pager branch -vv | fzf +m) 
    git checkout (echo "$branch" | awk '{print $1}' | sed "s/.* //")
end
