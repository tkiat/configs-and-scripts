" Plugin for yapf
" Last Change: 2021 Jul 21
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License.
" Source: https://hackage.haskell.org/package/yapf
" ==============================================================================
" Config
" ==============================================================================
let s:command = "yapf"
let s:arguments = ""
" ==============================================================================
" Script
" ==============================================================================
if exists("g:yapf_skip") && g:yapf_skip == 1
  finish
endif
let g:yapf_skip = 1

augroup yapf
  autocmd!
  autocmd BufWritePre *.py call yapf#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! YapfContinue exe "call yapf#Continue()"
command! YapfPause    exe "call yapf#Pause()"

function! yapf#Continue()
  let g:yapf_pause = 0
endfunction

function! yapf#Pause()
  let g:yapf_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! yapf#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! yapf#ShouldApply()
  if exists("g:yapf_pause") && g:yapf_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "yapf.vim: " . s:command . " not found in $PATH"
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "yapf.vim: " . s:command . s:arguments . " is not valid"
    return 0
  endif

  return 1
endfunction

function! yapf#TryToApply()
  if yapf#ShouldApply()
    let b:winview = winsaveview()
    exe "%call yapf#Apply()"
  endif
endfunction
