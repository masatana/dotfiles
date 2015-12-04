" My .vimrc
" vim: set foldmethod=marker:
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

" Neobundle{{{
" 

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete'

Plug 'Align'
Plug 'tomasr/molokai'
Plug 'scrooloose/syntastic'
Plug 'rhysd/clever-f.vim'
Plug 'haya14busa/incsearch.vim'

call plug#end()

" }}}

" Encoding{{{
" 
set encoding=utf-8
source $HOME/.vim/encode.vim
" }}}

" Remappings{{{
" 

" For haya14busa incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#auto_nohlsearch = 1

" Invalidate forced termination.
noremap ZZ <Nop>
noremap ZQ <Nop>
command! -nargs=0 Q :q!
command! -nargs=0 QQ :qa!

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <C-c> <Esc>

noremap <BS> <C-h>
noremap! <BS> <C-h>

nmap <silent> <C-c> :nohlsearch<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

nnoremap j gj
nnoremap k gk

nnoremap P $p

" http://vim-users.jp/2011/04/hack214/
vnoremap ( t(
vnoremap ) t)
onoremap ( t(
onoremap ) t)

" Emacs-like keybind in command-line mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Backspace>
cnoremap <C-d> <Delete>
" }}}

" General Settings{{{
" 

" Enable olor changing when reloading .vimrc.
" For GVim.

syntax enable                           " Enable syntax.
set ambiwidth=double                    " Tell Vim what to do with characters with multibite font.
set autoindent smartindent              " Enable smart indent.
set backspace=indent,eol,start          " Allow backspacing over sutoindent, line breaks, start of insert.
set completeopt-=preview                " Do not show doc preview when using neocomplete.
set display=lastline                    " Show the lastline as possible.
set expandtab                           " Exchange tab to space.
set formatoptions=q
set history=1000                        " Sets how much history and undo vim remombers.
set hlsearch                            " Highlight serach result.
set ignorecase                          " Ignore the case of normal letters, when search.
set incsearch                           " Enable incremental search.
set laststatus=2                        " The last window always have a status line.
set modeline                            " Enable modeline.
set noswapfile                          " Do not use a swapfile for the buffer.
set number                              " Show line numbers.
set ruler                               " Show the line and column number of the cursor position.
set showmatch                           " Highlight parenthesis.
set smartcase                           " If the search pattern contains upper case characters, not to ignore.
set smarttab                            " Smart insert tab setting.
set splitbelow                          " When on, splitting a window will put the new window below the current one.
set splitright                          " When on, splitting a window will put the new window right of the current one.
set switchbuf=useopen                   " When `useopen`, jump to the first open window that contains the specified buffer.
set synmaxcol=300                       " Dont't try to highlight lines longer than 300 characters.
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set title                               " Show title.
set ttyfast                             " Indicates a fast terminal connection.
set cursorline
set pumheight=10                        " Sets preview window up to 10

" Set number of spaces to use for each step of (auto)indent.
" And round indent to multiple of 'shiftwidth'
set shiftwidth=4 shiftround

" Set colorscheme
autocmd ColorScheme * highlight Comment ctermfg=33 guifg=#009900
autocmd ColorScheme * highlight String ctermfg=33 guifg=#009900
autocmd ColorScheme * highlight Charcter ctermfg=22 guifg=#009900
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

set t_Co=256
set term=xterm-256color

" Disable Background Color Erase (BCE) so that color sheme work
" properly when Vim is used inside tmux and GNU screen
set t_ut=

set textwidth=0
if exists('&colorcolumn')
    set colorcolumn=+1
endif
autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
set matchpairs& matchpairs+=<:>


" Disable bell.
set t_vb=
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
" }}}

" Settings for each bundles{{{
" 

" syntastic
let g:syntastic_always_popular_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_quiet_messages = { "level": "warnings"}
let g:syntastic_python_python_exec = '/home/masatana/local/bin/python3'

" neocomplete{{{
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=2
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries={
    \ 'default': '',
    \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocmplete#keyword_patterns={}
endif
let g:neocmplete#keyword_patterns['default'] = '\h\w*'
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr><TAB> pumvisible() ? "\<C-n>"  : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif"}}}

" yanktmp.vim
map <silent>sy :call YanktmpYank()<CR>
map <silent>sp :call YanktmpPaste_p()<CR>
map <silent>sP :call YanktmpPaste_P()<CR>

" clever-f.vim
let g:clever_f_chars_match_any_signs = ";"


" Align.vim
let g:Align_xstrlen = 3

" }}}

" Settings for each filetypes{{{
" 
autocmd FileType javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType php setlocal ts=4 noexpandtab shiftwidth=4 softtabstop=4 nolist
autocmd FileType python setlocal nosmartindent
autocmd FileType text setlocal textwidth=80
autocmd BufNewFile,BufRead *.{md,mkd} setlocal filetype=markdown ts=2 shiftwidth=2 softtabstop=2
autocmd FileType tex setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
" }}}

" If exsits local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
