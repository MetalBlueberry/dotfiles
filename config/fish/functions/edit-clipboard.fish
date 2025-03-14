function edit-clipboard
    set -l tmpfile (mktemp)

    # Get clipboard content and save to temp file
    xsel -b > $tmpfile

    # Edit the temp file with vim
    vim $tmpfile

    # Copy edited content back to clipboard
    cat $tmpfile | xsel -bi

    # Clean up temp file
    rm $tmpfile
end
