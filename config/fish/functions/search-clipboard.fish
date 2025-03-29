function search-clipboard
	blueclip client list | fzf --gap --read0 --print0 --bind 'change:first'  | blueclip client copy -c primary -c clipboard
	# --preview-window right:wrap --preview 'echo {} | blueclip client print -u'
end
