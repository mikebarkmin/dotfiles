# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH:$HOME/Sources/go/bin

# Path to your oh-my-zsh installation.
export ZSH=/home/mbarkmin/.oh-my-zsh
export TERM=xterm

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [ -n "$INSIDE_EMACS" ]; then
    export ZSH_THEME="rawsyntax"
else
    export ZSH_THEME="bira"
fi

# allow tern to load all files
ulimit -n 2048

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  wd
  ssh-agent
  docker
  docker-compose
  pip
  pipenv
  virtualenvwrapper
  yarn
  colored-man-pages
  httpie
  command-not-found
)

source $ZSH/oh-my-zsh.sh

if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi

# Base16
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias uc="uncommitted ~/Sources"
alias vim=nvim
alias senv="set -a; source .env; set +a"
alias com="cd ~/Sources/commoop"
alias s="cd ~/Sources"
alias www='live-server'
alias ping='ping -c 5'
alias ipe='curl ipinfo.io/ip'
alias cuid='python -c "import cuid; print(cuid.CuidGenerator().cuid())" | xsel'

# Docker aliases
alias dps='docker ps'
alias dstop='docker stop $(docker ps -aq)'
alias dkill='docker rm $(docker stop $(docker ps -aq))'
alias ddelete='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'
alias drestartno='docker update --restart=no $(docker ps -a -q)'

# Gnome
# Keybindings
alias keydump='dconf dump /org/gnome/desktop/wm/keybindings/ > ~/.config/keybindings.dconf'
alias keyload='dconf load /org/gnome/desktop/wm/keybindings/ < ~/.config/keybindings.dconf'

export BASE16_SHELL_HOOKS=$HOME/.config/base16-shell/hooks
export BIBINPUTS=$HOME/Sciebo/Zotero.bib

export VIRTUALENV_PYTHON=/usr/bin/python3

# GO
export GOPATH=~/Sources/go

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
