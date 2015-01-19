" My .vimrc
" vim: set foldmethod=marker:
" Author: masatana <plaza.tumbling+github@gmail.com>

" ==============================================================================
" Initialize{{{
" ==============================================================================
" UTF-8!!! (Other settings such as fileencoding is on the other place.
scriptencoding utf-8

" If installed vim is tiny or small, do not load the code below.
if !1 | finish | endif

" Check platform.
let s:iswin = has('win32') || has('win64')
let s:iscygwin = has('win32unix')
let s:ismac = has('mac') || has('macunix') || has('gui_mac') ||
            \ has('gui_macvim') || (!executable('xdg-open') &&
            \ system('uname') =~? '^darwin')
let s:islinux = !s:iswin && !s:iscygwin && !s:ismac

if s:iswin
    language message en
else
    language message C
endif
language ctype C
language time C

if s:iswin
    " Exchange path separator.
    set shellslash
endif

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

" Set augroup.
augroup MyAutoCmd
    autocmd!
augroup END

" Set for go lang.
if $GOPATH != ''
    set rtp+=$GOROOT/misc/vim
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    let isGoInstalled = 1 " True
else
    let isGoInstalled = 0 " False
endif

" }}}

" ==============================================================================
" Neobundle{{{
" ==============================================================================

filetype plugin indent off
if has("vim_starting" )
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

let g:neobundle_default_git_protocol='git'

NeoBundle 'Shougo/neocomplete', {
    \ 'lazy':1,
    \ 'autoload': {
    \       'insert': 1,
    \ }}

NeoBundle 'Align'
NeoBundle 'tomasr/molokai'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/hahhah-vim'
NeoBundle 'mattn/vim-airline-hahhah'
NeoBundle 'yanktmp.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'google/vim-ft-go'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'haya14busa/incsearch.vim'
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim

filetype plugin indent on

NeoBundleCheck
" }}}

" ==============================================================================
" Encoding{{{
" ==============================================================================
set encoding=utf-8
source $HOME/.vim/encode.vim
" }}}

" ==============================================================================
" Remappings{{{
" ==============================================================================

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
nnoremap <Leader>ev : <C-u>edit $MYVIMRC<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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

" ==============================================================================
" General Settings{{{
" ==============================================================================

" Enable olor changing when reloading .vimrc.
if !has('gui_running') && !s:iswin
    " For Vim.
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " For GVim.
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
            \ if has ('gui_running') | source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has ('gui_running') |
                \ source $MYGVIMRC
endif

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
set title                               " Show title.
set ttyfast                             " Indicates a fast terminal connection.
set wildmenu wildmode=list:longest,full " Display candidate supplement.
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
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
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
\       'go',
\       'css',
\       'sh',
\]
" }}}

" ==============================================================================
" Settings for each bundles{{{
" ==============================================================================
" airline
let g:airline_theme='sol'

function! AirlineInit()
    let g:airline_detect_iminsert=1
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_c = airline#section#create(['%{getcwd()}', '/', 'file'])
endfunction
autocmd VimEnter * call AirlineInit()

" vim-go
let g:go_fmt_command = "goimports"

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_go_checkers=['go', 'golint']
let g:syntastic_quiet_messages = { "level": "warnings"}

" quickrun
let g:quickrun_config = {
            \     "_" : {
            \         "outputter/buffer/split" : ":botright" ,
            \         "outputter/buffer/close_on_empty" : 1,
            \         "runner" : "vimproc" ,
            \         "runner/vimproc/updatetime" : 60
            \     },
            \ }

let g:quickrun_config['markdown'] = {
            \    'outputter': 'browser',
            \    'args': '--mathjax'
            \ }

let g:quickrun_config['html'] = {
            \    'command': 'open',
            \    'exec': '%c %s',
            \    'outputter': 'browser',
            \ }

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

"  Fugitive
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gs :<C-u>Gstatus<CR>
nnoremap <Leader>gw :<C-u>Gwrite<CR>
nnoremap <Leader>ga :<C-u>Gadd<CR>

" yanktmp.vim
map <silent>sy :call YanktmpYank()<CR>
map <silent>sp :call YanktmpPaste_p()<CR>
map <silent>sP :call YanktmpPaste_P()<CR>

" memolist.vim
map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>
let g:memolist_memo_suffix = "md"
let g:memolist_path = "~/Dropbox/memo"
let g:memolist_unite = 1
let g:memolist_unite_source = "file_rec"
let g:memolist_unite_option = "-start-insert"

" netrw.vim (Standard plugin
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1

" vim2hs
let g:haskell_conceal = 0

" clever-f.vim
let g:clever_f_chars_match_any_signs = ";"

" unite.vim
nnoremap [unite] <Nop>
nmap <Leader>f [unite]

let g:unite_enable_start_insert=1
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif

nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer --bufer-name=buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
au FileType unite nnoremap <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite inoremap <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite nnoremap <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <C-c><C-c> :<C-u>q<CR>
au FileType unite inoremap <silent> <buffer> <C-c><C-c> <Esc>:<C-u>q<CR>

call unite#custom#profile('default', 'context', {
    \ 'prompt_direction': 'top',
    \ 'prompt': '> ',
    \ 'candidate_icon': '- ',
    \ 'hide_icon': 0})

" Align.vim
let g:Align_xstrlen = 3

" }}}

" ==============================================================================
" Settings for each filetypes{{{
" ==============================================================================
autocmd FileType javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType php setlocal ts=4 noexpandtab shiftwidth=4 softtabstop=4 nolist
autocmd FileType python setlocal nosmartindent
autocmd FileType text setlocal textwidth=80
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown ts=2 shiftwidth=2 softtabstop=2
set path+=$GOPATH/src/**
autocmd FileType go setlocal sw=4 noexpandtab ts=4 completeopt=menu,preview
autocmd FileType tex setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
" }}}

" If exsits local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
