function note
    set basedir ~/.notes
    set category (find $basedir/**.md -type f | fzf)
    cursor --no-sandbox  $basedir -g $category
end
