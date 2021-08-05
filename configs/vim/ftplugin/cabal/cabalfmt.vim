" Plugin for cabal-fmt
" Last Change: 2021 Jul 28
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License
" Source: https://gitlab.com/joneshf/cabal-fmt
" ==============================================================================
" Config
" ==============================================================================
let s:command = "cabal-fmt"
let s:arguments = "
      \ --indent 2
      \"
" ==============================================================================
" Script
" ==============================================================================
if exists("g:cabal_cabal_fmt_skip") && g:cabal_cabal_fmt_skip == 1
  finish
endif
let g:cabal_cabal_fmt_skip = 1

augroup cabal-fmt
  autocmd!
  autocmd BufWritePre *.cabal call cabalfmt#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! CabalfmtContinue exe "call cabalfmt#Continue()"
command! CabalfmtPause    exe "call cabalfmt#Pause()"

function! cabalfmt#Continue()
  let g:cabal_cabal_fmt_pause = 0
endfunction

function! cabalfmt#Pause()
  let g:cabal_cabal_fmt_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! cabalfmt#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! cabalfmt#ShouldApply()
  if exists("g:cabal_cabal_fmt_pause") && g:cabal_cabal_fmt_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "[cabal-fmt.vim] command does not exist in $PATH: " . s:command
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "[cabal-fmt.vim] error when testing the command: " . s:command . s:arguments
    return 0
  endif

  return 1
endfunction

function! cabalfmt#TryToApply()
  if cabalfmt#ShouldApply()
    let b:winview = winsaveview()
    exe "%call cabalfmt#Apply()"
  endif
endfunction
