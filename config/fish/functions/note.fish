function note
    set basedir ~/.notes
    set category (find $basedir/**.md -type f | fzf)
    code $basedir -g $category
end
