" sanitization
let s:escape_pair={
      \'&': '&amp;',
      \">": "&gt;",
      \'<': '&lt;',
      \'1': '&nbsp;',
      \'2': '&ensp;',
      \'4': '&emsp;'
      \}
for [key, val] in items(s:escape_pair)
  exe 'inoremap '.key.'esc '.val
endfor
