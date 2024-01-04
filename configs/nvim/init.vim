" require("lsp")
"
let mapleader=','
autocmd BufNewFile,BufRead * set colorcolumn=80

let config_dir="~/configs-and-scripts/configs/nvim"

exec "source ".config_dir."/init/colorscheme.vim"
exec "source ".config_dir."/init/plugin.vim"
" exec 'source '.config_dir.'/init/autofmtgen.vim'
exec "source ".config_dir."/init/comment.vim"
exec "source ".config_dir."/init/html.vim"
exec "source ".config_dir."/init/shared.vim"
" exec 'source '.config_dir.'/init/completion.vim'
exec "source ".config_dir."/init/syntax.vim"
exec "source ".config_dir."/init/template.vim"
