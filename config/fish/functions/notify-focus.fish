function notify-focus
    # Check if the required parameters are provided
    if test (count $argv) -lt 2
        echo "Usage: notify-focus WINDOW_ID MESSAGE"
        return 1
    end

    # Get the WINDOW_ID and MESSAGE from the function parameters
    set WINDOW_ID $argv[1]
    set MESSAGE $argv[2..-1]  # Get all remaining arguments as the message

    echo "$WINDOW_ID"
    # Display the notification
    set ACTION (dunstify --action="focus,focus" "$MESSAGE")

    # Process the notification action
    switch $ACTION
    case "default"
        # Nothing
    case "focus"
    	# Display the notification
        xdotool windowactivate $WINDOW_ID
    case "2"
        # Nothing
    end
end
