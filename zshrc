# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of oh-my-zsh theme to load (others in ~/.oh-my-zsh/themes/)
ZSH_THEME='sporty_256'

# Use case-sensitive completion.
CASE_SENSITIVE='true'

# oh-my-zsh plugins
plugins=(battery bundler git rails)

source $ZSH/oh-my-zsh.sh

set shell=zsh

export PATH="$HOME/.rbenv/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export PATH="$HOME/.pyenv/shims:$PATH"
