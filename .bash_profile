if [ -d "${HOME}/.bash.d" -a "$(ls ${HOME}/.bash.d/*.sh)" != '' ] ; then
  for f in "${HOME}"/.bash.d/*.sh ; do
    source "$f"
  done
  unset f
fi

if [ -f "${home}/.bashrc" ] ; then
  source "${home}/.bashrc"
fi
