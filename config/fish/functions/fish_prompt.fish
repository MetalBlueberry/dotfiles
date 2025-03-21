function fish_prompt
    if [ $status -ne 0 ]
        set retc red
    else
        set retc green
    end

    # - green lines if the last return command is OK, red otherwise
    # - your user name, in red if root or yellow otherwise
    # - your hostname, in cyan if ssh or blue otherwise
    # - the current path (with prompt_pwd)
    # - date +%X
    # - the current virtual environment, if any
    # - the current git status, if any, with __fish_git_prompt
    # - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
    # - current background jobs, if any

    # It goes from:
    # ┬─[nim@Hattori:~]─[11:39:00]
    # ╰─>$ echo here

    # To:
    # ┬─[nim@Hattori:~/w/dashboard]─[11:37:14]─[V:django20]─[G:master↑1|●1✚1…1]─[B:85%, 05:41:42 remaining]
    # │ 2	15054	0%	arrêtée	sleep 100000
    # │ 1	15048	0%	arrêtée	sleep 100000
    # ╰─>$ echo there

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end


    set_color $retc
    echo -n '┬─'
    set_color -o green
    echo -n [
    if test "$USER" = root -o "$USER" = toor
        set_color -o red
    else
        set_color -o yellow
    end
    echo -n $USER
    set_color -o white
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname)
    set_color -o white
    echo -n :(prompt_pwd)
    set_color -o green
    echo -n ']'

    # Date
    #_nim_prompt_wrapper $retc '' (date +%X)

    # git
    set prompt_git (__fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc G $prompt_git

    if test $CMD_DURATION -ge "20000"
        set lastcmd (string escape -- $history[1])
        fish -c "notify-focus $WINDOW_ID $lastcmd" & disown
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga & disown
        set CMD_DURATION 0
    end
    ## Set the window ID to the currect active window that most likely
    ## will be the one you just opened. 
    ## Then recover it to send it to the notification as an action
    ## Not bullet proof... but works most of the time
    set -g WINDOW_ID (xdotool getactivewindow)


    # set docker_context (docker context ls --format "{{if .Current }}{{.Name}}{{end}}" | grep -v -e '^$'^C)
    set docker_context $DOCKER_CONTEXT
    test -n "$docker_context"
    and _nim_prompt_wrapper $retc D $docker_context

    type -q "kubectl" 
    and set kubectl_context (kubectl config current-context)
    test -n "$kubectl_context"
    and _nim_prompt_wrapper $retc k8s $kubectl_context

    set aws_env $AWS_PROFILE
    test -n "$AWS_PROFILE"
    and _nim_prompt_wrapper $retc AWS $AWS_PROFILE


    # Battery status
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

    # New line
    echo

    # Background jobs
    set_color normal
    for job in (jobs)
        set_color $retc
        echo -n '│ '
        set_color brown
        echo $job
    end
    set_color normal
    set_color $retc
    echo -n '╰─>'
    set_color -o red
    echo -n '$ '
    set_color normal
end
