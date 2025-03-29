function search-clipboard
	blueclip client list | fzf --read0 --print0 --bind 'change:first' --preview-window right:wrap --preview 'echo {} | blueclip client print -u' | blueclip client copy -c primary -c clipboard
	return
	blueclip client list | fzf --read0 --bind 'change:first' --preview-window right:wrap --preview 'echo {} | blueclip client print -u' | blueclip
	xsel -b | xsel -pi
end
