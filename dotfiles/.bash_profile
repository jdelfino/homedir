# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
if [ -f ~/.profile ]; then
    source ~/.profile
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export EDITOR=nano

alias wcgrep='ack'

source ~/custom_prompt.sh

export PATH=~/bin:/usr/local/bin:$PATH

eval "$(ssh-agent -s)"
