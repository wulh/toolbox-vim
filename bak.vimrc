filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
syntax on
filetype on
filetype plugin on
filetype plugin indent on

set nocompatible
"=============Outlook Settings===========
" set modelines=0

syntax enable
set background=dark
colorscheme solarized

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim") || has("gui_mac")
        set guifont=Andale_Mono:h14
        set transparency=7
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
    :set fu
    :set nofu
endif

" Enable basic mouse bahavior such as resizing buffers.
set mouse=a
if exists('$TMUX')   " Support resizing in tmux
    set ttymouse=xterm2
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
set wildmode=list:longest,list,full
set visualbell
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

set guioptions=egmrti
" set gfn=Monospace\ 14

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"" Encoding
set bomb
set binary
set ttyfast

" Disable visualbell
set visualbell t_vb=

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" vim-airline for others
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

"=========== Abbreviations Setting =============
"" make dot action works in visual mode
vnoremap . :norm.<CR>
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
" for search ignoring case
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

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
" special window operation, like: resize
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>v <C-w>t<C-w>H
nnoremap + :vertical resize 87<cr>
nnoremap - :vertical resize 50<cr>
"
" make split window resize equally
if bufwinnr(1)
    map = <C-W>=
endif
"
"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap P "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

" move in windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
"
"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
"" Move visual block
vnoremap <C-S-J> :m '>+1<CR>gv=gv
vnoremap <C-S-K> :m '<-2<CR>gv=gv
"
"quit when left quickfix only
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winnr('$') < 2
      quit
    endif
  endif
endfunction
"
" format json string
nnoremap <leader>fj :%!python -m json.tool<cr>
"
" string operation, like: strip
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
"
" coding fold
set foldmethod=indent
set foldlevel=99
"
" session management
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
"
"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
"
"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"
"============= plugins setting ===============
"" YouCompleteMe
"
"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
let g:NERDSpaceDelims = 1
set wildignore+=*/build/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F4> :NERDTreeToggle<CR>

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" ACK
nnoremap <leader>a <Esc>:Ack!

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>
" nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags=./tags;/

" easy-tag
let g:easytags_auto_update = 0
let g:easytags_updatetime_min = 10000
let g:easytags_events = ['BufWritePost']

" jedi-vim
let g:jedi#auto_initializatin = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentations_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#use_tabs_not_buffers = 0

set shell=/bin/sh

" set omnifunc=jedi#completions
" set completeopt=menuone,longest,preview

"syntastic setting
:command SD SyntasticToggleMode
" , 'flake8'
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_python_flake8_post_args='--ignore=W391'
" , 'eslint'
let g:syntastic_javascript_checkers=['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" ag
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" 
" ctrlp
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 0
let g:ctrlp_open_new_file = 'r'
"
" vim-session
let g:session_directory = "~/.vim/session"
let g:session_command_aliases = 1
let g:session_autoload = "no"
let g:session_autosave = 'no'

" tmux
" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" vim-tmux
" Prompt for a command to run
map ,p :VimuxPromptCommand<CR>
" Run a command as arg
map ,r :VimuxRunCommand
" Run last command executed by RunVimTmuxCommand
map ,l :VimuxRunLastCommand
" Inspect runner pane
map ,i :VimuxInspectRunner
" Close all other tmux panes in current window
map ,x :VimuxTogglePane
" Interrupt any command running in the runner pane
map ,s :VimuxInterruptRunner

"================= For Python ==================
" Add custom library path, let jedi autocomplete works
" py << EOF
" import os
" import sys
" import vim
" localpath = os.path.join("/usr/local/lib/", "python%d.%d" % sys.version_info[:2], "site-packages")
" sys.path.append(localpath)
" sys.path.append(os.path.join(localpath, "nose-1.3.6-py2.7.egg"))
" if 'VIRTUAL_ENV' in os.environ:
    " project_base_dir = os.environ['VIRTUAL_ENV']
    " sys.path.insert(0, os.path.join(project_base_dir, 'lib', 'python%d.%d' % sys.version_info[:2], 'site-packages'))
" EOF
if has('python')
" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <F11> :py EvaluateCurrentRange()

" Use F7/Shift-F7 to add/remove a breakpoint (pdb.set_trace)
" Totally cool.
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace()" %
         {'space':strWhite}, nLine - 1)
    vim.current.buffer.append(
       "%(space)s%(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 10}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:15] == "pdb.set_trace()"\
				or "Breakpoint" in strLine:
            nLines.append(nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "map <s-f7> :py RemoveBreakpoints()<cr>")
EOF
endif
"
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  let python_highlight_all = 1
  set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END
ia pdb import pdb; pdb.set_trace()<ESC>
"
"
" ===================== for javascript ==============
let g:javascript_enable_domhtmlcss = 1
autocmd FileType javascript setlocal omnifunc=tern#Complete


" Run-File
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

" auto complete
:set dictionary+=~/.vim/js.dict

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
" git
autocmd FileType gitcommit setlocal spell
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
