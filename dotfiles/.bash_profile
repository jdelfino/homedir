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
source ~/bazel-complete.bash
source ~/git-completion.bash

export GOPATH=~/go
export GOROOT=/usr/local/go
export PATH=~/bin:/usr/local/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/.linkerd2/bin:$PATH
export VIRTUAL_ENV_DISABLE_PROMPT=1
export SPOTIFY_CLIENT_SECRET=a23a06b6acf4483589cdb1ba050fdcc5
export WORKON_HOME=~/venv
export ANDROID_HOME=~/Library/Android/sdk
source /usr/local/bin/virtualenvwrapper.sh

eval "$(ssh-agent -s)" > /dev/null 2>&1

alias ops='eval $(op signin canopy_team)'
alias cgrep='grep --exclude-dir "bazel*" --exclude-dir "tulsi*"'


[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/canopy/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/canopy/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/canopy/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/canopy/google-cloud-sdk/completion.bash.inc'; fi

