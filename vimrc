" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

set background=dark

" Leader
let mapleader = ' '

filetype plugin indent on

" Set undo file to allow undoing even after closing and reopening vim
silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
set undofile
set undodir=~/.vim/undo

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Softtabs, 2 spaces
set softtabstop=2
set tabstop=2
set shiftwidth=2
set shiftround  " Indent to the next column that's a multiple of shiftwidth
set expandtab
set backspace=2 " Backspace deletes like most programs in insert mode
set smarttab

" Numbers
set number
set numberwidth=5

" General preferences
set nobackup
set nowritebackup
set noswapfile
set history=50                      " Keep 50 entries in history tables
set ruler                           " Show the cursor position at all times
set showcmd                         " Display incomplete commands
set incsearch                       " Incremental searching
set laststatus=2                    " Always display the status line
set autowrite                       " Automatically :write before running commands
set lazyredraw                      " Only redraw screen when necessary
set diffopt+=vertical               " Always use vertical diffs
set wildmode=list:longest,list:full " Show all matching options for file completion
set list listchars=tab:»·,trail:·   " Display extra whitespace
set wrap                            " Wrap lines that go beyond the edge of the screen
set clipboard=unnamed               " Yank to clipboard

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Resize panes when window size changes
autocmd VimResized * :wincmd =

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has('gui_running')) && !exists('syntax_on')
  syntax enable
endif

" Color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Keep plugins in `~/.vimrc.bundles`
if filereadable(expand('~/.vimrc.bundles'))
  source ~/.vimrc.bundles
endif

" Tab completion
" Will insert tab at beginning of line,
" Will use completion if not at beginning
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line('$') |
    \   exe "normal g`\"" |
    \ endif

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown, text
  autocmd BufRead,BufNewFile *.md,*.txt setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Remove trailing whitespace on write
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Close vim if the only remaining split is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use RipGrep
if executable('rg')
  " Use Rg over Grep
  set grepprg="rg --vimgrep --smart-case --sort-files"
  let g:ackprg = "rg --vimgrep --smart-case --sort-files"
endif

" Exclude JavaScript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd = "ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set up Ale linting
let g:ale_linters = { 'Dockerfile': ['dockerfile_lint'], 'erb': ['ruumba'], 'javascript': ['eslint'], 'markdown': ['write-good'], 'python': ['pylint', 'flake8'], 'ruby': ['debride', 'rubocop'], 'scss': ['stylelint'], 'sql': ['sqlint'] }
let g:ale_ruby_debride_options = "--rails"
let g:ale_lint_delay = 800
let g:ale_set_highlights = 0

" Ignore .pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Don't fold sections in Markdown
let g:vim_markdown_folding_disabled = 1

" Open NERDTree with Ctrl + n
map <C-n> :NERDTreeToggle<CR>
" Open fzf with Ctrl + p
map <C-p> :Files<CR>

" Index ctags from any project, including those outside Rails
map <leader>ct :!/usr/local/bin/ctags -R .<CR>

" vim-test mappings
nnoremap <leader>t :TestFile<CR>
nnoremap <leader>l :TestLast<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif
