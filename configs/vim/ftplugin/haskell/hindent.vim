" Plugin for hindent
" Last Change: 2021 Jul 21
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License.
" Source: https://hackage.haskell.org/package/hindent
" ==============================================================================
" Config
" ==============================================================================
let s:command = "hindent"
let s:arguments = "
      \ --indent-size 2
      \ --line-length 80
      \"
" ==============================================================================
" Script
" ==============================================================================
if exists("g:haskell_hindent_skip") && g:haskell_hindent_skip == 1
  finish
endif
let g:haskell_hindent_skip = 1

augroup hindent
  autocmd!
  autocmd BufWritePre *.hs call hindent#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! HindentContinue exe "call hindent#HindentContinue()"
command! HindentPause    exe "call hindent#HindentPause()"

function! hindent#HindentContinue()
  let g:haskell_hindent_pause = 0
endfunction

function! hindent#HindentPause()
  let g:haskell_hindent_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! hindent#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! hindent#ShouldApply()
  if exists("g:haskell_hindent_pause") && g:haskell_hindent_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "hindent.vim: " . s:command . " not found in $PATH"
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "hindent.vim: " . s:command . s:arguments . " is not valid"
    return 0
  endif

  return 1
endfunction

function! hindent#TryToApply()
  if hindent#ShouldApply()
    let b:winview = winsaveview()
    exe "%call hindent#Apply()"
  endif
endfunction
