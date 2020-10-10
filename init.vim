if &compatible
    set nocompatible
endif
call plug#begin('~/.vim/plugged')
    set rtp+=~/.zsh/fzf
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'sheerun/vim-polyglot'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'lifepillar/vim-solarized8'
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'chrisbra/vim-zsh'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeCWD']}
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'haya14busa/incsearch.vim'
    Plug 'sbdchd/neoformat'
    Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}
    "Plug 'OmniSharp/omnisharp—vim'
call plug#end()

"todo
if has('win32')
    let $VIMFILES=$VIM.'/vimfiles'
    let g:os = 'win'
elseif has('mac')
    let $VIMFILES=$HOME.'/.vim'
    let g:os = 'mac'
"end of todo
else
    let $VIMFILES=$HOME.'/.vim'
    let g:os = 'linux'
    set backup
    if !isdirectory($HOME . "/.vim/backup")
        call mkdir($HOME . "/.vim/backup", "p")
    endif
    set backupdir=~/.vim/backup
    au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
    if !isdirectory($HOME . "/.vim/undo")
        call mkdir($HOME . "/.vim/undo", "p")
    endif
    set undodir=~/.vim/undo
    set undofile
    let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
    if !filereadable(autoload_plug_path)
      silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    unlet autoload_plug_path
endif
if has('autocmd')
    filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

augroup vimrcEx
autocmd!
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END

set encoding=utf-8
set title
set completeopt-=preview
set autoread
set backspace=indent,eol,start
set shortmess=atI
set clipboard=unnamedplus
set wildmenu
set wildmode=longest,list,full
set number
set ruler
set showmatch
set ignorecase
set smartcase
set wildignorecase
set lazyredraw
set magic
set scrolloff=3
set noerrorbells
set novisualbell
set showcmd
set hidden
set history=500
set noshowmode
set noswapfile
set splitbelow
set splitright
set cursorline
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set nolinebreak
set nostartofline
set wrap
set path+=**
set tags+=~/workdir/tags
set laststatus=2
set showtabline=2
set termguicolors
set background=dark
let g:solarized_italics=1
let g:solarized_termtrans=1
colorscheme solarized8

let airline_theme='solarized_flood'
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#wordcount#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#fugitive#enabled=1
let g:airline#extensions#gutentags#enabled=1
let g:airline#extensions#ctrlp#enabled=1
let DevIconsEnableFolderExtensionPatternMatching=1
let DevIconsEnableFoldersOpenClose=1
let g:webdevicons_enable_airline_tabline=0
let g:NERDTreeShowHidden=1
let g:gutentags_background_update=1

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = ['g:ycm_python_interpreter_path', 'g:ycm_python_sys_path']
let g:ycm_global_ycm_extra_conf = '~/.local/global_extra_conf.py'
let g:ycm_always_populate_location_list=1
let g:ycm_auto_populate_location_list=1
let g:ycm_clangd_binary_path='/usr/bin/clangd'
let g:ycm_clangd_uses_ycmd_caching=0
let g:ycm_use_clangd=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='⚠'
"let g:OmniSharp_server_stdio=1
"let g:OmniSharp_server_use_mono=1
"let g:OmniSharp_selector_ui='fzf'
"let g:OmniSharp_server_path='/home/gacman/.vim/plugged/YouCompleteMe/third_party/ycmd/third_party/omnisharp-roslyn/bin/mono'
"let g:OmniSharp_highlight_types=2
"let g:OmniSharp_highlight_groups = {'csUserIdentifier': ['constant name', 'enum member name', 'field name', 'identifier', 'local name', 'parameter name', 'property name', 'static symbol'], 'csUserInterface': ['interface name'], 'csUserMethod': ['extension method name', 'method name'], 'csUserType': ['class name', 'enum name', 'namespace name', 'struct name']}
set hlsearch
let g:incsearch#auto_nohlsearch=1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
"let g:syntastic_error_symbol=‘X‘
"let syntastic_style_error_symbol =‘X'
"let g:syntastic_warning_symbol="-'
"let syntastic_style_warning_symbol="-‘

let mapleader=","
noremap<R> :redo<CR>
nnoremap<leader>vrc :vs $MYVIMRC<CR>
nnoremap<leader>v :vsplit \| :enew<CR>
nnoremap<leader>h :split \| :enew<CR>
nnoremap <Leader>[ :b#<CR>
nnoremap <Leader>] :bn<CR>
nnoremap<leader>q :q<CR>
nnoremap<leader>w :w<CR>
nnoremap<silent><leader>c :cclose<BAR>lclose<CR>
nnoremap<leader>f :YcmCompleter Format<CR>
nnoremap<F1> :set invnumber<CR><CR>
set pastetoggle=<F2>
nnoremap<F3> :set list! list?<CR>
nnoremap<F4> :NERDTreeToggle<CR><F3>
nnoremap<F5> :TagbarToggle<CR><F4>
nnoremap<F8> :call CompileRun()<CR>
nnoremap<leader>o :call OpenContainerFolder()<CR><CR>
cnoremap Q <Nop>
" strip all trailing whitespace in the current file
nnoremap <leader>st :%s/\s\+$//e<cr>:let @/=''<CR>

func! CompileRun()
    exec ":w"
    let g:asyncrun_open = 10
    if &filetype == "lua"
        exec "AsyncRun lua %"
    elseif &filetype == "python"
        exec "AsyncRun -raw python %"
    elseif &filetype == "go"
        exec "AsyncRun! -raw go run %"
    elseif &filetype == "objc" || &filetype == "cpp" || &filetype == "c" || &filetype == "cs" || &filetype == "java"
        if &filetype == "objc"
            exec "AsyncRun g++ -framework Foundation % -o %<"
        elseif &filetype == "cpp" || &filetype == "c"
            if &filetype == "c"
                let l:cmd = "AsyncRun gcc % -g -Wall -o %< -std=c11"
            else
                let l:cmd = 'AsyncRun g++ -o %< % -g -Wall -std=c++11 -lpthread'
            endif
            if g:os == 'win'
                let l:cmd = l:cmd . ' -lwsock32'
            endif
            exec l:cmd
        elseif &filetype == "cs"
            exec "AsyncRun csc % /nologo /utf8output"
        elseif &filetype == "java"
            exec "AsyncRun javac %"
        endif
        let g:asyncrun_exit = 'call Run()'
    endif
    unlet g:asyncrun_open
endfunc

func! Run()
    if g:asyncrun_status == "success"
        if &filetype == "java"
            exec "AsyncRun java %:r"
        else
            if g:os == 'win'
                exec "AsyncRun -mode=4 %<"
            else
                exec "AsyncRun ./%<"
            endif
        endif
        let g:asyncrun_exit = ''
    endif
endfunc

function! OpenContainerFolder()
    if expand('%') != ""
        exec "NERDTreeCWD"
    endif
endfunc

"JSON lint one-liner:
":%!python -c "import json, sys; print(json.dumps(json.loads(sys.stdin.read()), indent=2, sort_keys=True))"
