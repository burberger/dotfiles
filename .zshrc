# Path to your oh-my-zsh installation.
export ZSH=/home/bob/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

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
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
plugins=(git debian zsh-syntax-highlighting)

# User configuration
stty -ixon

# Allow completion of aliases
setopt COMPLETE_ALIASES

export MAKEFLAGS=-j13
#export MANPAGER="vim -c MANPAGER -"

# Golang stuff
export GOPATH=$HOME/src/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin:$HOME/local/bin:$HOME/.cargo/bin:$HOME/.local/bin

# Default editor
export EDITOR=vim

source $ZSH/oh-my-zsh.sh

# NS3 stuff
# {{{
export NS3DIR=$HOME/src/netsim/ns-allinone-3.28/ns-3.28

fpath+=~/.zfunc

function waff {
    CWD="$PWD"
    cd $NS3DIR >/dev/null
    ./waf --cwd="$CWD" $*
    cd - >/dev/null
}
# }}}

# Utility Aliases
alias http="python -m SimpleHTTPServer"
alias ls=exa
alias lg="ll --git"

# Moose docker stuff
alias menv="docker run -it -v '$(pwd)':/app -w /app moose:1"
alias mbash="docker run -it -v $PWD:/app -w /app moose:1 /bin/bash"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
