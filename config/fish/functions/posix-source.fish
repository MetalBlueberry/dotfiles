function posix-source
	for i in (cat $argv | grep -v "^#" | grep =)
        echo $i
		set arr (string split "=" -m 1 $i)
  		set -gx $arr[1] $arr[2]
	end
end
