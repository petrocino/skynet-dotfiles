## Personal .bashrc file
# Used for corporative environments with bash on it.
# Author: Alessandro Petrocino
# v. 0.1
# Date: 2025-02-21

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Avoid disconnection on timeouts
TMOUT=0

# Define colors
YELLOW="\[\e[33m\]"
DARK_RED_BG="\[\e[48;5;88m\]"  # Darker red background
WHITE="\[\e[97m\]"  # Bright white text for better contrast
RESET="\[\e[0m\]"

# Define critical servers
CRITICAL_SERVERS=("nastsm01" "nasvmrhibmcb02" "nasftp1" "nasftp2")  

# Get the hostname and define the variable
HOSTNAME=$(hostname)

# Determine if the server is critical
if [[ " ${CRITICAL_SERVERS[@]} " =~ " ${HOSTNAME} " ]]; then
    HOST_COLOR="${DARK_RED_BG}${WHITE}"
else
    HOST_COLOR="${YELLOW}"
fi

# Set the PS1 prompt
# export PS1="\u@${HOST_COLOR}\h${RESET} \w > "
export PS1="\n┌──(\u@${HOST_COLOR}\h${RESET})-[${BLUE}\w${RESET}]\n└─\$ "

# Add a blank line after each command
PROMPT_COMMAND='echo "";'

# Increase history size (in memory)
export HISTSIZE=10000 # Number of commands stored in memory

# Increase history file size (on disk)
export HISTFILESIZE=50000 # Max number of commands stored in ~/.bash_history

# Set custom history file location (optional)
export HISTFILE=~/.bash_history  # Change this path if needed