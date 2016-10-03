if which scalaenv >& /dev/null; then
  if is_mac; then
    export SCALAENV_ROOT=/usr/local/var/scalaenv
  fi
  eval "$(scalaenv init -)"
fi
