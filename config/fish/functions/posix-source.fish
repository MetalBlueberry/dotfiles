function posix-source
	for i in (cat $argv | grep -v "^#" | grep =)
		set arr (echo $i |tr = \n)
        echo $arr[1] = (string join '=' $arr[2..-1])

  		set -gx $arr[1] (string join '=' $arr[2..-1])
	end
end
