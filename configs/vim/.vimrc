source ~/.vimrc-modules/const
source ~/.vimrc-modules/shared
" source ~/.vimrc.specific/browser-nerdtree.vim
" source ~/.vimrc.specific/formatter-haskell-hindent.vim
au VimEnter * if &diff | execute 'windo set wrap' | endif " force line wrap in vim diff
" =============================================================================
"                                  Plugins
" =============================================================================
" augroup Autoformat
"     autocmd!
"     " Use one of the following (The 1st variant is cleaner IMO)
"     autocmd FileType css let &l:equalprg = 'prettier --parser css --stdin --tab-width 2'
"     autocmd FileType css setlocal equalprg=prettier\ --parser\ css\ --stdin\ --tab-width\ 2
" augroup END"
" ftplugin ====================================================================
filetype plugin on
filetype plugin indent on
let g:cabal_cabal_fmt_skip = 0
let g:haskell_brittany_skip = 0
let g:haskell_hindent_skip = 1
let g:purescript_purty_skip = 1
" nerdtree ====================================================================
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" coc.vim =====================================================================
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" vim-go ======================================================================
" nnoremap <leader>gi :GoImport <C-R><C-W><cr>
" vim-terraform ===============================================================
" let g:terraform_fmt_on_save=1
