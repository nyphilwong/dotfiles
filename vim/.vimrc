" Vim Settings
" === Simple, plugin-free, editor-like Vim ===

" Basics
set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax on

" UI
set number relativenumber
set cursorline
set signcolumn=yes
set showtabline=2
set laststatus=2          " show a statusline for each window
set noshowmode            " don't show -- INSERT -- (statusline covers it)
if has('termguicolors') | set termguicolors | endif
"colorscheme desert        " built-in scheme; change to taste
set scrolloff=6 sidescrolloff=6
set wrap linebreak breakindent

" Search
set ignorecase smartcase
set incsearch hlsearch
nnoremap <Esc> :nohlsearch<CR>

" Editing
set expandtab shiftwidth=4 tabstop=4 softtabstop=4
set smartindent
set completeopt=menuone,noselect
set mouse=a
set splitright splitbelow
set updatetime=300
set pumheight=12

" Safer undo (no external tools)
set undofile
if has('persistent_undo')
  let &undodir = expand('~/.vim/undo')
  if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
endif

" System clipboard if available (no install needed if Vim supports it)
if has('clipboard')
  set clipboard^=unnamedplus
endif

" Better command-line completion and project-wide :find
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set path+=**                               " let :find search recursively
set wildignore+=node_modules/**,dist/**,build/**,.git/**,.venv/**,*.o,*.class
set suffixesadd+=.ts,.tsx,.js,.jsx,.py,.go,.lua,.rs,.java,.c,.cpp,.h,.hpp

" Built-in file explorer (netrw) as a tree
let g:netrw_banner = 0
let g:netrw_winsize = 30
let g:netrw_liststyle = 3                 " tree view
nnoremap <leader>e :Lexplore<CR>

" Minimal but useful statusline (built-in)
set statusline=%f\ %m%r%h%w%=%y\ [%{&ff}]\
set statusline+=\ %l/%L\ :%c\ %p%%

" Leader
let mapleader = ' '

" Save/Quit
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>a
nnoremap <C-q> :quit<CR>

" Buffer & tab navigation
nnoremap <Tab>     :bnext<CR>
nnoremap <S-Tab>   :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :ls<CR>:b<Space>
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>

" Split movement & resize
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <A-Left>  :vertical resize -4<CR>
nnoremap <A-Right> :vertical resize +4<CR>
nnoremap <A-Up>    :resize -2<CR>
nnoremap <A-Down>  :resize +2<CR>

" Open files quickly (built-in "fuzzy-ish" via :find + wildmenu)
" Type <Space> p then start typing a filename; use <Tab> to complete.
nnoremap <leader>p :find 

" Project search with built-in :vimgrep (no external ripgrep/grep required)
" <Space> / prompts; <Space> g searches word under cursor.
nnoremap <leader>/ :vimgrep //gj **/*<Left><Left><Left><Left><Left>
nnoremap <leader>g :vimgrep /<C-r><C-w>/gj **/* \| copen<CR>
nnoremap <leader>qq :cclose<CR>

" Toggle wrap & spell (built-in)
nnoremap <leader>tw :set wrap!<CR>
nnoremap <leader>ts :setlocal spell!<CR>

" Built-in omni completion (Ctrl-x Ctrl-o in Insert)
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete

" Nicer movement on wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

