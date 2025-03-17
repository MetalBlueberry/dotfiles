function search-clipboard
	greenclip print | grep . | fzf -e --preview-window right:wrap --preview='echo {} | grep --color=always {q}' | xargs -r -d'\n' -I '{}' greenclip print '{}'       
end
