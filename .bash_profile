#!/bin/bash
if [ -f /etc/bash_profile ]; then
  source /etc/bash_profile
fi

function is_mac {
  if [[ `uname` == Darwin ]] ; then
    return 0
  fi
  return 1
}
function is_win {
  if [[ `uname` == MINGW* ]]; then
    return 0
  fi
  return 1
}
function is_linux {
  if [[ `uname` == Linux ]]; then
    return 0
  fi
  return 1
}

export LANG=ja_JP.UTF-8

if [ -d "${HOME}/.bash.d" -a "$(ls ${HOME}/.bash.d/*.sh 2>/dev/null)" != '' ] ; then
  for f in "${HOME}"/.bash.d/*.sh ; do
    source "$f"
  done
  unset f
fi

if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
