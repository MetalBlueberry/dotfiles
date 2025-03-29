function clean-clipboard
	blueclip client list | fzf --multi --read0 --print0 --gap --bind 'change:first' --preview-window right:wrap --preview 'echo {} | blueclip client print -u' | blueclip client clear

end
