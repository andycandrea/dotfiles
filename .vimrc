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

" CtrlP replacement - requires fzf installed via Homebrew and the vim Plug
" loader
" call plug#begin('~/.vim/plugged')
" Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" call plug#end()

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

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword += -

  " Remove trailing whitespace on write
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Exclude JavaScript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd = "ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Configure Syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open = 1

" Ignore inconsequential errors
let g:syntastic_html_tidy_ignore_errors = [' proprietary attribute "ng-']
let g:syntastic_eruby_ruby_quiet_messages = { 'regex': 'possibly useless use of a variable in void context' }

" Set up Syntastic linting
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint']

" Prevent polyglot from overwriting preferred RSpec highlighting
let g:polyglot_disabled = ['rspec']

" Don't fold sections in Markdown
let g:vim_markdown_folding_disabled = 1

" Open NERDTree with Ctrl + n
map <C-n> :NERDTreeToggle<CR>
" Open fzf with Ctrl + p
map <C-p> :Files<CR>
" Open buffers with Ctrl + b
map <C-b> :Buffers<CR>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" vim-test mappings
nnoremap <Leader>t :TestFile<CR>
nnoremap <Leader>l :TestLast<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Get off my lawn
nnoremap <Left> :echoe 'Use h'<CR>
nnoremap <Right> :echoe 'Use l'<CR>
nnoremap <Up> :echoe 'Use k'<CR>
nnoremap <Down> :echoe 'Use j'<CR>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif
