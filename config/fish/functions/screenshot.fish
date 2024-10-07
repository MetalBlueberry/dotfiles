function screenshot
    gnome-screenshot -acf /tmp/test.png && cat /tmp/test.png | xclip -i -selection clipboard -target image/png
end
