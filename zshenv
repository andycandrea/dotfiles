# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

export POSTGRES_USER=andy
export POSTGRES_PASS=
export APP_HOST=localhost

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# For RDKit
export RDBASE=/usr/local/share/RDKit

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

export RC_ARCHS=x86_64

export PATH="/Users/andy/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
