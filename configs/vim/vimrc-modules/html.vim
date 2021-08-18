" sanitization
let s:char_html_escape={
	\'&': '&amp;',
	\">": "&gt;",
	\'<': '&lt;',
	\'1': '&nbsp;',
	\'2': '&ensp;',
	\'4': '&emsp;'
\}
function EscapeHTML()
  let l:curChar = strcharpart(getline('.')[col('.') - 1:], 0, 1)
  if has_key(s:char_html_escape, l:curChar)
    exe 'normal s'.s:char_html_escape[l:curChar]
  endif
endfunction
nnoremap <leader>e :call EscapeHTML()<cr>"
