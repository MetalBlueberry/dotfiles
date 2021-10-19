# Defined in /tmp/fish.h0CBTw/fzf-ag-bat-preview.fish @ line 2
function fzf-ag-bat-preview
    set file (echo {} | cut -d ":" -f 1,2)
    echo $file
    batcat --style=numbers --color=always --line-range :500 $file

end
