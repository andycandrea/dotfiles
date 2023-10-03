" Place in ~/.config/nvim/init.vim along with coc-settings.json

" Leader
let mapleader = ' '

filetype plugin indent on

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

" Numbers
set number
set numberwidth=5

" General preferences
set undofile
set nobackup
set nowritebackup
set noswapfile
set autowrite                       " Automatically :write before running commands
set lazyredraw                      " Only redraw screen when necessary
set diffopt+=vertical               " Always use vertical diffs
set wildmode=list:longest,list:full " Show all matching options for file completion
set list listchars=tab:»·,trail:·   " Display extra whitespace
set wrap                            " Wrap lines that go beyond the edge of the screen
set clipboard=unnamed               " Yank to clipboard
set colorcolumn=80                  " Color 80th column
set updatetime=300                  " Reduce delay

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Resize panes when window size changes
autocmd VimResized * :wincmd =

" Color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
highlight ColorColumn ctermbg=6

" Turn off built-in HTML highlighting to get rid of annoying <i> behavior and
" fall back to plugins
let html_no_rendering=1

" Keep plugins in `~/.nvimrc.bundles`
if filereadable(expand('~/.nvimrc.bundles'))
  source ~/.nvimrc.bundles
endif

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

" Tab complete with coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "<CR>"


" Go to code definition
nmap <silent> gf <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Ruby indentation settings
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_block_style = 'do'

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
