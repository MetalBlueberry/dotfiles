function search-clipboard
	blueclip client list | fzf --bind 'change:first' --preview-window right:wrap --preview 'echo {} | blueclip client print -u' | blueclip client copy -c primary -c clipboard
	return
	xsel -b | xsel -pi
end
