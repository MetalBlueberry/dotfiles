function fzf_configure_bindings
    # Directory listing
    bind \cf '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \cp '__fzf_find_process'
    bind \cv '__fzf_find_variable'
    bind \cg '__fzf_find_git_log'
    bind \cs '__fzf_find_git_status'
end 