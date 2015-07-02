filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
syntax on
filetype on
filetype plugin on
filetype plugin indent on

set nocompatible

set modelines=0

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Andale_Mono:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
    :set fu
    :set nofu
endif
"make split window resize equally
if bufwinnr(1)
    map = <C-W>=
endif

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"hi cursorline guibg=NONE gui=underline

if &diff
    nmap <F7> [c
    nmap <F8> ]c
else
    map <F7> :cp<cr>
    map <F8> :cn<cr>
endif

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nmap <C-S-J> o<Esc>k
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>w <C-w>v<C-w>l
"format json string
nnoremap <leader>fj :%!python -m json.tool<cr>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

map <F4> :NERDTreeToggle<CR>

map <leader>g :GundoToggle<CR>

nmap <leader>a <Esc>:Ack!

map <leader>s :TagbarToggle<CR>
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags=./tags;/

set wildignore+=*.swp,*.zip,*.pyc,*.*~

let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentations_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#completions_command = "<C-J>"

set foldmethod=indent
set foldlevel=99

" let jedi autocomplete works
if has('python')
py << EOF
import os.path
import sys
import vim
localpath = os.path.join("/usr/local/lib/", "python%d.%d" % sys.version_info[:2], "site-packages")
sys.path.append(localpath)
sys.path.append(os.path.join(localpath, "nose-1.3.6-py2.7.egg"))
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, os.path.join(project_base_dir, 'lib', 'python%d.%d' % sys.version_info[:2], 'site-packages'))
EOF
endif
set omnifunc=jedi#completions
set completeopt=menuone,longest,preview

"syntastic setting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"comment setting
let g:NERDSpaceDelims = 1

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

map <F12> <Esc>:w<CR>:call RunOneFile()<CR>
function! RunOneFile()
    if &filetype=='vim'
        source %
    elseif &filetype=='python'
        if expand('%:e')=='py3'
            !python3 %
        else
            !python %
        endif
    endif
endfunction

ia pdb import pdb; pdb.set_trace()<ESC>
