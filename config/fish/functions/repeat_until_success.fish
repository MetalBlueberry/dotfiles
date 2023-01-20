function repeat_until_success
    set seconds 1
    while true
        # Run the command
        $argv; and break
        # Sleep for an increasing amount of time before trying again
        if $seconds > 30
            set seconds 30
        end
        sleep $seconds
        set seconds (math $seconds * 2)
    end
end
