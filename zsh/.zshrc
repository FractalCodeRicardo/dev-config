
# Enable command completion
autoload -Uz compinit
compinit

# Better completion behavior
setopt AUTO_MENU
setopt MENU_COMPLETE
setopt COMPLETE_IN_WORD


# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Prompt (simple)
PROMPT='last-hope:%~ '

# Enable colors
autoload -U colors && colors
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
. "$HOME/.cargo/env"
