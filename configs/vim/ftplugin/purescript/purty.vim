" Plugin for purty
" Last Change: 2021 Jul 28
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License
" Source: https://gitlab.com/joneshf/purty
" ==============================================================================
" Config
" ==============================================================================
let s:command = "purty"
let s:arguments = "
      \"
" ==============================================================================
" Script
" ==============================================================================
if exists("g:purescript_purty_skip") && g:purescript_purty_skip == 1
  finish
endif
let g:purescript_purty_skip = 1

augroup purty
  autocmd!
  autocmd BufWritePre *.purs call purty#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! PurtyContinue exe "call purty#PurtyContinue()"
command! PurtyPause    exe "call purty#PurtyPause()"

function! purty#PurtyContinue()
  let g:purescript_purty_pause = 0
endfunction

function! purty#PurtyPause()
  let g:purescript_purty_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! purty#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! purty#ShouldApply()
  if exists("g:purescript_purty_pause") && g:purescript_purty_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "purty.vim: " . s:command . " not found in $PATH"
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "purty.vim: " . s:command . s:arguments . " is not valid"
    return 0
  endif

  return 1
endfunction

function! purty#TryToApply()
  if purty#ShouldApply()
    let b:winview = winsaveview()
    exe "%call purty#Apply()"
  endif
endfunction
