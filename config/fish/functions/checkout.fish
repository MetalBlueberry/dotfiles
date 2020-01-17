# Defined in /tmp/fish.Pr1NVJ/checkout.fish @ line 2
function checkout
	set branch (git --no-pager branch -vv | fzf +m -q $argv) 
    git checkout (echo "$branch" | awk '{print $1}' | sed "s/.* //")
end
