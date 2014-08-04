# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export SVN_EDITOR=emacs
export EDITOR=emacs

alias wcgrep='ack'
export TAW=tawiki.org
alias ctaw='ssh $TAW' # Connect TA Wiki

source ~/custom_prompt.sh
source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=/usr/local/bin:$PATH



#infinio stuff
export IDEV=jdelfino-dev.infinio.com
alias cinf='ssh $IDEV'

# The next line updates PATH for the Google Cloud SDK.
source '/Users/jdelfino/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/jdelfino/google-cloud-sdk/completion.bash.inc'
