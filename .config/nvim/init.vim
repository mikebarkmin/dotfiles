" Plug {{{
" ----
call plug#begin('~/.local/share/nvim/plugged')

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot'

" S for replacing case sensitive
Plug 'tpope/vim-abolish'

Plug 'honza/vim-snippets'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'Yggdroot/indentLine'
" This plugin highlights patterns and ranges for Ex commands in Command-line mode.
Plug 'markonm/traces.vim'
Plug 'luochen1990/rainbow'
Plug 'lambdalisue/suda.vim'
Plug 'sjl/gundo.vim'

" Themes
Plug 'dracula/vim', {'as': 'dracula'}

" R
Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

" Latex
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'

" Javascript
Plug 'neoclide/vim-jsx-improve'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Racket
Plug 'wlangstroth/vim-racket'

" Clojure
Plug 'eraserhd/parinfer-rust'
Plug 'tpope/vim-fireplace'

" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sodapopcan/vim-twiggy'
Plug 'airblade/vim-gitgutter'

" Spellchecking
Plug 'rhysd/vim-grammarous'

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
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fm :Marks<CR>
" nnoremap <leader>fa :Ag<CR>
noremap <silent> <Leader>w :call ToggleWrap()<CR>
nnoremap <leader>ev :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim <bar> :doautocmd BufRead<CR>
tnoremap <Esc> <C-\><C-n>

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

nnoremap <leader>fa :GGrep<CR>

function! ToggleWrap()
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
set mouse=a
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
" let b:myLang=0
" let g:myLangList=["nospell","de_de","en_gb"]
" 
" function! ToggleSpell()
"   let b:myLang=b:myLang+1
"   if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
"   if b:myLang==0
"     setlocal nospell
"   else
"     execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
"   endif
"   echo "spell checking language:" g:myLangList[b:myLang]
" endfunction
" 
" set complete+=kspell


" autocd to current dir of file
set autochdir

function! PrintFile(fname)
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

let g:rainbow_active = 1
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
" Abbreviations {{{
ab sus Schülerinnen und Schüler
ab lul Lehrerinnen und Lehrer
" }}}
" }}}

" Plugins {{{
" -------
" terraform {{{
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" }}}
" coc {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
set statusline^=%{coc#status()}

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap for format selected region
xmap <leader><F2>  <Plug>(coc-format-selected)
nmap <leader><F2>  <Plug>(coc-format-selected)

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}
" suda {{{
let g:suda_smart_edit = 1
" }}}
" Vimtex {{{

let g:vimtex_view_method = 'zathura'
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
command! Gbranch :Twiggy

" }}}
" Markdown {{{
let g:mkdp_auto_start=0
" }}}
" Grammarous {{{
let g:grammarous#languagetool_cmd = 'languagetool'
nmap <leader>gp <Plug>(grammarous-move-to-previous-error)
nmap <leader>gn <Plug>(grammarous-move-to-next-error)
nmap <leader>gm <Plug>(grammarous-move-to-info-window)
nmap <leader>go <Plug>(grammarous-open-info-window)
nmap <leader>gc <Plug>(grammarous-close-info-window)
nmap <leader>gf <Plug>(grammarous-fixit)
nmap <leader>gr <Plug>(grammarous-remove-error)
nmap <silent> <leader>gsd :GrammarousCheck --lang=de<CR>
nmap <silent> <leader>gse :GrammarousCheck --lang=en<CR>
nmap <leader>gq <Plug>(grammarous-reset)
" }}}
" polyglot {{{
let g:polyglot_disabled = ['latex']
" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 foldlevel=0 tw=80 :
