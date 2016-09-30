if [[ `uname` = MINGW* ]]; then
  PS1='[\u@\h:$MSYSTEM] \w\n\$ '
  
  function wincmd() {
    CMD=$1
    shift
    $CMD $* 2>&1 | iconv -f cp932 -t utf-8
  }
  alias ipconfig='wincmd ipconfig'
  alias netstat='wincmd netstat'
  alias netsh='wincmd netsh'
  alias ping='wincmd ping'
fi
