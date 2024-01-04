let s:dir=expand('<sfile>:p:h').'/colorscheme'

" nnoremap <leader>c0 :colorscheme default<cr>
" nnoremap <leader>c1 :colorscheme custom-dark<cr>
" nnoremap <leader>c2 :colorscheme custom-light<cr>
exe 'nnoremap <leader>c0 :colorscheme default<cr>'
exe 'nnoremap <leader>c1 :source '.s:dir.'/custom-dark.vim<cr>'
exe 'nnoremap <leader>c2 :source '.s:dir.'/custom-light.vim<cr>'

exe "source ".s:dir."/custom-dark.vim"
