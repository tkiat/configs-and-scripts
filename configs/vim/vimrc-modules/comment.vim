" comments at front -----------------------------------------------------------
let s:groups=[
      \{
      \'front': '# ',
      \'back': '',
      \'ext': '*.bash,*.bashrc\(\.shared\)\=,*.dash,*.gitignore,*.nix,*.py,*.rec,*.sh,*.tf,*.tmux.conf,.xinitrc,*.yml,*.zprofile,*.zshenv,*.zshrc\(\.shared\)\=',
      \'comment':    ':s/^\%V/# /g<cr>',
      \'uncomment':  ':s/^\%V# //g<cr>',
      \},
      \{
      \'front': '\/\/ ',
      \'back': '',
      \'ext': '*.adoc,*.c,*.dot,*.go,*.h,*.js,*.jsx,*.ts,*.tsx,*.cpp',
      \'comment':    ':s/^\%V/\/\/ /g<cr>',
      \'uncomment':  ':s/^\%V\/\/ //g<cr>',
      \},
      \{
      \'front': '-- ',
      \'back': '',
      \'ext': '*.cabal,*.dhall,*.hs,*.purs,*.xmobarrc',
      \'comment':    ':s/^\%V/-- /g<cr>',
      \'uncomment':  ':s/^\%V-- //g<cr>',
      \},
      \{
      \'front': '" ',
      \'back': '',
      \'ext': '*.vim,*.vimrc',
      \'comment':    ':s/^\%V/" /g<cr>',
      \'uncomment':  ':s/^\%V" //g<cr>',
      \},
      \{
      \'front': ';;; ',
      \'back': '',
      \'ext': '*.scm',
      \'comment':    ':s/^\%V/;;; /g<cr>',
      \'uncomment':  ':s/^\%V;;; //g<cr>',
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
    let s:comment = 'mq:s/\%V\(.*\)\%V/'.
          \ s:groups[i]['front'].'\1'.s:groups[i]['back'].'/g<cr>:nohls<cr>`q'
    let s:uncomment = 'mq:s/\%V'.
          \ s:groups[i]['front'].'\(.*\)'.s:groups[i]['back'].'\%V/\1/g<cr>`q'

    exe s:event.' nnoremap <buffer> <leader>c '.'V'.s:comment
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
