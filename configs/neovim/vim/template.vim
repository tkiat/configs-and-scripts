" file
exe 'nnoremap <leader>tc <ESC>:r '.template_dir.'/c.template<CR>kdd'
exe 'nnoremap <leader>ta <ESC>:r '.template_dir.'/asciidoctor.template<CR>kdd'
exe 'nnoremap <leader>tgm <ESC>:r '.template_dir.'/main.go.template<CR>kddjjjjjjA'
exe 'nnoremap <leader>tgt <ESC>:r '.template_dir.'/main_test.go.template<CR>kddjjjjjjeea'
exe 'nnoremap <leader>tm <ESC>:r '.template_dir.'/markdown.template<cr>kdd'
exe 'nnoremap <leader>th <ESC>:r '.template_dir.'/html5.template<CR>kdd/body<CR>:nohl<CR>o'
exe 'nnoremap <leader>tv <ESC>:r '.template_dir.'/vue.template<CR>kdd'

" text
inoremap hsext {-# LANGUAGE  #-}<esc>F<space>i
