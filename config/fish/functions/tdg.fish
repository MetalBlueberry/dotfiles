# Defined in /tmp/fish.tZHrIa/tdg.fish @ line 1
function tdg
    td  -i -g (td lg | grep -P ":.*:" | grep -v "UNGROUP" | cut -d ":" -f 1 | fzf --ansi )
end
