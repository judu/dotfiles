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
  bindkey '[3~' delete-char
  bindkey '[4~' end-of-line
  bindkey '[1~' beginning-of-line
  # On remappe pour le bépo
  bindkey -a c vi-backward-char
  bindkey -a r vi-forward-char
  bindkey -a t vi-down-line-or-history
  bindkey -a s vi-up-line-or-history
  bindkey -a $ vi-end-of-line
  bindkey -a 0 vi-digit-or-beginning-of-line 
  bindkey -a h vi-change
  bindkey -a H vi-change-eol
  bindkey -a dd vi-change-whole-line
  bindkey -a l vi-replace-chars
  bindkey -a L vi-replace
  bindkey -a k vi-substitute

  # On remet le ^r pour l'historique
  bindkey -M viins '^r' history-incremental-search-backward
  bindkey -M vicmd '' history-incremental-search-backward

  autoload -U zmv

  alias ssh='autossh -M 0'
  alias g='git'
  alias mmv='noglob zmv -W'
  alias tree='tree -uh'
  alias showbig='du -sh * | grep -e "^[0-9,]\+G"'

  c-c () {
	  cd ~/projets/clever-cloud/$1
  }

  export AKKA_HOME=/opt/akka-actors-1.1.2


  ## For esound and pulse
  #if [ ! -e /tmp/.esd-${UID} ]; then
  #  ln -s /tmp/.esd /tmp/.esd-${UID}
  #fi
  #
  export PATH=$PATH:~/.local/bin

  export M2_HOME=/usr/share/maven-bin-3.0
fi
