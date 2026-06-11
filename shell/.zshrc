### Default .ZSHRC file
### Owner: Alessandro Petrocino
### Last modification: 2026-06-11
###

### -----------------------------------------------------------------------------------------------------###
# MAIN CONFIG (Used on any system)

# Dotfiles dir
# Change if needed, based on git downloaded dir
DOTFILES_DIR="$HOME/dotfiles"
export DOTFILES_DIR

### DEFAULT PATH - Added default scripts folder (versioned)
PATH=$PATH:$HOME/scripts

### DEFAULT XDG_CONFIG_HOME var
XDG_CONFIG_HOME=$DOTFILES_DIR/.config

### Shell behavior
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT # sort file10 after file9, not after file1
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
# HISTORY CONFIG

HISTFILE="~/.zsh_history"
HISTSIZE="100000"
SAVEHIST="100000"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
# DEFAULT TERM CONFIGURATION
TERM="xterm-256color"
export TERM

### iTerm config - What this does?
test -e "$DOTFILES_DIR/iterm/.iterm2_shell_integration.zsh" && source "$DOTFILES_DIR/iterm/.iterm2_shell_integration.zsh"
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
# STARSHIP CONFIG
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
### ZSH Plugins - Installed via brew (macOS)
### -----------------------------------------------------------------------------------------------------###

# ZSH Auto-suggestion plugin
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH Highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
# FZF Config
source <(fzf --zsh)

#Aliases specific for fzf
alias fzcat="fzf --preview='bat --color=always {}'"
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
# GIT Global stuff
## Here, resides useful global vars for git
GITSTATUS_LOG_LEVEL=DEBUG
export GIT_PYTHON_REFRESH=quiet
### -----------------------------------------------------------------------------------------------------###



### -----------------------------------------------------------------------------------------------------###
### Source Global aliases
# Include alias file (if present) containing aliases for ssh, etc.
if [ -f $HOME/.aliases ]
then
  source $HOME/.aliases
fi
### -----------------------------------------------------------------------------------------------------###



#EOF
