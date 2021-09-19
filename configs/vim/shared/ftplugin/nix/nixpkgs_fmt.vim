" Plugin for nixpkgs-fmt
" Last Change: 2021 Jul 28
" Maintainer: Theerawat Kiatdarakun <tkiat@tutanota.com>
" License: Vim License
" Source: TODO
" ==============================================================================
" Config
" ==============================================================================
let s:command = "nixpkgs-fmt"
let s:arguments = "
      \"
" ==============================================================================
" Script
" ==============================================================================
if exists("g:nixpkgs_fmt_skip") && g:nixpkgs_fmt_skip == 1
  finish
endif
let g:nixpkgs_fmt_skip = 1

augroup nixpkgs_fmt
  autocmd!
  autocmd BufWritePre *.nix call nixpkgs_fmt#TryToApply()
augroup END
" ==============================================================================
" Command
" ==============================================================================
command! AutoFormatterNixpkgsFmtContinue exe "call nixpkgs_fmt#Continue()"
command! AutoFormatterNixpkgsFmtPause    exe "call nixpkgs_fmt#Pause()"

function! nixpkgs_fmt#Continue()
  let s:nixpkgs_fmt_pause = 0
endfunction

function! nixpkgs_fmt#Pause()
  let s:nixpkgs_fmt_pause = 1
endfunction
" ==============================================================================
" Function
" ==============================================================================
function! nixpkgs_fmt#Apply() range
  silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . s:command . " " . s:arguments
  call winrestview(b:winview)
endfunction

function! nixpkgs_fmt#ShouldApply()
  if exists("s:nixpkgs_fmt_pause") && s:nixpkgs_fmt_pause == 1
    return 0
  endif

  if !executable(s:command)
    echoerr "nixpkgs-fmt.vim: " . s:command . " not found in $PATH"
    return 0
  endif

  silent! exe "w !" . s:command . s:arguments . " > /dev/null 2>&1"
  if v:shell_error
    echoerr "nixpkgs-fmt.vim: " . s:command . s:arguments . " is not valid"
    return 0
  endif

  return 1
endfunction

function! nixpkgs_fmt#TryToApply()
  if nixpkgs_fmt#ShouldApply()
    let b:winview = winsaveview()
    exe "%call nixpkgs_fmt#Apply()"
  endif
endfunction
