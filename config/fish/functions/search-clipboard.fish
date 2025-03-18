function search-clipboard
	set -l tmpfile (mktemp)

	greenclip print | grep . | fzf --preview-window right:wrap --preview='echo {} | grep -i --color=always {q}'  > $tmpfile

	# Copy edited content back to clipboard
	greenclip print (cat $tmpfile)
	xsel -b | xsel -bi
	xsel -b | xsel -pi

	rm $tmpfile
	
end
