function screenshot
    # Ensure Screenshots directory exists
    set -l screenshot_dir $HOME/Pictures/Screenshots
    mkdir -p $screenshot_dir

    # Generate timestamp-based filename
    set -l timestamp (date '+%Y-%m-%d_%H-%M-%S')
    set -l filename "$screenshot_dir/screenshot_$timestamp.png"

    # Take screenshot and copy to clipboard
    if gnome-screenshot -acf $filename
        cat $filename | xclip -i -selection clipboard -target image/png
        echo "Screenshot saved to: $filename"
    else
        echo "Failed to take screenshot"
        return 1
    end
end
