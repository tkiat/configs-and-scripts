" Author: Theerawat Kiatdarakun
" TODO combine mapping sections

" test: https://stackoverflow.com/questions/37644682/why-is-vim-so-slow
" set timeoutlen=1000
" set ttimeoutlen=0

let nvim_dir='~/.config/nvim'
let temp_dir=nvim_dir.'/temp'

let space_per_tab=2
" TODO use vim tag sections here also check mapping first perhaps can remove leader
" TODO colsure on how to display 80 clumns
" ========================================
" Set
" ========================================
set nomodeline
set guicursor= " prevent nvim from overriding cursor style
let @/ = "" " clear last search pattern
set autoindent " auto indent next line
set backspace=indent,eol,start " make backspace to work
set completeopt-=preview " disable scratch preview
set cursorline " highlight current line
" directories
exec "set backupdir=".temp_dir."/backup//"
exec "set directory=".temp_dir."/swap//"
exec "set undodir=".temp_dir."/undo//"

set expandtab " auto-indent with spaces instead of tabs
set foldmethod=indent
set incsearch " highlight while still typing search
set list " enable listchars
set listchars=eol:$,tab:\|-,trail:_
set nofixendofline
set nofoldenable " disable auto-folding at start
set nohls
set number " show line number
set shellcmdflag=-ic
" netrw
let g:netrw_browse_split = 3 " open file in new tab
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro nornu' " enable line number
let g:netrw_liststyle = 3 " tree listing style"

set pumheight=10 " Pmenu max height
exe 'set shiftwidth='.space_per_tab
exe 'set tabstop='.space_per_tab
" syntax highlighting
" syntax reset
" syntax on

" ========================================
" automatic command
" ========================================
" markdown - remove highlight on error
autocmd BufNewFile,BufRead,BufEnter *.md :syn match markdownError "\w\@<=\w\@="
" tab - move new tab to the last position
" autocmd BufNew * execute ":tabm"
" ========================================
" mapping automatically
" ========================================
" placeholder
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dapibus convallis massa, nec gravida diam pellentesque at. Aliquam mollis tempor mi sed venenatis. Maecenas neque massa, pulvinar vitae lacus et, convallis interdum ligula. Suspendisse rhoncus a arcu quis volutpat. Donec ac risus eros. Pellentesque convallis lectus eu sodales ornare. Quisque egestas ex non purus porta porttitor. Ut blandit feugiat iaculis. Nulla mollis venenatis pulvinar. Nullam pulvinar efficitur aliquet. Donec in nibh eleifend, finibus dui nec, faucibus dui.
" help - start in a new tab
cnoremap help tab help<space>
" cnoremap h<space> tab help<space>
" shebang
inoreabbrev shebang #!/usr/bin/env
" inoremap @esc &#64;
" ========================================
" mapping manually with <leader>
" ========================================
" go to tab
for val in range(0,8)
  exe 'nnoremap <leader>'.val.' '.val.'gt<cr>'
endfor
nnoremap <leader>9 :tabl<cr>
nnoremap <leader>; mqA;<esc>`q
" /: search current word
nnoremap <leader>/ viw"qy/<c-r>q<cr>N
vnoremap <leader>/ y/<c-r>"<cr>
" space: surround a word with spaces
nnoremap <leader><space> mqbi<space><esc>ea<space><esc>`ql
" b: buffer
nnoremap <leader>b :bnext<cr>
" c: copy - current file
" nnoremap <leader>cf :!cat % \| xclip -selection clipboard<cr><cr>
" d: definition highlight group
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" d: delete - braces pair
nnoremap <leader>d %x``x
" d: delete - first letter
nnoremap <leader>d^ mqI<del><esc>`qh
" d: delete - last character in line
nnoremap <leader>da mq$x<esc>`q
" d: delete - trailing character(s)
for char in [';','$']
  exe 'nnoremap <leader>d'.char.' mq:%s/'.char.'$//g<cr>`q'
endfor
nnoremap <leader>d<Space> mq:%s/\s\+$//<cr>`q
" f: file - print current
nnoremap <leader>f :execute "normal! a" . expand('%:t:r')<CR>
" h: highlight - toggle
nnoremap <expr> <leader>hl (&hls && v:hlsearch ? ':set nohls' : ':set hls')."\n"
" o: open file
" nnoremap <leader>oh  :tabnew ~<cr>
" nnoremap <leader>ov  :vsplit ~/.vimrc<cr>
exe 'nnoremap <leader>ov  :tabnew '.nvim_dir.'<cr>'
" nnoremap <leader>ovm :tabnew ~/.vimrc-modules<cr>
" p: paste from clipboard to end of file
nnoremap <leader>pc :w<cr>:!echo $(xclip -o selection clipboard) >> %<cr>L<cr>
" TODO vnoreamp '<,'>s/\%Vfoo\%V/bar/g
" r: replace - 2 tabs with 1 tab
vnoremap <leader><tab><tab> :s/\%V\t\t/\t/g<cr>:nohl<cr>
" r: replace - all words in file
nnoremap <leader>R viw"qy:%s/<C-r>q/<C-r>q/gc<left><left><left>
vnoremap <leader>R y:%s/<c-r>"/<c-r>"/g<left><left>
" r: replace - all words in line
nnoremap <leader>r viw"qy:s/<C-r>q/<C-r>q/g<left><left>
vnoremap <leader>r y:s/<c-r>"/<c-r>"/g<left><left>
" r: replace - hyphen and underscore with space
nnoremap <leader>r<space> mq:s/[-_]\+/ /g<cr>`q
" r: replace - capitalize first letter of each word
  " \< matches the start of a word
  " . matches the first character of a word
  " \u tells Vim to uppercase the following character
  " & means substitute whatever was matched on the LHS"
nnoremap <leader>rU mq:s/\<./\u&/g<cr>`q
" r: replace - spaces at front with tab(s)
exe 'nnoremap <leader>r<tab> mq:%s/\(^ *\)\@<= \{'.space_per_tab.'\}/<tab>/g<cr>`q'
" m: move - tab
for val in range(0,9)
  exe 'nnoremap <leader>m'.val.' :tabm'.val.'<CR>'
endfor
" q: quit
nnoremap <leader>q :q<cr>
" s: save file
nnoremap <leader>s :update<cr>
vnoremap <leader>s <c-c>:update<cr>
" s: set - colorcolumn
function! ColHighlight()
  let x = 0
  function! Bar() closure
    let x = 1 - x
    if x !=# 0
      exe ':set colorcolumn='.col('.')
    else
      :set colorcolumn=
    endif
    return x
  endfunction
  return funcref('Bar')
endfunction
let ColHighlightInstance = ColHighlight()
nnoremap <leader>sc :call ColHighlightInstance()<cr>
nnoremap <leader>scc :set colorcolumn=
nnoremap <leader>s8 :set colorcolumn=80<cr>
" s: source file
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
" t: tab new
nnoremap <leader>t :tabedit<cr>
" w: window
nnoremap <leader>wh :split<cr>
nnoremap <leader>wv :vsplit<cr>
" y: yank: whole html tag
" nnoremap <leader>y< vf>f>y
" nnoremap <leader>y> vf>f>y
