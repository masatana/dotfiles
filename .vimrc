"My .vimrc
"
"  ^    ^    ^    ^    ^    ^    ^    ^
" /m\  /a\  /s\  /a\  /t\  /a\  /n\  /a\
"<___><___><___><___><___><___><___><___>
"
"Author: masatana <plaza.tumbling@gmail.com>
"

"==============================================================================
"Initialize{{{
"==============================================================================
"Check platform.
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
    "Exchange path separator.
    set shellslash
endif

"Use <Leader> in global plugin.
let g:mapleader=','

"Environment variables.
if !exists("$MYVIMRC")
    let $MYVIMRC = expand('~/.vimrc')
endif

if !exists("$MYGVIMRC")
    let $MYGVIMRC = expand('~/.gvimrc')
endif

"Set augroup.
augroup MyAutoCmd
    autocmd!
augroup END

"}}}

"==============================================================================
"Neobundle{{{
"==============================================================================
"Auto install NeoBundle
let isNeoBundleAlreadyInstalled = 1
let neobundle_readme = expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle..."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim
                \ $HOME/.vim/bundle/neobundle.vim
    let isNeoBundleAlreadyInstalled = 0
endif


function! s:meet_neocomplete_requirements()
    return has('lua') && ((v:version > 703) || ((v:version == 703) &&
                \ has('patch885')))
endfunction


filetype plugin indent off
if has("vim_starting")
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand("~/.vim/bundle/"))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete', {
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
NeoBundle 'taglist.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-surround'
"NeoBundle 'kana/vim-smartinput'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/hahhah-vim'
NeoBundle 'mattn/vim-airline-hahhah'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
filetype plugin indent on

"First-time plugins installation.
if isNeoBundleAlreadyInstalled == 0
    echo "Installing Bundles, please ignore key map error messages."
    echo ""
endif

NeoBundleCheck
"}}}

"==============================================================================
"General Settings{{{
"==============================================================================

"Enable color changing when reloading .vimrc.
if !has('gui_running') && !s:iswin
    "For Vim.
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    "For GVim.
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
            \ if has ('gui_running') | source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has ('gui_running') |
                \ source $MYGVIMRC
endif

"Enable smart indent.
set autoindent smartindent

"Enable folding.
set foldmethod=marker

"Enable syntax.
syntax enable

"Show line numbers.
set number

"Exchange tab to space.
set expandtab

"Smart insert tab setting.
set smarttab

"Show title.
set title

"Set number of spaces to use for each step of (auto)indent.
"And round indent to multiple of 'shiftwidth'
set shiftwidth=4 shiftround

"Highlight parenthesis.
set showmatch

"Display candidate supplement.
set nowildmenu wildmode=list:longest,full

"Ignore the case of normal letters, when search.
set ignorecase

"If the search pattern contains upper case characters, not to ignore.
set smartcase

"Enable incremental search.
set incsearch

"Highlight serach result.
set hlsearch

"Show the line and column number of the cursor position.
set ruler

"The cursor line will always be in the middle of the window.
set scrolloff=999

"When on, splitting a window will put the new window below the current one.
set splitbelow

"When on, splitting a window will put the new window right of the current one.
set splitright

"Allow backspacing over sutoindent, line breaks, start of insert.
set backspace=indent,eol,start

"Do not use a swapfile for the buffer.
set noswapfile

"The last window always have a status line.
set laststatus=2

"When `useopen`, jump to the first open window that contains the specified
"buffer.
set switchbuf=useopen

set clipboard=unnamed,autoselect
set t_Co=256
set textwidth=0
if exists('&colorcolumn')
    set colorcolumn=+1
endif
autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set list
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set matchpairs& matchpairs+=<:>


"Disable bell.
set t_vb=
set novisualbell

"Read .vimrc.local if exists.
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
"}}}

"==============================================================================
"Remappings{{{
"==============================================================================
"Now, <C-c> and <Esc> are exactly the same.
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
nnoremap <Leader>ev : <C-u>edit $MYVIMRC<CR>
"}}}

"==============================================================================
"Settings for each bundles{{{
"==============================================================================
"airline
let g:airline_theme='badwolf'

"indentLine
let g:indentLine_char="¦"
let g:indentLine_color_term=239

"syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"taglist
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Use_Right_Window = 1 "右側でtaglistのWindowを表示
let Tlist_Exit_OnlyWindow = 1 "taglistのWindowが最後ならばVimを閉じる
let Tlist_Show_One_File = 1 "現在編集中のSourceのtagしか表示しない

"quickrun
let g:quickrun_config = {
            \     "_": {
            \         "outputter/buffer/split": ":botright",
            \         "outputter/buffer/close_on_empty": 1,
            \         "runner": "vimproc",
            \         "runner/vimproc/updatetime": 60
            \     },
            \ }

let g:quickrun_config['markdown'] = {
            \    'outputter': 'browser',
            \ }

if s:meet_neocomplete_requirements()
    "neocomplete
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
        return pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"
    endfunction
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
else
    "neocomplcache
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
                \ ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
    inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
    inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
    inoremap <expr><C-h>  neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS>  neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction
endif
"}}}

"==============================================================================
"Encoding{{{
"==============================================================================
set encoding=utf-8
source $HOME/.vim/encode.vim
"}}}

"==============================================================================
"Settings for each filetypes{{{
"==============================================================================
autocmd FileType javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType php setlocal ts=4 noexpandtab shiftwidth=4 softtabstop=4 nolist
autocmd FileType python setlocal nosmartindent
autocmd FileType text setlocal textwidth=80
autocmd FileType go setlocal rtp+=$GOROOT/misc/vim
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown textwidth=80
"}}}
