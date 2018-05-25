" Plug {{{
" ----
call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'Shougo/denite.nvim'
Plug 'mattn/emmet-vim'

" Autocompletion and Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" R
Plug 'jalvesaq/Nvim-R'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Latex
Plug 'lervag/vimtex'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Spellchecking
Plug 'rhysd/vim-grammarous'
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-wordy'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()
" }}}

" Global Mappings {{{
" ---------------
let g:mapleader="\<Space>"
let g:maplocalleader=';'
nnoremap <leader>th :set hlsearch!<CR>
nnoremap <leader>tf :NERDTreeToggle<CR>

" }}}

" General Settings {{{
" -----------------------------------------------------------------------------
" General {{{
" -------

set errorbells
set visualbell
set synmaxcol=1000
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1 
let g:deoplete#enable_smart_case = 1 

" }}}
" Vim Directories {{{
" ---------------

" }}}
" Tabs and Indents {{{
" ----------------
set textwidth=80
set tabstop=2
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
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


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
" Emmet {{{
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \ 'javascript.jsx' : {
    \ 'extends' : 'jsx',
  \ },
\}
" }}}
" Ale {{{
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" }}}
" Neosnippet {{{

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 foldlevel=0 tw=80 :
"
