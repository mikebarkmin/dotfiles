" Plug {{{
" ----
call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'Shougo/denite.nvim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'markonm/traces.vim'

" Autocompletion and Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" R
Plug 'jalvesaq/Nvim-R', { 'for': 'r' }

" Pandoc
Plug 'vim-pandoc/vim-pandoc', { 'for': 'markdown' }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" Latex
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'

" Javascript
Plug 'mklabs/mdn.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" JSON
Plug 'leshill/vim-json'

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
let g:maplocalleader=','
nnoremap <leader>th :set hlsearch!<CR>
nnoremap <leader>tf :NERDTreeToggle<CR>
nnoremap <leader>fb :Denite buffer<CR>
nnoremap <leader>ff :DeniteProjectDir -buffer-name=files -direction=top file_rec<CR>
nnoremap <leader>fg :DeniteProjectDir -buffer-name=git -direction=top file_rec/git<CR>
nnoremap <leader>fa :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

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

" autocd to current dir of file
set autochdir

" }}}
" Vim Directories {{{
" ---------------

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
" Autocompletion {{
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1 
let g:deoplete#enable_smart_case = 1 
if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
  endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" }}
" }}}

" Plugins {{{
" -------
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
let g:ale_lint_on_enter = 1 " Less distracting when opening a new file
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['autopep8', 'isort', 'yapf']
\}

let g:ale_javascript_prettier_options = '--single-quote'

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
" Vimtext {{{

let g:vimtex_compiler_progname = 'nvr'
au BufRead,BufNewFile *.text let &l:flp = '^\s*\\\(end\|item\)\>'

" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 foldlevel=0 tw=80 :
"
