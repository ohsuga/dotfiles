#!/bin/sh

SRC_DIR="${HOME}/.dotfiles"
SRC_DIRS=(${SRC_DIR})
DOT_DIRS=(".bash.d" ".vim" ".vim/cache/dein" ".vim/rc" ".vms/pdev")
IGNORE_FILES=(".git" ".DS_Store" "README.md")
MAC_FILES=("Brewfile")
WIN_FILES=("packages.config")

# mkdir DOT_DIRS if not exist
for d in ${DOT_DIRS[@]}; do
  path="${HOME}/${d}"
  if [ ! -d "${path}" ]; then
    mkdir -p "${path}"
  fi
  SRC_DIRS+=($SRC_DIR/${d})
done

source ${SRC_DIR}/.bash_profile

# ln -s SRC_DIR/files $HOME/files (ignore IGNORE_FILES)
ts=`date +'%Y%m%d_%H%M%S'`
for d in ${SRC_DIRS[@]}; do
  for f in `\find ${d} -maxdepth 1 -type f`; do
    fname=${f##*/}
    for ignore in ${IGNORE_FILES[@]}; do
      [[ ${fname} == ${ignore} ]] && continue 2
    done
    if [[ " ${IGNORE_FILES[@]} " =~ " ${fname} " ]]; then
      continue
    fi
    if ! is_mac && [[ " ${MAC_FILES[@]} " =~ " ${fname} " ]]; then
      continue
    fi
    if ! is_win && [[ " ${WIN_FILES[@]} " =~ " ${fname} " ]]; then
      continue
    fi
    dest=${f/${SRC_DIR}/${HOME}}
    if [ -f "$dest" ]; then
      mv "$dest" "$dest".bak.${ts}
    fi
    ln -s $f ${dest}
  done
done

source ${SRC_DIR}/.bash_profile

# install mac brews
if is_mac; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  cd ${SRC_DIR}
  xcode-select --install
  brew tap Homebrew/bundle
  brew link autoconf pkg-config
  brew bundle
  source ${SRC_DIR}/.bash_profile # enable pyenv & scalaenv
  PYTHON_CONFIGURE_OPTS="--enable-shared" \
    LDSHARED="clang -bundle" \
    LDCXXSHARED="clang++ -bundle" \
    BLDSHARED="clang -bundle -lpython2.7" \
    pyenv install 2.7.11
  PYTHON_CONFIGURE_OPTS="--enable-shared" \
    LDSHARED="clang -bundle" \
    LDCXXSHARED="clang++ -bundle" \
    BLDSHARED="clang -bundle -lpython3.5m" \
    pyenv install 3.5.2

  if [ ! -d ~/.vms/pdev/.vagrant ]; then
    vagrant up
  fi
fi

# config win
if is_win; then
  reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -v HideFileExt -t REG_DWORD -d 0 -f
  cd ~/.vms/pdev
  vagrant up
fi

if ! is_mac; then
  rm -f ~/Brewfile
fi

if ! is_win; then
  rm -f ~/packages.config
fi
