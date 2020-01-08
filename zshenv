# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# For RDKit
export RDBASE=/usr/local/share/RDKit

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Things not to keep in git
[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

# Use ripgrep for fzf for performance
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export RC_ARCHS=x86_64

export PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin:/Users/andy/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/usr/local/ncbi/blast/bin:$PATH"
export CHROME_HEADLESS_BINARY="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
