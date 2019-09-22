nmap <leader>r <Plug>(go-run)
nmap <leader>b <Plug>(go-build)
nmap <leader>i <Plug>(go-info)

nmap <leader>l <Plug>(go-lint)
nmap <leader>v <Plug>(go-vet)

nmap <leader>fi <Plug>(go-imports)


" Ensure debuger runs in full screen
let g:delve_new_command = "enew"
nmap <leader>t :DlvToggleBreakpoint<CR>
nmap <leader>T :DlvTest<CR>
nmap <leader>R :DlvDebug<CR>
