# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Things not to keep in git
[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

# Use ripgrep for fzf for performance
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export RC_ARCHS=x86_64

export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
