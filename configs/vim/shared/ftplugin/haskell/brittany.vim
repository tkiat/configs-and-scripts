" Plugin for brittany
" Last Change: 2021 Jul 21
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License.
" Source: https://hackage.haskell.org/package/brittany
" ==============================================================================
" Config
" ==============================================================================
let s:command = "brittany"
let s:arguments = "
      \ --columns 80
      \ --indent 2
      \"
" ==============================================================================
" Script
" ==============================================================================
if exists("g:haskell_brittany_skip") && g:haskell_brittany_skip == 1
  finish
endif
let g:haskell_brittany_skip = 1

augroup brittany
  autocmd!
  autocmd BufWritePre *.hs call brittany#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! BrittanyContinue exe "call brittany#BrittanyContinue()"
command! BrittanyPause    exe "call brittany#BrittanyPause()"

function! brittany#BrittanyContinue()
  let g:haskell_brittany_pause = 0
endfunction

function! brittany#BrittanyPause()
  let g:haskell_brittany_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! brittany#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! brittany#ShouldApply()
  if exists("g:haskell_brittany_pause") && g:haskell_brittany_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "brittany.vim: " . s:command . " not found in $PATH"
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "brittany.vim: " . s:command . s:arguments . " is not valid"
    return 0
  endif

  return 1
endfunction

function! brittany#TryToApply()
  if brittany#ShouldApply()
    let b:winview = winsaveview()
    exe "%call brittany#Apply()"
  endif
endfunction
