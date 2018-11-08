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
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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

" Markdown
Plug 'shime/vim-livedown'

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
noremap <silent> <Leader>w :call ToggleWrap()<CR>
" force write with sude
cnoremap w!! w !sudo tee "%" > /dev/null
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
set hidden

" autocd to current dir of file
set autochdir

function PrintFile(fname)
   call system("gtklp " . a:fname)
   call delete(a:fname)
   return v:shell_error
endfunction
set printexpr=PrintFile(v:fname_in)
let g:sudo_askpass='/usr/lib/openssh/gnome-ssh-askpass'

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
" Autocompletion {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1 
let g:deoplete#enable_smart_case = 1 
if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
  endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" }}}
" }}}

" Plugins {{{
" -------
" LanguageClient {{{
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {}

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

if executable('pyls')
  let g:LanguageClient_serverCommands.python = ['pyls']
endif

if executable('jdtls')
  let g:LanguageClient_serverCommands.java = ['jdtls']
endif

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands.html = ['html-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.less = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.json = ['json-languageserver', '--stdio']
endif

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
let g:ale_lint_on_enter = 1 " Less distracting when opening a new file
let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1
hi ALEErrorSign ctermfg=Red
hi ALEError ctermbg=Red ctermfg=Black
hi ALEWarning ctermbg=Yellow ctermfg=Black
hi ALEInfo ctermbg=Cyan ctermfg=Black

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
" Vimtex {{{

let g:vimtex_compiler_progname = 'nvr'
let g:tex_conceal = ''
au BufRead,BufNewFile *.tex let &l:flp = '^\s*\\\(end\|item\)\>'
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : 'build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '--shell-escape',
        \ ],
        \}

" }}}
" }}}

" FileType Settings {{{
function! MyFormatExpr(start, end)
    silent execute a:start.','.a:end.'s/\(\<vgl\|e\.g\|\<al\)\@<![.!?]\zs /\r/g'
endfunction

autocmd FileType tex set formatexpr=MyFormatExpr(v:lnum,v:lnum+v:count-1)
" }}}

" vim: set foldmethod=marker ts=2 sw=2 foldlevel=0 tw=80 :
"
