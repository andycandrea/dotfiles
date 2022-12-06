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
set encoding=utf8                   " UTF-8 encoding
set colorcolumn=80                  " Color 80th column

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
highlight ColorColumn ctermbg=6

" Turn off built-in HTML highlighting to get rid of annoying <i> behavior and
" fall back to plugins
let html_no_rendering=1

" Keep plugins in `~/.vimrc.bundles`
if filereadable(expand('~/.vimrc.bundles'))
  source ~/.vimrc.bundles

  " DDC Section
  " Customize global settings
  " Use around source.
  " https://github.com/Shougo/ddc-around
  call ddc#custom#patch_global('sources', ['around'])

  " Use matcher_head and sorter_rank.
  " https://github.com/Shougo/ddc-matcher_head
  " https://github.com/Shougo/ddc-sorter_rank
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank']},
        \ })

  " Change source options
  call ddc#custom#patch_global('sourceOptions', {
        \ 'around': {'mark': 'A'},
        \ })
  call ddc#custom#patch_global('sourceParams', {
        \ 'around': {'maxSize': 500},
        \ })

  " Customize settings on a filetype
  call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
  call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
        \ 'clangd': {'mark': 'C'},
        \ })
  call ddc#custom#patch_filetype('markdown', 'sourceParams', {
        \ 'around': {'maxSize': 100},
        \ })

  " Mappings

  " <TAB>: completion.
  inoremap <silent><expr> <TAB>
  \ ddc#map#pum_visible() ? '<C-n>' :
  \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  \ '<TAB>' : ddc#map#manual_complete()

  " <S-TAB>: completion back.
  inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

  " Use ddc.
  call ddc#enable()

  " End DDC Config
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

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set up Ale linting
let g:ale_linter_aliases = {'vue': ['vue', 'css', 'javascript', 'scss', 'html']}
let g:ale_linters = { 'css': ['csslint'], 'Dockerfile': ['dockerfile_lint'], 'haml': ['hamllint'], 'javascript': ['eslint', 'jslint'], 'markdown': ['write-good'], 'python': ['flake8'], 'ruby': ['rubocop'], 'scss': ['scsslint', 'stylelint'], 'sql': ['sqlint'], 'vue': ['eslint', 'stylelint'] }

let g:ale_lint_delay = 800
let g:ale_set_highlights = 0
let $BUNDLE_GEMFILE = '.overcommit/Gemfile'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_css_stylelint_options = '--config /Users/aandrea/.eslintrc'

" Only load SCSS preprocessor for Vue files (plus JS/HTML/CSS)
let g:vue_pre_processors = ['scss']

" Ignore .pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Don't fold sections in Markdown
let g:vim_markdown_folding_disabled = 1

" Open NERDTree with Ctrl + n
map <C-n> :NERDTreeToggle<CR>
" Open fzf with Ctrl + p
map <C-p> :Files<CR>

" Index ctags from any project, including those outside Rails
map <leader>ct :!/opt/homebrew/bin/ctags --options=/Users/aandrea/.ctags.d/.ctags .<CR>

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
