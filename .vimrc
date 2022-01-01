" ------------------------------------------------------------------------------
" Initialization
" ------------------------------------------------------------------------------

set nocompatible
filetype off

" ------------------------------------------------------------------------------
" Plugin listing
" ------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged/')

" Autocomplete
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --go-completer --rust-completer' }
" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Async library
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Better C++ highlights
Plug 'octol/vim-cpp-enhanced-highlight'
" C++ formatting
Plug 'rhysd/vim-clang-format'
" Faster f,t movement
Plug 'unblevable/quick-scope'
" Git awesomeness
Plug 'tpope/vim-fugitive'
" Paren editing
Plug 'tpope/vim-surround'
" Repeat for surround
Plug 'tpope/vim-repeat'
" Session continuous saving
Plug 'tpope/vim-obsession'
" Git gutter
Plug 'airblade/vim-gitgutter'
" File browser
Plug 'scrooloose/nerdtree'
" Easy commenting
Plug 'scrooloose/nerdcommenter'
" File linting
Plug 'w0rp/ale'
" Colorscheme
Plug 'morhetz/gruvbox'
" Use * to find whats in a visual selection
Plug 'nelstrom/vim-visual-star-search'
" Text alignment
Plug 'godlygeek/tabular'
" Visual undo tree
Plug 'sjl/gundo.vim'
" Project search using Ag
Plug 'rking/ag.vim'
" Tag file generation
Plug 'ludovicchabant/vim-gutentags'
" Rusty!
Plug 'rust-lang/rust.vim'
" Swap filetypes quickly
Plug 'vim-scripts/a.vim'
" View calltree of C/C++
Plug 'hari-rangarajan/CCTree'
" Tmux nav
Plug 'christoomey/vim-tmux-navigator'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Latex
Plug 'lervag/vimtex'

call plug#end()

" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------

set enc=utf-8 "UTF-8

" Syntax Highlighting
syntax on
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" fixes glitch? in colors when using vim with tmux
set t_Co=256
set termguicolors

" Editor behavior
set nospell
set nowrap        " No Wrapping
set expandtab     " Tabs are spaces, not tabs
set tabstop=4     " tell vim how many columns a tab counts for
set softtabstop=4 " let backspace delete indent
set shiftwidth=4  " to control how many columns text is indented with the reindent operations
set autoindent    " insensitiveIndent at the same level of the previous line
set updatetime=100 " 100ms update time for GUI events
set signcolumn=yes

filetype indent on
filetype plugin on
set scrolljump=5      " Lines to scroll when cursor leaves screen
set scrolloff=3       " Minimum lines to keep above and below cursor
set foldenable        " Auto fold code
set foldmethod=manual " Default is manual
set number            " Line Numbering
set ruler             " Turn on the ruler

" Expanded editing settings (make vim sane)
set showmode
set showcmd
set hidden                     " allow hidden buffers
set cursorline                 " highlight the line the cursor is on
set ttyfast                    " fixes slow scrolling in some terminal emulators
set backspace=indent,eol,start
set laststatus=2
set relativenumber             " shows relative line numbering instead of absolute
set undofile                   " Persistent undo between edits
set notimeout                  " disable multi key command timeout, it breaks some terminals
set showmatch                  " highlight matching paren on close

map , <leader>

" Search settings
set ignorecase
set smartcase " case insensitive search for all lowercase word, sensitive if any uppercase letters
set gdefault  " replace global as defult when :%s'ing
set incsearch " match as you type
set hlsearch  " Highlight search results as you type

" Clear highlights
nnoremap <leader><space> :noh<cr>

" Make jk visual line wise for wrapped lines.
nnoremap j gj
nnoremap k gk

" Disable the worst key on the keyboard
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Resource vimrc on F12
nnoremap <F12> :source ~/.vimrc<cr>

" Exit insert with jk, kj
inoremap jk <ESC>
inoremap kj <ESC>

" write all open buffers when window focus lost
au FocusLost * :wa

" resize buffer windows on resize
au VimResized * :wincmd =

" configure all scratch file behavior
set backup                        " enable backups
set noswapfile                    " No more swap

" Move all the temp files vim dumps out to one place.
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Split window navigation improvements
" w opens a new vertical split, and moves focus to it, r does horiz
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>r <C-w>s<C-w>j
" map ctrl-hjkl to move between split buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab configuration
nnoremap <leader>t :tabnew<cr>

"Auto append closing characters for brackets
inoremap {      {}<left>
inoremap {<cr>  {<cr>}<esc>O
inoremap {}     {}

" tabbing shortcuts
noremap <leader>] :tabn<cr>
noremap <leader>[ :tabp<cr>

"Avoid the horrors of ctrl-u ctrl-w. Delete line or word with no undo :/
"http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"quickfix list navigation
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>
nnoremap <F9> :cw<CR>

" Set editing font for gui
set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 11

"Remove GUI Fluff (easier way, don't open the GUI)
set guioptions-=m "remove menu bar
set guioptions-=T "remove tool bar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=R
set guioptions-=l "remove left-hand scroll bar
set guioptions-=L
set guioptions-=b "remove bottom scroll bar

" Set highlight for a word, clear by calling on whitespace
function! HiInterestingWord(n)
  " Save our location.
  normal! mz
  " Yank the current word into the z register.
  normal! "zyiw
  " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
  let mid = 86750 + a:n
  " Clear existing matches, but don't worry if they don't exist.
  silent! call matchdelete(mid)
  " Construct a literal pattern that has to match at boundaries.
  let pat = '\V\<' . escape(@z, '\') . '\>'
  " Actually match the words.
  call matchadd("InterestingWord" . a:n, pat, 1, mid)
  " Move back to our original location.
  normal! `z
endfunction

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" Default Highlights

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

"markdown support
function! Markdown()
  set filetype=markdown
  setlocal textwidth=80
  setlocal spell
endfunction

autocmd BufNewFile,BufRead *.md call Markdown()
command! MdMode call Markdown()

" Latex configs
autocmd FileType tex setlocal spell
autocmd Filetype tex setlocal ts=2 sw=2 sts=2
let g:tex_flavor = 'latex'

command! W w !sudo tee % > /dev/null

"Strip trailing whitespace
function! StripTrailing()
  %s/\s\+$//g
endfunction
command! StripSpace call StripTrailing()

function! Csc()
    cscope find c <cword>
    copen
endfunction
command! Csc call Csc()

autocmd Filetype tf setlocal shiftwidth=2 softtabstop=2 expandtab

" ------------------------------------------------------------------------------
" Plugin Configuration
" ------------------------------------------------------------------------------
" airline
let g:airline_powerline_fonts = 1

" Map fuzzy finder
nnoremap <C-p> :FZF<cr>
let g:fzf_height = 10
let $FZF_DEFAULT_COMMAND = 'rg -l ""'

" enable glsl syntax highlighting
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl

" NERDTree
let g:NERDTreeHijackNetrw=1

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
set completeopt-=preview
" set completeopt+=popup "Shows docs in a giant popup window
nnoremap <silent> K :YcmCompleter GetDoc<cr>
nnoremap <silent> gd :YcmCompleter GoToDefinition<cr>
nnoremap <silent> <F2> :YcmCompleter RefactorRename 
nnoremap <silent> gf :YcmCompleter FixIt<cr>

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Clang format
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
nmap <Leader>C :ClangFormatAutoToggle<CR>
" Autoformatting autodetect
" autocmd FileType c ClangFormatAutoEnable

" Git gutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
