let s:template_dir=expand('<sfile>:p:h').'/template'

exe 'nnoremap <leader>tc <esc>:r '.s:template_dir.'/template.c<cr>kdd'
exe 'nnoremap <leader>th <esc>:r '.s:template_dir.'/template.html<cr>kdd'
exe 'nnoremap <leader>tm <esc>:r '.s:template_dir.'/template.md<cr>kdd'

" haskell
inoremap hsext {-# LANGUAGE  #-}<esc>F<space>i
" latex
exe 'inoremap myitemize <esc>:r '.s:template_dir.'/itemize.tex<cr>kdd'
exe 'inoremap myenumerate <esc>:r '.s:template_dir.'/enumerate.tex<cr>kdd'
