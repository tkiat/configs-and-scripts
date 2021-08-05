" Source: https://github.com/tkiat/vim-custom-theme
" ========================================
"                                  General
" ========================================
let g:colors_name = "custom"

set t_Co=256
set background=dark

highlight clear
" ========================================
"                                Highlight
" ========================================
" grp1 fg
hi Directory        ctermfg=214 ctermbg=NONE cterm=NONE guifg=#ffaf00 guibg=NONE gui=NONE
hi Constant         ctermfg=214 ctermbg=NONE cterm=NONE guifg=#ffaf00 guibg=NONE gui=NONE
" grp2
hi Statement        ctermfg=149 ctermbg=NONE cterm=NONE guifg=#afd75f guibg=NONE gui=NONE
" grp3
hi Nontext          ctermfg=67 ctermbg=NONE cterm=NONE guifg=#5f87af guibg=NONE gui=NONE
hi Specialkey       ctermfg=67 ctermbg=NONE cterm=NONE guifg=#5f87af guibg=NONE gui=NONE
" grp4
hi Comment          ctermfg=245 ctermbg=NONE cterm=NONE guifg=#8a8a8a guibg=NONE gui=NONE
hi LineNr           ctermfg=245 ctermbg=NONE cterm=NONE guifg=#8a8a8a guibg=NONE gui=NONE
" grp5
hi Type             ctermfg=123 ctermbg=NONE cterm=NONE guifg=#87ffff guibg=NONE gui=NONE
" grp6
hi Special          ctermfg=205 ctermbg=NONE cterm=NONE guifg=#ff5faf guibg=NONE gui=NONE
" grp7
hi Identifier       ctermfg=75 ctermbg=NONE cterm=NONE guifg=#5fafff guibg=NONE gui=NONE
hi Preproc          ctermfg=75 ctermbg=NONE cterm=NONE guifg=#5fafff guibg=NONE gui=NONE
" grp8
hi Normal           ctermfg=15 ctermbg=233 cterm=NONE guifg=#ffffff guibg=#121212 gui=NONE
hi ModeMsg          ctermfg=15 ctermbg=233 cterm=NONE guifg=#ffffff guibg=#121212 gui=NONE
hi Question         ctermfg=15 ctermbg=233 cterm=NONE guifg=#ffffff guibg=#121212 gui=NONE
hi TabLineFill      ctermfg=15 ctermbg=233 cterm=NONE guifg=#ffffff guibg=#121212 gui=NONE
hi Title            ctermfg=15 ctermbg=233 cterm=NONE guifg=#ffffff guibg=#121212 gui=NONE
" grp9
hi Folded           ctermfg=245 ctermbg=236 cterm=NONE guifg=#8a8a8a guibg=#303030 gui=NONE
hi FoldColumn       ctermfg=245 ctermbg=236 cterm=NONE guifg=#8a8a8a guibg=#303030 gui=NONE

hi CursorLine       ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#303030 gui=NONE
hi CursorLineNr     ctermfg=236 ctermbg=245 cterm=NONE guifg=#303030 guibg=#8a8a8a gui=NONE
" grp10
hi Pmenu            ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi PmenuSbar        ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi StatusLine       ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi StatusLineTerm   ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi TablineSel       ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
hi Visual           ctermfg=0 ctermbg=252 cterm=NONE guifg=#000000 guibg=#d0d0d0 gui=NONE
" grp11
hi PmenuThumb       ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi PmenuSel         ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi StatusLineNC     ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi StatusLineTermNC ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
hi Tabline          ctermfg=0 ctermbg=245 cterm=NONE guifg=#000000 guibg=#8a8a8a gui=NONE
" grp12
hi Error            ctermfg=15 ctermbg=9 cterm=NONE guifg=#ffffff guibg=#ff0000 gui=NONE
hi ErrorMsg         ctermfg=15 ctermbg=9 cterm=NONE guifg=#ffffff guibg=#ff0000 gui=NONE
hi DiffDelete       ctermfg=15 ctermbg=9 cterm=NONE guifg=#ffffff guibg=#ff0000 gui=NONE
" grp13
hi Search           ctermfg=0 ctermbg=214 cterm=NONE guifg=#000000 guibg=#ffaf00 gui=NONE
hi DiffAdd          ctermfg=0 ctermbg=214 cterm=NONE guifg=#000000 guibg=#ffaf00 gui=NONE
hi DiffChange       ctermfg=0 ctermbg=214 cterm=NONE guifg=#000000 guibg=#ffaf00 gui=NONE

hi IncSearch        ctermfg=214 ctermbg=0 cterm=NONE guifg=#ffaf00 guibg=#000000 gui=NONE
hi MatchPare        ctermfg=214 ctermbg=0 cterm=NONE guifg=#ffaf00 guibg=#000000 gui=NONE
