function screenshot
    gnome-screenshot -acf /tmp/test && cat /tmp/test | xclip -i -selection clipboard -target image/png
end
