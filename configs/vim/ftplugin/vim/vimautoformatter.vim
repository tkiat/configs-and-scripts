autocmd BufWritePre *.vim call vimautoformatter#Apply()

function! vimautoformatter#Apply()
  let b:winview = winsaveview()
  :normal gg=G
  call winrestview(b:winview)
endfunction
