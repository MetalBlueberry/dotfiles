function safe-screenshot
     gnome-screenshot -acf /tmp/test

     set imgdir "/home/victor/Documents/screenshots/github.com/form3tech/fps-gateway/img"
     set imgname (echo (cat /tmp/test | md5sum | cut -f 1 -d " " )".png")
     set imgpath (echo $imgdir"/"$imgname)

     mv /tmp/test $imgpath

     cd $imgdir
     git add .
     git commit -m "screenshot"

     echo "!["$imgname"](https://github.com/form3tech/fps-gateway/blob/"(git rev-parse HEAD)"/img/"$imgname"?raw=true)" | xclip -i -selection clipboard
     notify-send "ready"
     git push
     notify-send "done"
end

