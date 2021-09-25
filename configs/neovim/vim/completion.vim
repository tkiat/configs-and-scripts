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
