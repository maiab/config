"------  Visual Options  ------"

syntax enable                       " enable syntax highlighting
set number                          " enable line numbers
set nowrap                          " disable word wrap
set vb                              " visual bell
set showmatch                       " show matching bracket

set laststatus=2                    " always use a status line

"------  Behavior  ------"

set backspace=indent,eol,start      " normal backspace behavior
set history=1000                    " 1000 item history
set undolevels=1000                 " 1000 item undo buffer
let mapleader=","                   " set leader to ,
set title                           " update the terminals title
set tabstop=4                       " tab = 4 spaces
set shiftwidth=4                    " indent to 4 spaces
set softtabstop=4                   " Number of spaces that a <Tab> counts for
set expandtab                       " use spaces instead of tabs
set autoindent                      " auto indent
set smartindent                     " use vim smart indenting

" Ignore these files when completing names
set wildignore+=.svn,CVS,.git,*.o,*.a,*.class,*.mo
set wildignore+=*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set wildignore+=*/tmp/*,*.zip,*.pyc

set iskeyword+=_,$,@,%,#

set wildmode=longest,list:longest   " Shell style tab completion

filetype indent on
filetype plugin on

set encoding=utf-8

"------  Searching  ------"

set incsearch                       " Search while typing
set ignorecase                      " Case insensitive searching
set smartcase                       " lowercase = case insensitive, any uppercase = case sensitive
set hlsearch                        " highlight all search results

" following line clears the search highlights when pressing <Leader>s
nnoremap <Leader>s :nohlsearch<CR>

set grepprg=grep\ -nH\ $*           " set grep to always display a file name

"------  Buffers  ------"

" switch between unsaved buffers w/o needing to save
set hidden

"------  Windows  ------"

" Move easily between windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Keybindings for splitting windows
noremap <Leader>v :split<CR>
noremap <Leader>V :vsplit<CR>

"------  Text Width Stuff  ------"

set tw=80
set fo-=c
set fo-=t
set modeline
set modelines=3
set sr
set whichwrap=h,l,~,[,]

"------  Helpful keybindings  ------"

" ,T = Delete all Trailing space in file
map <Leader>T :%s/\s\+$//<CR>

" Sometimes you just need to teach vim whose boss
noremap <Leader>r :redraw!<CR>

" I make the mistake of typing W and Q instead of w and q
nmap :W :w
nmap :Q :q

" Kill the evil EX mode
nmap Q <Nop>

"------  Set custom colorscheme stuff  ------"

set background=dark
colorscheme solarized

"------  Vim Config Stuff  ------"

" Set swp files to go to a central location
set backupdir=$HOME/.config/nvim/swp//,/tmp//,.
set directory=$HOME/.config/nvim/swp//,/tmp//,.

" Share clipboard
set clipboard+=unnamedplus

" Better tab-completion
set wildmenu

"------  Safe crontab  ------"
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

"------  Filetype tweaks  ------"
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"------  Python Stuff  ------"
let g:python_highlight_all=1

"------  Whitespace  ------"

" Show trailing whitespace
set list

" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

"------  Visual Mode related  ------"

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>

"------  Persistent undo  ------"

set undodir=$HOME/.config/nvim/undo/
set undoreload=10000
set undofile

"------  Buffer management  ------"
nnoremap <silent> <leader>d :bdelete<CR>

"------  Tab management  ------"
nnoremap <silent> \[ :tabp<CR>
nnoremap <silent> \] :tabn<CR>

nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> td :tabclose<CR>
nnoremap <silent> tt :tabedit %<CR>

"------  Terminal Mode  ------"
let g:terminal_scrollback_buffer_size = 100000

autocmd WinEnter term://* startinsert

tnoremap <Esc><Esc> <C-\><C-n>

tnoremap <C-J> <C-\><C-n><C-W>j
tnoremap <C-K> <C-\><C-n><C-W>k
tnoremap <C-H> <C-\><C-n><C-W>h
tnoremap <C-L> <C-\><C-n><C-W>l

nnoremap <leader>z :split \| terminal <CR>
nnoremap <leader>Z :vsplit \| terminal <CR>

"====================================="
"======  PLUGINS CONFIGURATION ======="
"====================================="

"------  Deoplete ------"

set completeopt-=preview
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=menuone
set completeopt+=longest

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#mappings#manual_complete())

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~? '\s'
endfunction

"------  Vim Airline ------"
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0

"------  NERDTree Options  ------"

let NERDTreeIgnore=['\.git$', '\.pyc$', '__pycache__']

" following line finds the current file in NERDTree when pressing <Leader>a
noremap <leader>a :NERDTreeFind<C-M>

" quit vim if NERDTree is last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"------  TagBar Options  ------"
"
noremap <leader>A :TagbarToggle<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"------  EasyTags Options  ------"
set cpoptions+=d
set tags=./.ctags
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
let g:easytags_suppress_report = 1
let g:easytags_async = 1

let g:easytags_languages = {
\   'go': {
\     'cmd': 'gotags',
\     'args': ['-sort -silent']
\   }
\}

"------  Ctrl-p  ------"
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ["tag"]
let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_use_caching = 0

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>B :CtrlPTag<CR>

"------  GitGutter  ------"
highlight clear SignColumn

"------  jedi-vim  ------"
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
let g:jedi#goto_assignments_command = "<leader>D"

" Kill these keybindings
let g:jedi#rename_command = ""

"------  NeoMake  ------"

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_haskell_enabled_makers = ['ghc_mod']
let g:neomake_go_enabled_makers = ['golint', 'govet']
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake

nmap <Leader><Leader> :lopen<CR>

"------  necoghc  ------"

let g:necoghc_enable_detailed_browse = 1

"------  Grepper  ------"
let g:grepper = {
    \ 'tools': ['sift', 'git', 'grep'],
    \ 'open':  0,
    \ 'jump':  1,
    \ }

nmap <leader>g :Grepper -tool sift -nojump -open -switch<CR>
nmap <leader>G :Grepper -tool sift -nojump -open -switch -cword -noprompt<CR>

"------  JSX  ------"
let g:jsx_ext_required = 0

"------ Go ------"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap gb <Plug>(go-doc-browser)
au FileType go nmap gi <Plug>(go-info)

"------  Undo Tree  ------"

nnoremap <silent> <leader>u :UndotreeToggle<CR>

let g:undotree_SetFocusWhenToggle = 1

"------  Multiple Cursors  ------"

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction