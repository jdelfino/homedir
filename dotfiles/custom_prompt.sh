#!/bin/bash

# The hostname for your personal computer, used to color remote prompts differently
PERSONAL_HOSTNAME="jdelfino-laptop"
# Set this to the parent dir of your git checkouts. It will be dropped to keep the prompt dir
# shorter when you are inside a checkout.
CODE_ROOT="/canopy"

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

kube_prompt ()
{
  if [[ $(type -P "kubectl") ]]; then
    kc=$(kubectl config current-context)
    echo "$kc"
  fi
}

function prompt_command {
  TERMWIDTH=${COLUMNS}

  usernam=$(whoami)
  newPWD="${PWD}"

  git_context="$(git_prompt)"
  kube_context="$(kube_prompt)"

  newPWD="$(echo -n $newPWD | sed -E -e "s|$CODE_ROOT/([^/]*)/?|\1//|")"

  hostnam=$(echo -n $HOSTNAME)
  case "$hostnam" in
    ${PERSONAL_HOSTNAME}*) hostnam="" ;;
    *) hostnam=@$hostnam ;;
  esac

  let promptsize=$(echo -n "--(${usernam}@${hostnam})-(${kube_context})-(${git_context})--($newPWD)--" \
                   | wc -c | tr -d " ")
  let fillsize=${TERMWIDTH}-${promptsize}
  fill=""
  while [ "$fillsize" -gt "0" ]; do
    fill="${fill}-"
  	let fillsize=${fillsize}-1
  done

  if [ "$fillsize" -lt "0" ]; then
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
    ${PERSONAL_HOSTNAME}*) PROMPT_COLOR=$GREEN ;;
    *) PROMPT_COLOR=$BLUE ;;
  esac

  case $TERM in
    xterm*)
      TITLEBAR='\[\033]0;\u@\h:\w\007\]' ;;
    *)
      TITLEBAR="" ;;
  esac

  PS1="$TITLEBAR\
${PROMPT_COLOR}-${WHITE}-(${PROMPT_COLOR}\${usernam}${PROMPT_COLOR}\${hostnam}${WHITE})-\
${PROMPT_COLOR}-\${fill}\
${WHITE}-(${PROMPT_COLOR}\$kube_context${WHITE})-\
${WHITE}(${PROMPT_COLOR}\$git_context${WHITE})-\
${WHITE}(${PROMPT_COLOR}\${newPWD}${WHITE})-\
${PROMPT_COLOR}-\
\n\
${PROMPT_COLOR}-- $(date +%H:%M)${WHITE} ${WHITE}\$${WHITE}\
${NO_COLOUR} "

  PS2="$WHITE-$YELLOW-$YELLOW-$NO_COLOUR "
}
twtty
