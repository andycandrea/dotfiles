# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of oh-my-zsh theme to load (others in ~/.oh-my-zsh/themes/)
ZSH_THEME='sporty_256'

# Use case-sensitive completion.
CASE_SENSITIVE='true'

# oh-my-zsh plugins
plugins=(bundler git rails)

source $ZSH/oh-my-zsh.sh

set shell=zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/jdk-11/bin:$HOME/.rbenv/bin:$HOME/.pyenv/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -f ~/.aliases ]] && source ~/.aliases
