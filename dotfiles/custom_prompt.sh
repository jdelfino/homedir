#!/bin/bash

#   termwide prompt with tty number
#      by Giles - created 2 November 98
#
#      $Revision: 1.2 $   $Author: giles $
#      $Source: /home/giles/.bashprompt/bashthemes/RCS/twtty,v $
#      $Log: twtty,v $
#      Revision 1.2  1999/03/25 01:37:51  giles
#
#      Revision 1.1  1999/03/25 01:35:26  giles
#      Initial revision
#
#     This is a variant on "termwide" that incorporates the tty number.
#
#     24 March 99 - use of sed with \{$cut\} where $cut is an integer
#     means that this probably now requires a GNU version of sed.

git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_cleanit_dirty}
  fi

  echo "$git_color$git_branch${c_reset}"
}

function prompt_command {

TERMWIDTH=${COLUMNS}

usernam=$(whoami)
newPWD="${PWD}"

virtualenv="${VIRTUAL_ENV_NAME}"
if [ "${virtualenv}" == "" ]
then
    context="$(git_prompt)"
else
    context="${virtualenv}"
fi

newPWD="$(echo -n $newPWD | sed -e "s|/Users/jdelfino/dev/proj/$virtualenv/|\.\.\./|")"

hostnam=$(echo -n $HOSTNAME)
case "$hostnam" in
    jdelfino-laptop*) hostnam="" ;;
    *) hostnam=@$hostnam ;;
esac

let promptsize=$(echo -n "--(${usernam}@${hostnam})-(${context})--($newPWD)--" \
                 | wc -c | tr -d " ")
let fillsize=${TERMWIDTH}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}-"
	let fillsize=${fillsize}-1
done

if [ "$fillsize" -lt "0" ]
then
   let cut=3-${fillsize}
	newPWD="...$(echo -n $newPWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
fi

}

PROMPT_COMMAND=prompt_command

function twtty {

local WHITE="\[\033[1;37m\]"
local YELLOW="\[\033[0;32m\]"
local NO_COLOUR="\[\033[0m\]"
local CYAN="\[\033[0;36m\]"
local LIGHT_CYAN="\[\033[1;36m\]"
local GREEN="\[\033[0;32m\]"
local LIGHT_GREEN="\[\033[1;32m\]"
local YELLOW="\[\033[1;33m\]"
local PURPLE="\[\033[0;35m\]"
local BLUE="\[\033[0;34m\]"

hostnam=$(echo -n $HOSTNAME)
case "$hostnam" in
    jdelfino-laptop*) PROMPT_COLOR=$GREEN ;;
    *.p.echonest.net) PROMPT_COLOR=$PURPLE ;;
    *) PROMPT_COLOR=$BLUE ;;
esac

case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="$TITLEBAR\
${PROMPT_COLOR}-${WHITE}-(${PROMPT_COLOR}\${usernam}${PROMPT_COLOR}\${hostnam}${WHITE})-\
${PROMPT_COLOR}-\${fill}\
${WHITE}-(${PROMPT_COLOR}\$context${WHITE})-\
${WHITE}(${PROMPT_COLOR}\${newPWD}${WHITE})-\
${PROMPT_COLOR}-\
\n\
${PROMPT_COLOR}-- $(date +%H:%M)${WHITE} ${WHITE}\$${WHITE}\
${NO_COLOUR} "

PS2="$WHITE-$YELLOW-$YELLOW-$NO_COLOUR "

}

twtty
