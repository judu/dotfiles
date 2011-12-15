if [ -z "${TMUX:+x}" ]; then
  tmux -u2 a || tmux -u2
else

  . /etc/zsh/zprofile

  bindkey -v
  local _myhosts
  if [ -d ~/.ssh ]; then
    if [ -f ~/.ssh/known_hosts ];then
      _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
    fi
  fi

  zstyle ':completion:*' hosts $_myhosts
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts $_myhosts

  bindkey -a 'b' backward-word
  bindkey -a 'é' forward-word
  bindkey -a 'c' backward-char
  bindkey -a 'r' forward-char
  bindkey '[3~' delete-char
  bindkey '[4~' end-of-line
  bindkey '[1~' beginning-of-line

  # On remet le ^r pour l'historique
  bindkey -M viins '^r' history-incremental-search-backward
  bindkey -M vicmd '' history-incremental-search-backward

  autoload -U zmv

  alias ssh='autossh -M 0'
  alias g='git'
  alias mmv='noglob zmv -W'
  alias tree='tree -uh'

  export AKKA_HOME=/opt/akka-actors-1.1.2


  ## For esound and pulse
  #if [ ! -e /tmp/.esd-${UID} ]; then
  #  ln -s /tmp/.esd /tmp/.esd-${UID}
  #fi
  #

  export PATH=$PATH:~/.local/bin
fi
