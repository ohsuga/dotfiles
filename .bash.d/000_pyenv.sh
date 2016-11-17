if which pyenv >& /dev/null; then
  if is_mac; then
    export PYENV_ROOT=/usr/local/var/pyenv
  fi
  eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
