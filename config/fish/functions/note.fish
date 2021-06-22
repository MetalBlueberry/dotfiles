function note
    set basedir ~/.notes
    set category (ls $basedir | fzf)
    vim $basedir/$category
end