# PS1
PS1="%1~ # " 

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/usr/local/bin/brewx86_64 shellenv)"

# java
export JAVA_HOME=$(/usr/libexec/java_home)

# nvm
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# utils
export UTILS_DIR="$HOME/.utils"
export PATH="$UTILS_DIR:$PATH"
