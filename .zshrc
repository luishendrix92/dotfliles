export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Path Additions
# --------------
 export PATH="$PATH:/opt/flutter/bin"

# User Aliases
# ------------
alias vimrc="nvim ~/.config/nvim/"

# bun completions
[ -s "/home/kozmicluis/.bun/_bun" ] && source "/home/kozmicluis/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
