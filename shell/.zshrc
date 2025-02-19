### Default .ZSHRC file
### Owner: Alessandro Petrocino
### Last modification: 2025-02-17
###



### -----------------------------------------------------------------------------------------------------###
### MAIN CONFIG
## Used on any system

# Dotfiles dir
# Change if needed, based on git downloaded dir
DOTFILES_DIR="$HOME/dotfiles"
export DOTFILES_DIR

### DEFAULT PATH - Added default scripts folder (versioned) and the Python binary path
PATH=$PATH:$HOME/scripts:$HOME/Library/Python/3.9/bin

### DEFAULT XDG_CONFIG_HOME var
XDG_CONFIG_HOME=$DOTFILES_DIR/.config
### -----------------------------------------------------------------------------------------------------###


### DEFAULT TERM CONFIGURATION---------------------------------------------------------------------------###
## XTERM
TERM="xterm-256color"
export TERM

### iTerm config - What this does?
test -e "$DOTFILES_DIR/iterm/.iterm2_shell_integration.zsh" && source "$DOTFILES_DIR/iterm/.iterm2_shell_integration.zsh"
### -----------------------------------------------------------------------------------------------------###


### -----------------------------------------------------------------------------------------------------###
### ZSH PowerLevel10K config
### -------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=powerlevel10k/powerlevel10k
source $HOME/powerlevel10k/powerlevel10k.zsh-theme

## Plugins section
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
### -----------------------------------------------------------------------------------------------------###


### -----------------------------------------------------------------------------------------------------###
### POMODORO-CLI CONFIG
# This uses the 'timer' application, from brew repository.
work() {
  # usage: work 10m, work 60s etc. Default is 20m
  timer "${1:-25m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal
}

rest() {
  # usage: rest 10m, rest 60s etc. Default is 5m
  timer "${1:-5m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal
}
### -----------------------------------------------------------------------------------------------------###


### -----------------------------------------------------------------------------------------------------###
### GIT Global stuff
## Here, resides useful global vars for git
GITSTATUS_LOG_LEVEL=DEBUG
export GIT_PYTHON_REFRESH=quiet
### -----------------------------------------------------------------------------------------------------###


### -----------------------------------------------------------------------------------------------------###
### COWSAY Variables - First, at my scripts folder. Then, at default location of cowsay from brew install
COWPATH=$HOME/scripts/cowfiles:/usr/local/Cellar/cowsay/3.04_1/share/cows
### -----------------------------------------------------------------------------------------------------###


### -----------------------------------------------------------------------------------------------------###
### Source Global aliases
# Include alias file (if present) containing aliases for ssh, etc.
if [ -f $HOME/.aliases ]
then
  source $HOME/.aliases
fi

### Source NASCO aliases
# Include NASCO alias file (if present)
if [ -f $HOME/.aliases.NASCO ]
then
  source $HOME/.aliases.NASCO
fi
### -----------------------------------------------------------------------------------------------------###

# Just fun
#if [[ -t 1 ]]; then
#    echo -e "$(cat /Users/petrocin/scripts/linux/motd_templates/skynet_logo.txt)"
#fi