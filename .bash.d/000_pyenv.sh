export PATH=$HOME/.local/bin/:$PATH
if is_mac; then
  export PYENV_ROOT=/usr/local/var/pyenv
else
  export PYENV_ROOT="$HOME/.pyenv"
fi
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv >& /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
