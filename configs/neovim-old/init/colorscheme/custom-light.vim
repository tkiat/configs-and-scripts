" Source: https://github.com/tkiat/vim-custom-theme
" ========================================
"                                  General
" ========================================
let g:colors_name = "custom"

set t_Co=256
set background=light

highlight clear
" ========================================
"                                Highlight
" ========================================
" grp1 fg
hi Directory        ctermfg=94 ctermbg=NONE cterm=NONE guifg=#875f00 guibg=NONE gui=NONE
hi Constant         ctermfg=94 ctermbg=NONE cterm=NONE guifg=#875f00 guibg=NONE gui=NONE
" grp2
hi Statement        ctermfg=124 ctermbg=NONE cterm=NONE guifg=#af0000 guibg=NONE gui=NONE
" grp3
hi Nontext          ctermfg=133 ctermbg=NONE cterm=NONE guifg=#af5faf guibg=NONE gui=NONE
hi Specialkey       ctermfg=133 ctermbg=NONE cterm=NONE guifg=#af5faf guibg=NONE gui=NONE
" grp4
hi Comment          ctermfg=240 ctermbg=NONE cterm=NONE guifg=#585858 guibg=NONE gui=NONE
hi LineNr           ctermfg=240 ctermbg=NONE cterm=NONE guifg=#585858 guibg=NONE gui=NONE
" grp5
hi Type             ctermfg=28 ctermbg=NONE cterm=NONE guifg=#008700 guibg=NONE gui=NONE
" grp6
hi Special          ctermfg=128 ctermbg=NONE cterm=NONE guifg=#af00d7 guibg=NONE gui=NONE
" grp7
hi Identifier       ctermfg=12 ctermbg=NONE cterm=NONE guifg=#0000ff guibg=NONE gui=NONE
hi Preproc          ctermfg=12 ctermbg=NONE cterm=NONE guifg=#0000ff guibg=NONE gui=NONE
" grp8
hi Normal           ctermfg=237 ctermbg=230 cterm=NONE guifg=#3a3a3a guibg=#ffffd7 gui=NONE
hi ModeMsg          ctermfg=237 ctermbg=230 cterm=NONE guifg=#3a3a3a guibg=#ffffd7 gui=NONE
hi Question         ctermfg=237 ctermbg=230 cterm=NONE guifg=#3a3a3a guibg=#ffffd7 gui=NONE
hi TabLineFill      ctermfg=237 ctermbg=230 cterm=NONE guifg=#3a3a3a guibg=#ffffd7 gui=NONE
hi Title            ctermfg=237 ctermbg=230 cterm=NONE guifg=#3a3a3a guibg=#ffffd7 gui=NONE
" grp9
hi Folded           ctermfg=233 ctermbg=255 cterm=NONE guifg=#121212 guibg=#eeeeee gui=NONE
hi FoldColumn       ctermfg=233 ctermbg=255 cterm=NONE guifg=#121212 guibg=#eeeeee gui=NONE

hi CursorLine       ctermfg=NONE ctermbg=255 cterm=NONE guifg=NONE guibg=#eeeeee gui=NONE
hi CursorLineNr     ctermfg=255 ctermbg=233 cterm=NONE guifg=#eeeeee guibg=#121212 gui=NONE
" grp10
hi Pmenu            ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi PmenuSbar        ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi StatusLine       ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi StatusLineTerm   ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi TablineSel       ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi Visual           ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
" grp11
hi PmenuThumb       ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi PmenuSel         ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi StatusLineNC     ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi StatusLineTermNC ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi Tabline          ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
" grp12
hi Error            ctermfg=253 ctermbg=160 cterm=NONE guifg=#dadada guibg=#d70000 gui=NONE
hi ErrorMsg         ctermfg=253 ctermbg=160 cterm=NONE guifg=#dadada guibg=#d70000 gui=NONE
hi DiffDelete       ctermfg=253 ctermbg=160 cterm=NONE guifg=#dadada guibg=#d70000 gui=NONE
" grp13
hi Search           ctermfg=234 ctermbg=87 cterm=NONE guifg=#1c1c1c guibg=#5fffff gui=NONE
hi DiffAdd          ctermfg=234 ctermbg=87 cterm=NONE guifg=#1c1c1c guibg=#5fffff gui=NONE
hi DiffChange       ctermfg=234 ctermbg=87 cterm=NONE guifg=#1c1c1c guibg=#5fffff gui=NONE

hi IncSearch        ctermfg=87 ctermbg=234 cterm=NONE guifg=#5fffff guibg=#1c1c1c gui=NONE
hi MatchPare        ctermfg=87 ctermbg=234 cterm=NONE guifg=#5fffff guibg=#1c1c1c gui=NONE
