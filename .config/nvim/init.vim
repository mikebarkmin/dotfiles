" Plug {{{
" ----
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go',  {'do': ':GoUpdateBinaries' }

Plug 'honza/vim-snippets'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Yggdroot/indentLine'
" This plugin highlights patterns and ranges for Ex commands in Command-line mode.
Plug 'markonm/traces.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/suda.vim'
Plug 'sjl/gundo.vim'

" Themes
Plug 'dracula/vim', {'as': 'dracula'}

" Autocompletion and Snippets
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" R
Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

" Latex
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'

" Javascript
Plug 'neoclide/vim-jsx-improve'

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
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fa :Ag<CR>
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

" }}}
" Searching {{{
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
set conceallevel=0

let g:dracula_colorterm = 0
set background=dark
color dracula

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
" indentLine {{{
" let g:indentLine_setColors = 0
" }}}
" coc {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
set statusline^=%{coc#status()}

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}
" suda {{{
let g:suda_smart_edit = 1
" }}}
" Vimtex {{{

let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_bib = {
      \ 'simple': 1,
      \ 'recursive': 1,
      \}
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
