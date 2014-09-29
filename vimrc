" My .vimrc
" vim: set foldmethod=marker:
" Author: masatana <plaza.tumbling+github@gmail.com>

" ==============================================================================
" Initialize{{{
" ==============================================================================
" UTF-8!!! (Other settings such as fileencoding is on the other place.
scriptencoding utf-8

" If installed vim is not tiny nor small, do not load the code below.
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
function! s:meet_neocomplete_requirements()
    return has('lua') && ((v:version > 703) || ((v:version == 703) &&
                \ has('patch885')))
endfunction


filetype plugin indent off
if has("vim_starting" )
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand("~/.vim/bundle/" ))
endif

let g:neobundle_default_git_protocol='git'
NeoBundleFetch 'Shougo/neobundle.vim'
if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete', {
        \ 'lazy':1,
        \ 'autoload': {
        \       'insert': 1,
        \ }}
else
    NeoBundle 'Shougo/neocomplcache', {
        \ 'lazy': 1,
        \ 'autoload': {
        \       'insert': 1,
        \ }}
endif

NeoBundle 'Align'
NeoBundle 'tomasr/molokai'
"NeoBundle 'taglist.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
"NeoBundle 'kana/vim-smartinput'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Yggdroot/indentLine'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/hahhah-vim'
NeoBundle 'mattn/vim-airline-hahhah'
NeoBundle 'mattn/flappyvird-vim'
NeoBundle 'yanktmp.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
"NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'scrooloose/nerdtree'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'mrtazz/simplenote.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
if isGoInstalled
    NeoBundle 'fatih/vim-go'
endif
NeoBundle 'moznion/hateblo.vim'

" Python
"NeoBundle 'python.vim'

" Haskell
"NeoBundle 'dag/vim2hs'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'eagletmt/ghcmod-vim'

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

" Read .vimrc.local if exists.
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

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
let g:airline_theme='molokai'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_c = airline#section#create(['%{getcwd()}', '/', 'file'])
endfunction
autocmd VimEnter * call AirlineInit()

" indentLine
let g:indentLine_char="¦"
let g:indentLine_color_term=239

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_go_checkers=['go', 'golint']

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

if s:meet_neocomplete_requirements()
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
else
    " neocomplcache{{{
    set completeopt=menuone
    let g:neocomplcache_enable_at_startup=1
    let g:neocomplcache_enable_smart_case=1
    let g:neocomolcache_enable_camel_case_completion=1
    let g:neocomplcache_enable_underbar_completion=1
    let g:neocomplcache_min_syntax_length=3
    let g:neocomplcache_max_list=20
    let g:neocomplcache_min_syntax_length=3

    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns={}
    endif
    let g:neocomplcache_keyword_patterns['default']='\h\w*'
    map <expr><C-k> neocomplcache#sources#snippets_complete#expandable()
                \ ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
    smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable()
                \ ? "\<Plug>(neocomplcache_snippets_expand)"  : "\<C-o>D"
    inoremap <expr><TAB> pumvisible() ? "\<Down>"  : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
    inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
    inoremap <expr><C-h>  neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS>  neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction"}}}
endif

"  Fugitive
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gs :<C-u>Gstatus<CR>
nnoremap <Leader>gw :<C-u>Gwrite<CR>
nnoremap <Leader>ga :<C-u>Gadd<CR>

" python.vim
let python_highlight_all = 1

" yanktmp.vim
map <silent>sy :call YanktmpYank()<CR>
map <silent>sp :call YanktmpPaste_p()<CR>
map <silent>sP :call YanktmpPaste_P()<CR>

" memolist.vim
map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>
let g:memolist_memo_suffix = "md"

" netrw.vim (Standard plugin
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1

" vim2hs
let g:haskell_conceal = 0
" vim-indent-guides
hi IndentGuidesOdd ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" clever-f.vim
let g:clever_f_chars_match_any_signs = ";"

" unite.vim
nnoremap [unite] <Nop>
nmap <Leader>f [unite]

let g:unite_enable_start_insert=1

nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer --bufer-name=buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif

au FileType unite nnoremap <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite inoremap <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite nnoremap <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <C-c><C-c> :<C-u>q<CR>
au FileType unite inoremap <silent> <buffer> <C-c><C-c> <Esc>:<C-u>q<CR>


" }}}

" ==============================================================================
" Settings for each filetypes{{{
" ==============================================================================
autocmd FileType javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType html,htmldjango setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType php setlocal ts=4 noexpandtab shiftwidth=4 softtabstop=4 nolist
autocmd FileType python setlocal nosmartindent
autocmd FileType text setlocal textwidth=80
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
" }}}

" Scouter
function! Scouter(file, ...)
    let pat = '^\s*$\|^\s*"'
    let lines = readfile(a:file)
    if !a:0 || !a:1
        let lines = split(substitute(join(lines, "\n" ), '\n\s*\\', '', 'g'), "\n" )
    endif
    return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
    \ echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)

" Change current directory
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction
nnoremap <silent><Leader>cd :<C-u>CD<CR>

" If exsits local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
