# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

export POSTGRES_USER=andy
export POSTGRES_PASS=
export APP_HOST=localhost

# ensure dotfiles bin directory is loaded first
# export PATH="$HOME/.bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

DYLD_LIBRARY_PATH=/opt/oracle/instantclient_11_2 export DYLD_LIBRARY_PATH
ORACLE_HOME=/opt/oracle/instantclient_11_2 export ORACLE_HOME

RC_ARCHS=x86_64
export RC_ARCHS

# ARCHFLAGS='-arch x86_64'
# export RC_ARCHS
export PATH=$PATH:$DYLD_LIBRARY_PATH

export PATH="/Users/andy/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
