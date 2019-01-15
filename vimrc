" My .vimrc
" Author: masatana <plaza.tumbling@gmail.com>

" Initialize{{{
" 
" UTF-8!!! (Other settings such as fileencoding is on the other place.
scriptencoding utf-8

" If installed vim is tiny or small, do not load the code below.
if 0 | endif

" Use <Leader> in global plugin.
"let g:mapleader=','
" Can't use <SPACE> in this expression.
let g:mapleader=' '

" Environment variables.
if !exists("$MYVIMRC" )
    let $MYVIMRC = expand('~/.vimrc')
endif

if !exists("$MYGVIMRC" )
    let $MYGVIMRC = expand('~/.gvimrc')
endif

" }}}

" Plug{{{
" 

call plug#begin('~/.vim/plugged')

"Plug 'scrooloose/syntastic'
"Plug 'w0rp/ale'
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elmcast/elm-vim'

call plug#end()

" }}}

" Encoding{{{
" 
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
" }}}

" Remappings{{{
" 

"map <C-n> :cn<CR>
"map <C-p> :cp<CR>

" Invalidate forced termination.
"noremap ZZ <Nop>
"noremap ZQ <Nop>
"command! -nargs=0 Q :q!
"command! -nargs=0 QQ :qa!

" Use <C-[> ;)
inoremap <C-c> <Nop>

"noremap <BS> <C-h>
"noremap! <BS> <C-h>

"nmap <silent> <C-c> :nohlsearch<CR>

"imap <C-CR> \\<CR>

"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz

"nnoremap j gj
"nnoremap k gk
"
"nnoremap P $p
"
" http://vim-users.jp/2011/04/hack214/
"vnoremap ( t(
"vnoremap ) t)
"onoremap ( t(
"onoremap ) t)
"
"" Emacs-like keybind in command-line mode
"cnoremap <C-f> <Right>
"cnoremap <C-b> <Left>
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-h> <Backspace>
"cnoremap <C-d> <Delete>
"
"map <C-g> :Gtags
"map <C-h> :Gtags -f %<CR>
"map <C-j> :GtagsCursor<CR>
"map <C-n> :cn<CR>
"map <C-p> :cp<CR>
" }}}

" General Settings{{{
" 

" Enable olor changing when reloading .vimrc.
" For GVim.

syntax enable                           " Enable syntax.
set ambiwidth=double                    " Tell Vim what to do with characters with multibite font.
set autoindent smartindent              " Enable smart indent.
set backspace=indent,eol,start          " Allow backspacing over sutoindent, line breaks, start of insert.
set display=lastline                    " Show the lastline as possible.
" set expandtab                           " Exchange tab to space.
"set list
"set listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$
set formatoptions=q
set history=1000                        " Sets how much history and undo vim remombers.
set hlsearch                            " Highlight serach result.
set ignorecase                          " Ignore the case of normal letters, when search.
set incsearch                           " Enable incremental search.
set laststatus=2                        " The last window always have a status line.
set modeline                            " Enable modeline.
set noswapfile                          " Do not use a swapfile for the buffer.
"set number                              " Show line numbers.
set ruler                               " Show the line and column number of the cursor position.
set showmatch                           " Highlight parenthesis.
set smartcase                           " If the search pattern contains upper case characters, not to ignore.
set smarttab                            " Smart insert tab setting.
set splitbelow                          " When on, splitting a window will put the new window below the current one.
set splitright                          " When on, splitting a window will put the new window right of the current one.
set switchbuf=useopen                   " When `useopen`, jump to the first open window that contains the specified buffer.
set synmaxcol=300                       " Dont't try to highlight lines longer than 300 characters.
set statusline=%F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set title                               " Show title.
set ttyfast                             " Indicates a fast terminal connection.
set cursorline
set pumheight=10                        " Sets preview window up to 10
set nofixeol

" Set number of spaces to use for each step of (auto)indent.
" And round indent to multiple of 'shiftwidth'
set shiftwidth=4 shiftround

" Set colorscheme
set background=dark
colorscheme elflord

set t_Co=256
set term=xterm-256color

" Disable Background Color Erase (BCE) so that color sheme work
" properly when Vim is used inside tmux and GNU screen
set t_ut=

autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
set matchpairs& matchpairs+=<:>

" set for universal-ctags. Go back to parent directory if no tags file
set tags=masatana.tags;

" Disable bell.
set belloff=all
set novisualbell

" When running on terminal, use |clipboard-exclude|
" to disable connecting to X server
" not to be killed with X server.
set clipboard+=unnamed,autoselect

" Highlight code in markdown
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
\       'python',
\       'json=javascript',
\       'css',
\       'sh',
\]

let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1
" }}}

" Settings for each bundles{{{
" 

" vim-go
"let g:go_fmt_command = 'goimports'
"
"let g:neomake_go_errcheck_maker = {
"\ 'args': ['-abspath', s:goargs],
"\ 'append_file': 0,
"\ 'errorformat': '%f:%l:%c:\ %m, %f:%l:%c\ %#%m'
"\ }
"let g:neomake_go_enabled_makers = ['golint', 'govet', 'errcheck']

" clever-f.vim

" }}}

" Settings for each filetypes{{{
" 
augroup fileTypeIndent
    autocmd!
    autocmd FileType javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
    autocmd FileType html,htmldjango setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
    autocmd FileType php setlocal ts=4 noexpandtab shiftwidth=4 softtabstop=4 nolist
    autocmd FileType python setlocal nosmartindent
    autocmd BufNewFile,BufRead *.{md,mkd} setlocal filetype=markdown ts=2 expandtab shiftwidth=2 softtabstop=2
    autocmd FileType tex setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal ts=4
    autocmd FileType go setlocal shiftwidth=4
augroup END
" }}}

" If exsits local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
