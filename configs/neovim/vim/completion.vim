" completion-nvim
  " Use in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
  " Use <Tab> and <S-Tab> to navigate through popup menu
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Avoid showing message extra message when using completion

" autogenerate closing braces
for val in ['{}','()','[]']
  exe 'inoremap '.val[0].' '.val[0].val[1].'<Esc>i'
  exe 'inoremap '.val[0].'<CR> '.val[0].'<CR>'.val[1].'<Esc>ko'
endfor

" {(["'*<`: enclose curent word with its pair
for val in ['{}','()','[]','""',"''",'**','<>','``','__']
  exe 'nnoremap <leader>'.val[0].' mqciw'.val[0].val[1].'<esc>P`ql'
  exe 'vnoremap <leader>'.val[0].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
  if val[0] !=# val[1]
    exe 'nnoremap <leader>'.val[1].' ciw'.val[0].val[1].'<esc>Pl'
    exe 'vnoremap <leader>'.val[1].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
  endif
endfor

" ** enclose word
nnoremap <leader>** ciw****<esc>hPl
vnoremap <leader>** mq:s/\%V.*\%V./**&**/<cr>`qf'**':nohl<cr>
