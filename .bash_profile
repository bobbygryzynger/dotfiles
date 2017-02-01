# Include .bashrc file (if present).
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Get Homebrew's directory prefix.
brew_prefix=$(brew --prefix)

# Source bash completion scripts.
if [ -f ${brew_prefix}/etc/bash_completion ]; then
    . ${brew_prefix}/etc/bash_completion
fi

# Add Homebrew bins to path.
export PATH="${brew_prefix}/sbin:$PATH"

# Set NVM directory and source its script.
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# BLT cli function.
function blt() {
  if [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    GIT_ROOT=$(git rev-parse --show-cdup)
  else
    GIT_ROOT="."
  fi

  if [ -f "$GIT_ROOT/vendor/bin/blt" ]; then
    $GIT_ROOT/vendor/bin/blt "$@"
  else
    echo "You must run this command from within a BLT-generated project repository."
    return 1
  fi
}

# Check if DevDesktop is running.
if [ ! -z "$(pgrep -x "Acquia Dev Desktop")" ];
then
    # If DevDesktop is running, add DevDesktop tools
    # (this includes its versions of php and drush).
    export PATH="$PATH:/Applications/DevDesktop/tools"
else
    # Use DVM (Drush Version Manager).
    export PATH=$PATH:$HOME/.dvm
fi

function toolset () {
    vstr_regex='[^\.0-9]'
    ostr_regex='.*'
    bins=('drush' 'brew' 'node' 'vagrant')
    for bin in "${bins[@]}"; do
        echo "${bin}: "$(${bin} --version | sed -e 1s/${vstr_regex}//g -e 2,\$s/${ostr_regex}//g)
    done
}

