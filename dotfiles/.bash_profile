# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export EDITOR=nano

alias wcgrep='ack'

source ~/custom_prompt.sh
source ~/.profile
