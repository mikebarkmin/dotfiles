call plug#begin('~/.local/share/nvim/plugged')

Plug 'chriskempson/base16-vim'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
