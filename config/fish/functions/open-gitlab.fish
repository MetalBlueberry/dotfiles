# Defined in /tmp/fish.DoiLqL/open-gitlab.fish @ line 2
function open-gitlab
    set url (git remote -v | head -n 1 | cut  -f 2 | cut -d " " -f 1 | tr ":" "/")
    echo $url
    google-chrome $url
end
