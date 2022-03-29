let s:template_dir=expand('<sfile>:p:h').'/template'

exe 'nnoremap <leader>tc <esc>:r '.s:template_dir.'/template.c<cr>kdd'
exe 'nnoremap <leader>th <esc>:r '.s:template_dir.'/template.html<cr>kdd'
exe 'nnoremap <leader>tm <esc>:r '.s:template_dir.'/template.md<cr>kdd'

" general
" - symbol
inoremap endash –
inoremap emdash —
inoremap myquote “”<esc>i
" haskell
inoremap hsext {-# LANGUAGE  #-}<esc>F<space>i
" latex
exe 'inoremap lenumerate <esc>:r '.s:template_dir.'/enumerate.tex<cr>kdd'
exe 'inoremap litemize <esc>:r '.s:template_dir.'/itemize.tex<cr>kdd'
exe 'inoremap lquote <esc>:r '.s:template_dir.'/quote.tex<cr>kdd'
inoremap l-> $\rightarrow$
inoremap l<- $\leftarrow$
inoremap lemph \emph{}<esc>i
inoremap ltextbf \textbf{}<esc>i

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
for val in ['{}','()','[]','""',"''",'**','<>','``','__','$$']
  exe 'nnoremap <leader>'.val[0].' mqciw'.val[0].val[1].'<esc>P`ql'
  exe 'vnoremap <leader>'.val[0].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
  if val[0] !=# val[1]
    exe 'nnoremap <leader>'.val[1].' ciw'.val[0].val[1].'<esc>Pl'
    exe 'vnoremap <leader>'.val[1].' mq:s/\%V.*\%V./'.val[0].'&'.val[1].'/<cr>`qf'.val[1].':nohl<cr>'
  endif
endfor
nnoremap <leader>"" mqciw“”<esc>P`ql
vnoremap <leader>"" mq:s/\%V.*\%V./“&”/<cr>`qf”:nohl<cr>

" ** enclose word
nnoremap <leader>** ciw****<esc>hPl
vnoremap <leader>** mq:s/\%V.*\%V./**&**/<cr>`qf'**':nohl<cr>
