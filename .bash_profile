# Source bash completion scripts.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Include bashrc file (if present).
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Add Homebrew bins to path.
export PATH="/usr/local/sbin:$PATH"

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


