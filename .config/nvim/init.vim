" Plug {{{
" ----
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'Raimondi/delimitMate'
" This plugin highlights patterns and ranges for Ex commands in Command-line mode.
Plug 'markonm/traces.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/suda.vim'
Plug 'sjl/gundo.vim'
" Highlighting for many languages
Plug 'sheerun/vim-polyglot'

" Themes
Plug 'dracula/vim', {'as': 'dracula'}

" Autocompletion and Snippets
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" R
Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

" Pandoc
Plug 'vim-pandoc/vim-pandoc', { 'for': 'markdown' }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" Latex
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'

" Javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Markdown
Plug 'shime/vim-livedown'

" JSON
Plug 'leshill/vim-json'

" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sodapopcan/vim-twiggy'
Plug 'airblade/vim-gitgutter'

call plug#end()
" }}}

" Global Mappings {{{
" ---------------
let g:mapleader="\<Space>"
let g:maplocalleader=','
nnoremap <leader>th :set hlsearch!<CR>
nnoremap <leader>tf :NERDTreeToggle<CR>
nnoremap <leader>tu :GundoToggle<CR>
nnoremap <leader>tg :Goyo<CR>
nnoremap <leader>fb :Denite buffer<CR>
nnoremap <leader>fo :Denite outline<CR>
nnoremap <leader>ff :DeniteProjectDir -buffer-name=files -direction=top file_rec<CR>
nnoremap <leader>fg :DeniteProjectDir -buffer-name=git -direction=top file_rec/git<CR>
nnoremap <leader>fa :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
noremap <silent> <Leader>w :call ToggleWrap()<CR>

function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    noremap  <buffer> <silent> k gk
    noremap  <buffer> <silent> j gj
    noremap  <buffer> <silent> 0 g0
    noremap  <buffer> <silent> $ g$
  endif
endfunction

" folding
nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
nnoremap <expr> <f3> 'za'

" quickfix
map <C-j> :cn<CR>
map <C-k> :cp<CR>
map <leader>ch :noh<CR>

" }}}

" General Settings {{{
" -----------------------------------------------------------------------------
" General {{{
" -------

set errorbells
set visualbell
set synmaxcol=1000
set splitbelow
set splitright
"
" autoread and autowrite
set hidden
set nobackup
set noswapfile
set nowritebackup
set autoread

" persistent-undo
set undodir=~/.config/nvim/undo
set undofile

"
" highlight merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Spell Check
let b:myLang=0
let g:myLangList=["nospell","de_de","en_gb"]
function! ToggleSpell()
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

set complete+=kspell

nmap <silent> <F7> :call ToggleSpell()<CR>


" autocd to current dir of file
set autochdir

function PrintFile(fname)
   call system("gtklp " . a:fname)
   call delete(a:fname)
   return v:shell_error
endfunction
set printexpr=PrintFile(v:fname_in)
let g:sudo_askpass='/usr/lib/openssh/gnome-ssh-askpass'

set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" }}}
" Tabs and Indents {{{
" ----------------
set textwidth=0
set wrapmargin=0
set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set autoindent
set smartindent
set shiftround
set expandtab

" }}} Searching {{{
" ---------
set ignorecase
set smartcase
set hlsearch

" }}}
" UI {{{
" --
set scrolloff=2
set sidescrolloff=5
set number relativenumber
set list
set laststatus=2
set colorcolumn=80
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

let g:dracula_colorterm = 0
set background=dark
color dracula
" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark="soft"

" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif


" }}}
" Folding {{{
if has('folding')
  set foldenable
  set foldmethod=syntax
  set foldlevelstart=99
  set foldtext=FoldText()
endif

" Improved Vim fold-text
" See: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! FoldText()
  " Get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = ' ' . foldSize . ' lines '
  let foldLevelStr = repeat('+--', v:foldlevel)
  let lineCount = line('$')
  let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
  let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
" }}}
" }}}

" Plugins {{{
" -------
" suda {{{
let g:suda_smart_edit = 1
" }}}
" vim-jsx {{{
let g:jsx_ext_required = 0
" }}}
" Denite {{{
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
" -u flag to unrestrict (see ag docs)
call denite#custom#var('file_rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#source(
\ 'grep', 'matchers', ['matcher_regexp'])

" use ag for content search
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
    \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" }}}
" Ale {{{
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 1 " Less distracting when opening a new file
let g:ale_set_highlights = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_javascript_tsserver_use_global = 1
set completeopt=menu,menuone,preview,noselect,noinsert
hi ALEErrorSign ctermfg=Red
hi ALEError ctermbg=Black ctermfg=Red
hi ALEWarning ctermbg=Yellow ctermfg=Black
hi ALEInfo ctermbg=Cyan ctermfg=Black
" hi ALEErrorLine ctermbg=Black ctermfg=Red

nnoremap <silent> gi :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['autopep8', 'isort', 'yapf'],
\   '*': ['trim_whitespace']
\}

let g:ale_linters = {
\   'javascript': ['tsserver', 'eslint'],
\   'python': ['flake8', 'pyls']
\}

let g:ale_javascript_prettier_options = '--single-quote'

" }}}
" Vimtex {{{

let g:polyglot_disabled = ['latex']
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_latexmk = {
        \ 'background' : 1,
        \ 'build_dir' : 'build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk'
        \}

" }}}
" Twiggy {{{
command Gbranch :Twiggy

" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 foldlevel=0 tw=80 :
