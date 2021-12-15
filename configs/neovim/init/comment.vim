" comments at front -----------------------------------------------------------
let s:groups=[
      \{
      \'front': '# ',
      \'back': '',
      \'ext': '*.alias,*.bash,*.bashrc\(\.shared\)\=,*.cfg,*.dash,*.gitignore,*.nix,*.py,*.rec,*.sh,*.tf,*.tmux.conf,.xinitrc,*.y\(\a\)\=ml,*.zprofile,*.zshenv,*.zshrc\(\.shared\)\=',
      \},
      \{
      \'front': '\/\/ ',
      \'back': '',
      \'ext': '*.adoc,*.c,*.dot,*.go,*.h,*.js,*.jsx,*.ts,*.tsx,*.cpp',
      \},
      \{
      \'front': '-- ',
      \'back': '',
      \'ext': '*.cabal,*.dhall,*.hs,*.lua,*.purs,*.xmobarrc',
      \},
      \{
      \'front': '" ',
      \'back': '',
      \'ext': '*.vim,*.vimrc',
      \},
      \{
      \'front': '% ',
      \'back': '',
      \'ext': '*.tex',
      \},
      \{
      \'front': ';;; ',
      \'back': '',
      \'ext': '*.scm',
      \},
      \{
      \'front': '\/\* ',
      \'back': ' \*\/',
      \'ext': '*.css,*.scss',
      \},
      \{
      \'front': '<!-- ',
      \'back': ' -->',
      \'ext': '*.html,*.md',
      \},
      \]
augroup CommentGroups
  for i in range(0,len(s:groups)-1)
    let s:event = ':autocmd BufNewFile,BufRead '.s:groups[i]['ext']
    let s:comment = 'mq:s/\%V\(\s*\)\(.*\)\%V/'.
          \ '\1'.s:groups[i]['front'].'\2'.s:groups[i]['back'].'/g<cr>:nohls<cr>`q'
    let s:uncomment = 'mq:s/\%V'.
          \ s:groups[i]['front'].'\(.*\)'.s:groups[i]['back'].'\%V/\1/g<cr>`q'
    exe s:event.' nnoremap <buffer> <leader>c '.s:comment
    exe s:event.' nnoremap <buffer> <leader>u '.'V'.s:uncomment
    exe s:event.' vnoremap <buffer> <leader>c '.s:comment
    exe s:event.' vnoremap <buffer> <leader>u '.s:uncomment
  endfor
augroup END
" ad-hoc ----------------------------------------------------------------------
" " comment
" nnoremap <leader>cc ^i/*<esc>A*/<esc>
" nnoremap <leader>c/ ^i//<esc>A<esc>
" nnoremap <leader>c{ ^i{/*<esc>A*/}<esc>
" " uncomment
" nnoremap <leader>uc ^xx<esc>$xx<esc>
" nnoremap <leader>u/ ^xx<esc>$<esc>
" nnoremap <leader>u{ ^xxx<esc>$xxx<esc>
