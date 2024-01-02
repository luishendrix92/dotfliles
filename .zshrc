# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
DISABLE_UNTRACKED_FILES_DIRTY="true"

# User Aliases
# ------------
alias vimrc="nvim ~/.config/nvim/"

# opam configuration
test -r /home/kozmicluis/.opam/opam-init/init.sh && . /home/kozmicluis/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Haskell GHCUP environment
[ -f "/home/kozmicluis/.ghcup/env" ] && source "/home/kozmicluis/.ghcup/env" # ghcup-env

# Path Additions
# --------------
export PATH="$PATH:/opt/flutter/bin"
export PATH=~/.local/bin/:$PATH
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools/
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/
