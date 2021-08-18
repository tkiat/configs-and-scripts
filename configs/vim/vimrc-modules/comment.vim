" commentgroup ----------------------------------------------------------------
let s:commentgroup=[
	\{
		\'comment-symbol': '#',
		\'ext': '*.bash,*.bashrc\(\.shared\)\=,*dash,*.gitignore,*.nix,*.py,*.rec,*.sh,*.tf,*.tmux.conf,.xinitrc,*.yml,*.zprofile,*.zshenv,*.zshrc\(\.shared\)\=',
		\'comment-line': 'mqV:s/^\%V/# /g<cr>:nohl<cr>`q',
		\'comment-visual': 'mq:s/^\%V/# /g<cr>:nohl<cr>`q',
		\'uncomment-line': 'mqV:s/^\%V# //g<cr>`q',
		\'uncomment-visual': 'mq:s/^\%V# //g<cr>`q'
	\},
	\{
		\'comment-symbol': '//',
		\'ext': '*.adoc,*.c,*.dot,*.go,*.h,*.js,*.jsx,*.ts,*.tsx,*.cpp',
		\'comment-line': 'mqI// <esc>`qll',
		\'comment-visual': ':s/^\%V/\/\/ /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V\/\/ //g<cr>'
	\},
	\{
		\'comment-symbol': '--',
		\'ext': '*.cabal,*.dhall,*.hs,*.purs,*.xmobarrc',
		\'comment-line': 'mqI-- <esc>`qll',
		\'comment-visual': ':s/^\%V/-- /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V-- //g<cr>'
	\},
	\{
		\'comment-symbol': '/* */',
		\'ext': '*.css,*.scss',
		\'comment-line': 'mqI/*<esc>A*/<esc>`qll',
		\'comment-visual': ':s/^/\/*/g<cr>gv:s/$/*\//g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><esc>A<bs><bs><esc>`qhh',
		\'uncomment-visual': ':s/\/\*//g<cr>gv:s/\*\///g<cr>:nohl<cr>'
	\},
	\{
		\'comment-symbol': '"',
		\'ext': '*.vim,*.vimrc',
		\'comment-line': 'mqI" <esc>`qll',
		\'comment-visual': ':s/^\%V/" /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><esc>`qhh',
		\'uncomment-visual': ':s/^\%V" //g<cr>'
	\},
	\{
		\'comment-symbol': ';;;',
		\'ext': '*.scm',
		\'comment-line': 'mqI;;; <esc>`qllll',
		\'comment-visual': ':s/^\%V/;;; /g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><del><esc>`qhhhh',
		\'uncomment-visual': ':s/^\%V;;; //g<cr>'
	\},
	\{
		\'comment-symbol': '<!-- -->',
		\'ext': '*.html,*.md',
		\'comment-line': 'mqI<!--<esc>A--><esc>`qllll',
		\'comment-visual': ':s/^/<!--/g<cr>gv:s/$/-->/g<cr>:nohl<cr>',
		\'uncomment-line': 'mqI<del><del><del><del><esc>A<bs><bs><bs><esc>`qhhhh',
		\'uncomment-visual': ':s/<!--//g<cr>gv:s/-->//g<cr>:nohl<cr>'
	\}
\]
for i in range(0,len(s:commentgroup)-1)
  " comment
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' nnoremap <buffer> <leader>c '.s:commentgroup[i]['comment-line']
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' vnoremap <buffer> <leader>c '.s:commentgroup[i]['comment-visual']
  " uncomment
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' nnoremap <buffer> <leader>u '.s:commentgroup[i]['uncomment-line']
	exe ':autocmd BufNewFile,BufRead '.s:commentgroup[i]['ext'].' vnoremap <buffer> <leader>u '.s:commentgroup[i]['uncomment-visual']
endfor
" ad-hoc ----------------------------------------------------------------------
" comment
nnoremap <leader>cc ^i/*<esc>A*/<esc>
nnoremap <leader>c/ ^i//<esc>A<esc>
nnoremap <leader>c{ ^i{/*<esc>A*/}<esc>
" uncomment
nnoremap <leader>uc ^xx<esc>$xx<esc>
nnoremap <leader>u/ ^xx<esc>$<esc>
nnoremap <leader>u{ ^xxx<esc>$xxx<esc>
