" Vim global plugin for correcting typing mistakes
" Last Change: 2000 Oct 15
" Maintainer: Bram Moolenaar <Bram@vim.org>
" License: This file is placed in the public domain.

if exists("g:loaded_typecorr") " prevent loading this plugin and prevent loading it twice
  finish
endif
let g:loaded_typecorr = 1

" user with 'compatible' set will have trouble with line-continuation at line 18 so we temporarily unset it locally (line 11-12). A & in front of cpo refers to vim internal option, not a variable
let s:save_cpo = &cpo
" set cpo (compatible-options) to its Vim default value, see :help :set-&vim
set cpo&vim

iabbrev teh the
iabbrev otehr other
iabbrev wnat want
iabbrev synchronisation
  \ synchronization
let s:count = 4

" <Plug> is available outside of script. Use it to allow the user to define his own key sequence like map ,c  <Plug>TypecorrAdd;. Recommended to use syntax: <Plug> + script name + function name + terminator(;)
if !hasmapto('<Plug>TypecorrAdd;')
  map <unique> <Leader>a  <Plug>TypecorrAdd;
endif

"Use <SID> to let Vim know which script to look for the Add function because Vim don't really know the Add definition from outside. Use noremap <script> at front because we want only the local mappings in the script
noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add

noremenu <script> Plugin.Add\ Correction      <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>

function s:Add(from, correct)
  let to = input("type the correction for " .. a:from .. ": ")
  exe ":iabbrev " .. a:from .. " " .. to
  if a:correct | exe "normal viws\<C-R>\" \b\e" | endif " apply new correction under the cursor
  echo s:count .. " corrections now"
endfunction

if !exists(":Correct")
  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
