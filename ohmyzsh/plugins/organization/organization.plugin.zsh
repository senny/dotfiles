function h () {
  cd ~/$1;
}

function c () {
  cd ~/Projects/$1;
}

function _h () {
  _files -W ~ -/
}

function _c () {
  _files -W ~/Projects -/
}

compdef _h h
compdef _c c
