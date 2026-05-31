map <LEADER> ""
set backspace=indent,eol,start
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
set ambiwidth=double
let &t_ut=''
set expandtab
set shiftwidth=2
set softtabstop=2
set foldmethod=indent
set foldlevel=99
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let mapleader=" "
set hlsearch
set number
set wrap
set incsearch
set cursorline
set wildmenu
set showcmd
syntax on
exec "nohlsearch"
set ignorecase
set smartcase
noremap J 5j
noremap K 5k
noremap H 5h
noremap L 5l
noremap Caps_Lock Escape
noremap Escape Caps_Lock
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitright<CR>:split<CR>


map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

map tn :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>





map <UP> :res -5<CR>
map <DOWN> :res +5<CR>
map <LEFT> :vertical resize+5<CR>
map <RIGHT> :vertical resize-5<CR>

" ========= NERDTree
map tt :NERDTreeToggle<CR>

" ========= markdown-preview
map r :MarkdownPreview<CR>
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = 'chromium'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'


" ========= markdown_preview

" ===================beancount设置====================
let g:beancount_account_completion = 'chunks'
let g:beancount_detailed_first = 1
let g:beancount_separator_col = 60
let b:beancount_root = '~/Documents/Finance/main.bean'
map m :make<CR>
" 小数点自动对齐
"inoremap <C-\><C-O>:AlignCommodity<CR>
inoremap . .<C-\><C-O>:AlignCommodity<CR>
inoremap : :<C-x><C-o>
nnoremap <buffer> <leader>= : AlignCommodity<CR>
vnoremap <buffer> <leader>= : AlignCommodity<CR>
" ===================beancount设置====================
" ===================vim-unimpaired设置====================
" 配置 vim-unimpaired
let g:unimpaired_clipboard = 1
" ===================vim-unimpaired设置====================

noremap <LEADER><CR> :nohlsearch<CR>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-peekaboo'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() },'for' :['markdown', 'vim-plug'] } 
Plug 'preservim/vim-markdown'
Plug 'connorholyday/vim-snazzy'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'karoliskoncevicius/sacredforest-vim'
Plug 'nathangrigg/vim-beancount' 
Plug 'yianwillis/vimcdoc'
Plug 'tpope/vim-unimpaired'
" 使用回车键选中包裹的代代码 
Plug 'gcmt/wildfire.vim'
" 使用S xxx 来替换代码，如果不同，左边会加空格，右边不会,cs字符字符2，将字符1替换为字符2
Plug 'tpope/vim-surround'
call plug#end()
let g:SnazzyTransparent = 1
color snazzy

"导入另一个文件
source ~/.config/nvim/snippits.vim

let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0




