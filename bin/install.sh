#!/bin/sh

SRC_DIR="${HOME}/.dotfiles"
SRC_DIRS=(${SRC_DIR})
DOT_DIRS=(".bash.d" ".atom")
IGNORE_FILES=(".git" ".DS_Store")

# mkdir DOT_DIRS if not exist
for d in ${DOT_DIRS[@]}; do
  path="${HOME}/${d}"
  if [ ! -d "${path}" ]; then
    mkdir "${path}"
  fi
  SRC_DIRS+=($SRC_DIR/${d})
done

# ln -s SRC_DIR/files $HOME/files (ignore IGNORE_FILES)
for d in ${SRC_DIRS[@]}; do
  for f in `\find ${d} -maxdepth 1 -type f`; do
    fname=${f##*/}
    for ignore in ${IGNORE_FILES[@]}; do
      [[ ${fname} == ${ignore} ]] && continue 2
    done
    dest=${f/${SRC_DIR}/${HOME}}
    ln -s $f ${dest}
  done
done

source ~/.bash_profile

# install mac brews
if is_mac; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  cd ${SRC_DIR}
  brew tap Homebrew/bundle
  brew bundle
fi
